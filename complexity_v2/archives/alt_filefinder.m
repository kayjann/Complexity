function filenames = alt_filefinder(filePath,regexpStr, sub_folder)
files = dir(strcat(filePath, regexpStr));
len = length(files);
final_files = [""];
final_subjects = [""];

for i=1:len
    final_files(i+1) = strcat(files(i).folder,"/", files(i).name);
    final_subjects(i)=(files(i).folder);
end
if sub_folder~=""
    subject_folders = alt_filefinder(filePath, sub_folder, "");
    filenames = [final_files, subject_folders];
else
    filenames = [final_files];
end

A = unique(final_subjects,'stable');
filenames=A;
end

