searchPath = [czi_path ,'\**\*.czi']; % Search in folder and subfolders for  *.csv
CZI_File      = dir(searchPath); % Find all .csv files
for k = 1 : length(CZI_File)
    baseFileName = CZI_File(k).name;
end