import os
import zipfile
import concurrent.futures

def zip(parent_dir, ignore_substring="", num_retries=3):
    print(f"Zipping all directories in {parent_dir} that do not contain {ignore_substring}...")

    # Find all directories in the parent directory that do not contain the ignore substring
    # dirs = [d for d in os.listdir(parent_dir) if os.path.isdir(os.path.join(parent_dir, d)) and ignore_substring.lower() not in d.lower()]
    if ignore_substring == "":
        dirs = [os.path.join(parent_dir, d) for d in os.listdir(parent_dir) if os.path.isdir(os.path.join(parent_dir, d))]
    else:
        dirs = [os.path.join(parent_dir, d) for d in os.listdir(parent_dir) if os.path.isdir(os.path.join(parent_dir, d)) and ignore_substring.lower() not in d.lower()]

    
    print(f"Found {len(dirs)} directories to zip: {dirs}")

    # Define a function to create a zip file for a given directory, with retry logic
    def create_zip_file_with_retry(dir_name):
        # zip_filename = f"{dir_name}.zip"
        zip_filename = os.path.join(os.path.dirname(dir_name), f"{os.path.basename(dir_name)}.zip")
        
        for i in range(num_retries):
            try:
                with zipfile.ZipFile(zip_filename, "w") as zip:
                    print(f"Creating zip file for {dir_name}...")
                    for root, _, files in os.walk(dir_name):
                        print(f"root: {root}, files: {files}")
                        for file in files:
                            print(f"root: {root}, file: {file}")
                            zip.write(os.path.join(root, file))
                break  # Break out of retry loop if zip file creation succeeds
            except Exception as exc:
                print(f"Exception occurred while creating zip file for {dir_name}, retrying ({i+1}/{num_retries})")
                if i == num_retries - 1:
                    print(f"Maximum retries reached for {dir_name}, skipping")
                    raise exc  # If max retries reached, raise the last exception
    
    # Create a thread pool and use it to create zip files for each directory
    with concurrent.futures.ThreadPoolExecutor() as executor:
        # futures = [executor.submit(create_zip_file_with_retry, dir_name) for dir_name in dirs]
        futures = [executor.submit(create_zip_file_with_retry, dir_path) for dir_path in dirs]

        for future in concurrent.futures.as_completed(futures):
            # Print any exceptions raised during zip file creation
            exc = future.exception()
            if exc is not None:
                print(f"Exception occurred while creating zip file: {exc}")
