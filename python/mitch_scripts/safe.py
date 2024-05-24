import argparse
import hashlib
import os
import getpass
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import padding

decrypted_extension = '.DECRYPTED'
encrypted_extension = '.bin'

def silent_print(*args, **kwargs):
    if not global_args.silent:
        print(*args, **kwargs)

def derive_key(password: str) -> bytes:
    silent_print("Deriving key from password using SHA-256...")
    return hashlib.sha256(password.encode()).digest()

def encrypt_file(filename: str, password: str):
    key = derive_key(password)
    backend = default_backend()

    silent_print(f"Reading data from {filename}...")
    with open(filename, 'rb') as f:
        data = f.read()

    silent_print("Padding data...")
    padder = padding.PKCS7(algorithms.AES.block_size).padder()
    padded_data = padder.update(data) + padder.finalize()

    iv = os.urandom(16)
    silent_print(f"Generated IV: {iv.hex()}")
    cipher = Cipher(algorithms.AES(key), modes.CFB(iv), backend=backend)
    encryptor = cipher.encryptor()
    encrypted_data = iv + encryptor.update(padded_data) + encryptor.finalize()

    encrypted_filename = f'{os.path.splitext(filename)[0]}{encrypted_extension}'
    silent_print(f"Writing encrypted data to {encrypted_filename}...")
    with open(encrypted_filename, 'wb') as f:
        f.write(encrypted_data)
    silent_print(f'File encrypted successfully as {encrypted_filename}')

def decrypt_file(filename: str, password: str):
    key = derive_key(password)
    backend = default_backend()

    silent_print(f"Reading data from {filename}...")
    with open(filename, 'rb') as f:
        data = f.read()

    iv = data[:16]
    silent_print(f"Extracted IV: {iv.hex()}")
    cipher = Cipher(algorithms.AES(key), modes.CFB(iv), backend=backend)
    decryptor = cipher.decryptor()
    decrypted_padded_data = decryptor.update(data[16:]) + decryptor.finalize()

    silent_print("Removing padding from decrypted data...")
    unpadder = padding.PKCS7(algorithms.AES.block_size).unpadder()
    decrypted_data = unpadder.update(decrypted_padded_data) + unpadder.finalize()

    decrypted_filename = f'{os.path.splitext(filename)[0]}{decrypted_extension}'
    silent_print(f"Writing decrypted data to {decrypted_filename}...")
    with open(decrypted_filename, 'wb') as f:
        f.write(decrypted_data)
    silent_print(f'File decrypted successfully as {decrypted_filename}')

def remove_original_files(filenames):
    if global_args.silent:
        for filename in filenames:
            os.remove(filename)
            silent_print(f"Original file {filename} removed.")
    else:
        response = input(f"Do you want to remove the original files? (yes/no): ").strip().lower()
        if response == 'yes':
            for filename in filenames:
                os.remove(filename)
                silent_print(f"Original file {filename} removed.")
        else:
            silent_print("Original files retained.")

def get_password():
    while True:
        password = getpass.getpass('Enter password: ')
        confirm_password = getpass.getpass('Confirm password: ')
        if password == confirm_password:
            return password
        else:
            silent_print("Passwords do not match. Please try again.")

def collect_files(paths):
    files_to_process = []
    for path in paths:
        if os.path.isfile(path):
            if path.endswith(decrypted_extension) or path.endswith(encrypted_extension):
                files_to_process.append(path)
        elif os.path.isdir(path):
            for root, _, files in os.walk(path):
                for file in files:
                    if file.endswith(decrypted_extension) or file.endswith(encrypted_extension):
                        files_to_process.append(os.path.join(root, file))
    return files_to_process

def run_safe(paths, mode=None, silent=False):
    global global_args
    global_args = argparse.Namespace(silent=silent)

    files_to_process = collect_files(paths)
    processed_files = []

    if mode == 'encrypt':
        password = get_password()
        for filename in files_to_process:
            if filename.endswith(decrypted_extension):
                encrypt_file(filename, password)
                processed_files.append(filename)
    elif mode == 'decrypt':
        password = getpass.getpass('Enter password: ')
        for filename in files_to_process:
            if filename.endswith(encrypted_extension):
                decrypt_file(filename, password)
                processed_files.append(filename)
    else:
        for filename in files_to_process:
            if filename.endswith(decrypted_extension):
                password = get_password()
                encrypt_file(filename, password)
                processed_files.append(filename)
            elif filename.endswith(encrypted_extension):
                password = getpass.getpass('Enter password: ')
                decrypt_file(filename, password)
                processed_files.append(filename)

    if processed_files:
        remove_original_files(processed_files)

def main():
    parser = argparse.ArgumentParser(description='Encrypt or decrypt files using SHA-256 derived key.')
    parser.add_argument('--mode', choices=['encrypt', 'decrypt', 'auto'], default='auto', help='Force action type, defaults to "auto"')
    parser.add_argument('--silent', action='store_true', help='Enable silent mode to suppress output')
    parser.add_argument('paths', nargs='+', help='Files or folders to convert')

    args = parser.parse_args()

    run_safe(args.paths, mode=args.mode, silent=args.silent)

if __name__ == '__main__':
    main()

