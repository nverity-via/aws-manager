import os

# change this to where you want menu scripts to be callable
# recommended to put it somewhere in your $PATH or add it to your $PATH
bin_path = "/home/nick/Scripts/bin"
bin_path = "/home/nick/Git/DevSetup/scripts"


files = os.listdir(".")
csvs = []
csvs_names = os.listdir("csvs")
#print(csvs_names)
for csv in csvs_names:
    csvs.append(os.path.abspath(os.path.join("csvs",csv)))

for file in files:
    if ".csv" in file and file not in csvs_names:
        csvs_names.append(file)
        csvs.append(os.path.abspath(file))

#print(csvs)
#print(csvs_names)


with open("tmpl","r") as tmpl:
    template = tmpl.read()

#print(template)
for csv in csvs:
    #print(os.path.join(bin_path,os.path.basename(csv).replace(".csv","")))
    file_to_make = os.path.join(bin_path,os.path.basename(csv).replace(".csv",""))
    content = template.replace("PH",csv)
    #print(content)
    with open(file_to_make,"w") as ftm:
        ftm.write(content)
        ftm.close()
    os.chmod(file_to_make, 0o775)

