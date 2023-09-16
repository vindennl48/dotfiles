import os, datetime
from pydrive2.auth      import GoogleAuth
from pydrive2.drive     import GoogleDrive
from tqdm               import tqdm
from pathlib            import Path
from concurrent.futures import ThreadPoolExecutor

class Drive:
    @staticmethod
    def get_current_date():
        return datetime.datetime.now().strftime('%y%m%d')

    def __init__(self, root_id, credentials_path, num_threads=8):
        self.gauth = GoogleAuth()
        self.gauth.LoadCredentialsFile(credentials_path)

        if self.gauth.credentials is None:
            self.gauth.LocalWebserverAuth()
            self.gauth.SaveCredentialsFile(credentials_path)
        elif self.gauth.access_token_expired:
            self.gauth.Refresh()
            self.gauth.SaveCredentialsFile(credentials_path)
        else:
            self.gauth.Authorize()

        self.d           = GoogleDrive(self.gauth)
        self.root_id     = root_id
        self.num_threads = num_threads

    def create_folder(self, folder_name, parent_id=None):
        if parent_id is None:
            parent_id = self.root_id
        query = f"'{parent_id}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false and title='{folder_name}'" 
        existing_folders = self.d.ListFile({'q': query}).GetList()
        if existing_folders:
            return existing_folders[0]['id']
        else:
            folder = self.d.CreateFile({"title": folder_name, "mimeType": "application/vnd.google-apps.folder", "parents": [{"kind": "drive#fileLink", "id": parent_id}]})
            folder.Upload()
            return folder["id"]

    def upload_file(self, file_path, file_name, parent_id=None, max_retries=5):
        if parent_id is None:
            parent_id = self.root_id
        for i in range(max_retries):
            try:
                # check if file already exists
                query = f"'{parent_id}' in parents and trashed=false and title='{file_name}'" 
                existing_files = self.d.ListFile({'q': query}).GetList()
                if existing_files:
                    file = self.d.CreateFile({'title': file_name, 'id': existing_files[0]['id']})
                else:
                    file = self.d.CreateFile({'title': file_name, 'parents': [{'id': parent_id}]})

                file.SetContentFile(str(file_path))
                file.Upload()
                return file['alternateLink']
            except Exception as e:
                if i == max_retries - 1:
                    print(f"Error uploading file {str(file_path)}: {str(e)}")
                else:
                    print(f"Error uploading file {str(file_path)}. Retrying...")

    #  # OLDER VERSION
    #  def upload_file(self, file_path, file_name, parent_id=None, max_retries=5):
    #      if parent_id is None:
    #          parent_id = self.root_id
    #      for i in range(max_retries):
    #          try:
    #              file = self.d.CreateFile({'title': file_name, 'parents': [{'id': parent_id}]})
    #              file.SetContentFile(file_path)
    #              file.Upload()
    #              return file['alternateLink']
    #          except Exception as e:
    #              if i == max_retries - 1:
    #                  print(f"Error uploading file {file_path}: {str(e)}")
    #              else:
    #                  print(f"Error uploading file {file_path}. Retrying...")

    def upload_files(self, files, parent_id=None):
        if parent_id is None:
            parent_id = self.root_id

        print(f"Uploading {len(files)} files to Google Drive...")
        for file in files:
            print(f"Uploading {file}...")
        # wait for user to press enter
        #  input("Press Enter to continue...")

        file_urls = []
        with ThreadPoolExecutor(max_workers=self.num_threads) as executor:
            futures = []
            for file in files:
                file = Path(file)
                futures.append(executor.submit(self.upload_file, file, file.name, parent_id))
            for future in tqdm(futures, total=len(futures)):
                file_urls.append(future.result())
        return file_urls

    def upload_files_different_parents(self, files):
        print(f"Uploading {len(files)} files to Google Drive...")
        for file in files:
            print(f"Uploading {file}...")
        # wait for user to press enter
        #  input("Press Enter to continue...")

        file_urls = []
        with ThreadPoolExecutor(max_workers=self.num_threads) as executor:
            futures = []
            for file_pair in files:
                file      = Path(file_pair[0])
                parent_id = file_pair[1]
                futures.append(executor.submit(self.upload_file, file, file.name, parent_id))
            for future in tqdm(futures, total=len(futures)):
                file_urls.append(future.result())
        return file_urls
