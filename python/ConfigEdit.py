from Files import Files

#  REAPER_INI_PATH = Files.newPath("/Users/mitch/Library/Application Support/REAPER/reaper.ini")

def ini_to_dict(path_as_str):
    ini     = {}
    new_ini = {}
    with open(str(path_as_str), 'r') as f:
        ini = f.read()

    lines = ini.split('\n')

    section = "UNKNOWN"
    for i in range(len(lines)):
        if lines[i].startswith('['): #]
            section = lines[i].strip('[]')
            new_ini[section] = {}
        else:
            if lines[i] != '':
                try:
                    key, value = lines[i].split('=')
                    new_ini[section][key] = value.strip()
                except:
                    print(f"--> Error in line: {lines[i]}")

    return new_ini

def dict_to_ini(path_as_str, new_ini):
    with open(str(path_as_str), 'w') as f:
        for section in new_ini:
            f.write(f"[{section}]\n")
            for key in new_ini[section]:
                f.write(f"{key}={new_ini[section][key]}\n")
            f.write("\n")

def parse_custom_config(file_path):
    config = {
        "inputs": {},
        "outputs": {}
    }
    errors = []
    
    with open(file_path, 'r') as f:
        for line_num, line in enumerate(f, 1):  # Line numbers start at 1
            stripped_line = line.strip()
            if not stripped_line or stripped_line.startswith('#'):
                continue
            
            # Check if line starts with 'i' or 'o'
            if stripped_line[0] not in ('i', 'o'):
                errors.append({
                    'line': line_num,
                    'message': "Line must start with 'i' for input or 'o' for output."
                })
                continue
            
            config_type = 'inputs' if stripped_line[0] == 'i' else 'outputs'
            remaining = stripped_line[1:]
            
            # Split into port part and name part
            split_result = remaining.split(' ', 1)
            port_part = split_result[0] if split_result else ''
            name_part = split_result[1].strip() if len(split_result) > 1 else ''
            
            if not port_part:
                errors.append({
                    'line': line_num,
                    'message': "Port information is missing after 'i'/'o'."
                })
                continue
            
            # Split port into software and hardware components
            port_components = port_part.split('.')
            if len(port_components) != 2:
                errors.append({
                    'line': line_num,
                    'message': f"Invalid port format '{port_part}'. Expected format 'X.Y' where X is software port and Y is hardware port."
                })
                continue
            
            sw_port, hw_port = port_components
            try:
                hw_int = int(hw_port)
            except ValueError:
                errors.append({
                    'line': line_num,
                    'message': f"Hardware port '{hw_port}' is not a valid integer."
                })
                continue
            
            # Check for duplicate software ports
            if sw_port in config[config_type]:
                errors.append({
                    'line': line_num,
                    'message': f"Software port '{sw_port}' is already defined in {config_type}."
                })
                continue
            
            # Add to config if no errors
            config[config_type][sw_port] = {
                'hw': hw_int,
                'name': name_part
            }
    
    if errors:
        error_msg = "Configuration file errors found:\n" + "\n".join(
            f"Line {err['line']}: {err['message']}" for err in errors
        )
        raise ValueError(error_msg)
    
    return config

if __name__ == "__main__":
    config_path = "/Users/mitch/Desktop/testconfig.cfg"
    config = parse_custom_config(config_path)
    print(config)
