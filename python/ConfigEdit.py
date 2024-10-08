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


#  if __name__ == "__main__":
#      reaper_ini = ini_to_dict(REAPER_INI_PATH)
#
#      new_device = "YoMama"
#      reaper_ini["REAPER"]["coreaudioindevnew"]  = new_device
#      reaper_ini["REAPER"]["coreaudiooutdevnew"] = new_device
#
#      dict_to_ini(REAPER_INI_PATH, reaper_ini)
#
#      #  reaper_ini = replace_variable(reaper_ini, "coreaudioindevnew", new_device)
