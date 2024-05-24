import argparse
import os

def concatenate_files(files, output_file, recursive, line_char):
    with open(output_file, 'w') as outfile:
        for file_path in files:
            if os.path.isdir(file_path) and recursive:
                for root, _, filenames in os.walk(file_path):
                    for filename in filenames:
                        write_file_content(os.path.join(root, filename), outfile, line_char)
            elif os.path.isdir(file_path) and not recursive:
                for filename in os.listdir(file_path):
                    write_file_content(os.path.join(file_path, filename), outfile, line_char)
            else:
                write_file_content(file_path, outfile, line_char)

def write_file_content(file_path, outfile, line_char):
    if os.path.isfile(file_path):
        print(f'Processing file: {file_path}')
        outfile.write(f'{line_char} {file_path}\n')
        outfile.write(line_char * 80 + '\n')
        with open(file_path, 'r') as infile:
            for line in infile:
                outfile.write(line)
        outfile.write('\n\n')
    else:
        print(f'Skipping non-file: {file_path}')

def main():
    parser = argparse.ArgumentParser(prog='concatenate')
    parser.add_argument('paths', nargs='+', help='Directory or files to concatenate')
    parser.add_argument('--no-recursive', action='store_true', help='Do not search directories recursively')
    parser.add_argument('--line-char', default='#', help='Character to use for the separation line, defaults to "#"')
    
    args = parser.parse_args()
    files = args.paths
    output_file = 'Concatenated.txt'
    recursive = not args.no_recursive
    line_char = args.line_char

    print(f'Starting concatenation into {output_file}')
    concatenate_files(files, output_file, recursive, line_char)
    print(f'Concatenation completed and written to {output_file}')

if __name__ == "__main__":
    main()

