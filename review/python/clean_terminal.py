# read the file
import glob,os
import re


def clean_files_in_folder(folder):
    os.chdir(folder)
    for file in glob.glob("*.log"):
        cmd = get_commands_by_line(file)
        print cmd
    print cmd


def get_commands_by_line(file):
    command_list = []
    with open(file) as f:
        for line in f:
            m = re.compile('\w+@\w+:.*')
            matched = m.match(line)
            if matched :
                command_list.append(re.sub('\w+@\w+:.*>','',line).rstrip('\n').lstrip())
    f.close
    return command_list



def main():
    clean_files_in_folder("D:\puttylog")

if __name__ == "__main__":
    main()
