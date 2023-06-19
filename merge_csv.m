cc
target_file_folder = 'C:\Users\yycxx\OneDrive - OIST\Thesis\Behaviour\Thirteenth_Batch\TbxAi32_72\Recording';
current_file_location = 'C:\Users\yycxx\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Useful_Functions';
%% n = 2
filename1 = 'Day18_1vs0_150msvs150msDelay_5ms_50Hz_25mW_TbxAi32_72_230601150814.csv';
filename2 = 'Day18_1vs0_150msvs150msDelay_5ms_50Hz_25mW_TbxAi32_72_230601153058.csv';
cd(target_file_folder)
csv1 = csvread(filename1);
csv2 = csvread(filename2);
allCsv = [csv1;csv2]; % Concatenate vertically
% %% n = 3
% filename1 = 'Day14_3vs3_80msvs130msDelay_5ms_50Hz_25mW_TbxAi32_76_230530165917.csv';
% filename2 = 'Day14_3vs3_80msvs130msDelay_5ms_50Hz_25mW_TbxAi32_76_230530171034.csv';
% filename3 = 'Day14_3vs3_80msvs130msDelay_5ms_50Hz_25mW_TbxAi32_76_230530171135.csv';
% cd(target_file_folder)
% csv1 = csvread(filename1);
% csv2 = csvread(filename2);
% csv3 = csvread(filename3);
% allCsv = [csv1;csv2;csv3]; % Concatenate vertically
%%

outputFileName = 'Day18_1vs0_150msvs150msDelay_5ms_50Hz_25mW_TbxAi32_72_230601150814_230601153058.csv';
csvwrite(outputFileName, allCsv);

% save a record in the target folder
copyfile (fullfile(current_file_location, 'merge_csv.m'),target_file_folder)
newname = sprintf('merge_csv%s.m',datestr(datetime("now"),30));
eval(['!rename' 32 '"merge_csv.m"' 32 '"' newname '"' ]);
% csv1 = csvread(filename1);
% csv2 = csvread(filename2);
% csv3 = csvread(filename3);
% allCsv = [csv1;csv2;csv3]; % Concatenate vertically
% csvwrite(outputFileName, allCsv);