function filenames = alt_filefinder(filePath,regexpStr, sub_folder)
files = dir(strcat(filePath, regexpStr));
len = length(files);
final_files = [""];
final_subjects = [""];
for i=1:len
    disp(files(i).folder);
    disp(files(i).name);
    final_files(i+1) = strcat(files(i).folder,"/", files(i).name);
end
if sub_folder~=""
    subject_folders = alt_filefinder(filePath, sub_folder, "");
    disp(subject_folders);
    filenames = [final_files, subject_folders];
else
    filenames = [final_files];
end