# ################################################################################
# import argparse
# import hashlib
# import os
# import getpass
# from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
# from cryptography.hazmat.backends import default_backend
# from cryptography.hazmat.primitives import padding
# 
# decrypted_extension = '.DECRYPTED'
# encrypted_extension = '.bin'
# 
# def silent_print(*args, **kwargs):
#     if not global_args.silent:
#         print(*args, **kwargs)
# 
# def derive_key(password: str) -> bytes:
#     silent_print("Deriving key from password using SHA-256...")
#     return hashlib.sha256(password.encode()).digest()
# 
# def encrypt_file(filename: str, password: str):
#     key = derive_key(password)
#     backend = default_backend()
# 
#     silent_print(f"Reading data from {filename}...")
#     with open(filename, 'rb') as f:
#         data = f.read()
# 
#     silent_print("Padding data...")
#     padder = padding.PKCS7(algorithms.AES.block_size).padder()
#     padded_data = padder.update(data) + padder.finalize()
# 
#     iv = os.urandom(16)
#     silent_print(f"Generated IV: {iv.hex()}")
#     cipher = Cipher(algorithms.AES(key), modes.CFB(iv), backend=backend)
#     encryptor = cipher.encryptor()
#     encrypted_data = iv + encryptor.update(padded_data) + encryptor.finalize()
# 
#     encrypted_filename = f'{os.path.splitext(filename)[0]}{encrypted_extension}'
#     silent_print(f"Writing encrypted data to {encrypted_filename}...")
#     with open(encrypted_filename, 'wb') as f:
#         f.write(encrypted_data)
#     silent_print(f'File encrypted successfully as {encrypted_filename}')
# 
#     remove_original_file(filename)
# 
# def decrypt_file(filename: str, password: str):
#     key = derive_key(password)
#     backend = default_backend()
# 
#     silent_print(f"Reading data from {filename}...")
#     with open(filename, 'rb') as f:
#         data = f.read()
# 
#     iv = data[:16]
#     silent_print(f"Extracted IV: {iv.hex()}")
#     cipher = Cipher(algorithms.AES(key), modes.CFB(iv), backend=backend)
#     decryptor = cipher.decryptor()
#     decrypted_padded_data = decryptor.update(data[16:]) + decryptor.finalize()
# 
#     silent_print("Removing padding from decrypted data...")
#     unpadder = padding.PKCS7(algorithms.AES.block_size).unpadder()
#     decrypted_data = unpadder.update(decrypted_padded_data) + unpadder.finalize()
# 
#     decrypted_filename = f'{os.path.splitext(filename)[0]}{decrypted_extension}'
#     silent_print(f"Writing decrypted data to {decrypted_filename}...")
#     with open(decrypted_filename, 'wb') as f:
#         f.write(decrypted_data)
#     silent_print(f'File decrypted successfully as {decrypted_filename}')
# 
#     remove_original_file(filename)
# 
# def remove_original_file(filename: str):
#     response = input(f"Do you want to remove the original file {filename}? (yes/no): ").strip().lower()
#     if response == 'yes':
#         os.remove(filename)
#         silent_print(f"Original file {filename} removed.")
#     else:
#         silent_print(f"Original file {filename} retained.")
# 
# def get_password():
#     while True:
#         password = getpass.getpass('Enter password: ')
#         confirm_password = getpass.getpass('Confirm password: ')
#         if password == confirm_password:
#             return password
#         else:
#             silent_print("Passwords do not match. Please try again.")
# 
# def collect_files(paths):
#     files_to_process = []
#     for path in paths:
#         if os.path.isfile(path):
#             if path.endswith(decrypted_extension) or path.endswith(encrypted_extension):
#                 files_to_process.append(path)
#         elif os.path.isdir(path):
#             for root, _, files in os.walk(path):
#                 for file in files:
#                     if file.endswith(decrypted_extension) or file.endswith(encrypted_extension):
#                         files_to_process.append(os.path.join(root, file))
#     return files_to_process
# 
# def run_safe(paths, mode=None, silent=False):
#     global global_args
#     global_args = argparse.Namespace(silent=silent)
# 
#     files_to_process = collect_files(paths)
#     
#     if mode == 'encrypt':
#         password = get_password()
#         for filename in files_to_process:
#             if filename.endswith(decrypted_extension):
#                 encrypt_file(filename, password)
#     elif mode == 'decrypt':
#         password = getpass.getpass('Enter password: ')
#         for filename in files_to_process:
#             if filename.endswith(encrypted_extension):
#                 decrypt_file(filename, password)
#     else:
#         for filename in files_to_process:
#             if filename.endswith(decrypted_extension):
#                 password = get_password()
#                 encrypt_file(filename, password)
#             elif filename.endswith(encrypted_extension):
#                 password = getpass.getpass('Enter password: ')
#                 decrypt_file(filename, password)
# 
# def main():
#     parser = argparse.ArgumentParser(description='Encrypt or decrypt files using SHA-256 derived key.')
#     parser.add_argument('--mode', choices=['encrypt', 'decrypt', 'auto'], default='auto', help='Force action type, defaults to "auto"')
#     parser.add_argument('--silent', action='store_true', help='Enable silent mode to suppress output')
#     parser.add_argument('files', nargs='+', help='Files or folders to convert')
# 
#     args = parser.parse_args()
# 
#     run_safe(args.paths, mode=args.mode, silent=args.silent)
# 
# if __name__ == '__main__':
#     main()
