import json
import argparse

def convert_json_to_config(json_file, config_file):
    # Load JSON data
    with open(json_file, 'r') as file:
        data = json.load(file)
    
    channels = data["channels"]
    map_size = len(channels)
    
    # Prepare the config file content
    config_lines = []
    
    for i, channel in enumerate(channels):
        hardware_number, name = channel
        config_lines.append(f"ch{i}={hardware_number}")
    
    for i, channel in enumerate(channels):
        _, name = channel
        config_lines.append(f"name{i}={name}")
    
    config_lines.append(f"map_size={map_size}")
    config_lines.append("map_hwnch=0")
    
    # Write to config file
    with open(config_file, 'w') as file:
        file.write("\n".join(config_lines))

def main():
    parser = argparse.ArgumentParser(description="Convert JSON to config file")
    parser.add_argument("json_file", help="Path to the JSON input file")
    parser.add_argument("config_file", help="Path to the output config file")
    args = parser.parse_args()
    
    convert_json_to_config(args.json_file, args.config_file)

if __name__ == "__main__":
    main()

