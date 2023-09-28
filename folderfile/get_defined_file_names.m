function filenames = get_defined_file_names(folder,Description)
% get_defined_file_names(folder,'latest'): get the name of the latest file
% in the folder

% get_defined_file_names(folder,'last5'): get the name of the last 5 files
% in the folder

% get_defined_file_names(folder,'today'): get the name of all files today

% get_defined_file_names(folder,'yesterday'): get the name of all files
% yesterday

% get_defined_file_names(folder,'All'): get all file names

% get_defined_file_names(folder,'960420'): get all file names created on
% 19960420

% get_defined_file_names(folder,'19960420'): get all file names created on
% 19960420

% get_defined_file_names(folder,'RandomKeyword'): get all file names
% contains the key word

processflag = 0;

if strcmpi(Description,'latest')&& (~processflag)
    filenames = getlatestfile(folder);
    processflag = 1;
end

if contains(Description,'last','IgnoreCase',true)&& (~processflag)
    num_files = str2num(cell2mat(extract(Description,digitsPattern)));
    dirc = dir(folder);
    %Filter out all the folders.
    dirc = dirc(find(~cellfun(@isdir,{dirc(:).name})));
    %I contains the index to the biggest number which is the latest file
    [~,I] = sort([dirc(:).datenum],"descend"); % later created files have larger datenum
    if length(I)>=num_files
        filenames = extractfield(dirc(I(1:num_files)),'name');
    end
    processflag = 1;
end
% only files created today
if strcmpi(Description,'today')&& (~processflag)
    dirc = dir(folder);
    %Filter out all the folders.
    dirc = dirc(find(~cellfun(@isdir,{dirc(:).name})));
    %I contains the index to the biggest number which is the latest file
    date_creat = extractfield(dirc,'datenum');
    idx = date_creat>datenum(datetime('today'));
    filenames = extractfield(dirc(idx),'name');
    processflag = 1;
end

% % only files created yesterday
if strcmpi(Description,'yesterday')&& (~processflag)
    dirc = dir(folder);
    dirc = dirc(find(~cellfun(@isdir,{dirc(:).name})));
    date_creat = datetime(extractfield(dirc,'datenum'),'ConvertFrom','datenum');
    idx = (date_creat > datetime('yesterday')) & (date_creat < datetime('today'));
    filenames = extractfield(dirc(idx),'name');
    processflag = 1;
end

if strcmpi(Description,'All')&& (~processflag)
    dirc = dir(folder);
    filenames = extractfield(dirc,'name');
    processflag = 1;
end

% files created on a defined date
if contains(Description,digitsPattern(6,8)) && (~processflag)
    dignum = count(Description,digitsPattern(1));
    dt = extract(Description,digitsPattern);
    dt = dt{1};
    switch dignum

        case 6
            YY = dt(1:2);
            YY = strcat('20',YY);
            MM = dt(3:4);
            DD = dt(5:6);
        case 8
            YY = dt(1:4);
            MM = dt(5:6);
            DD = dt(7:8);

    end
    YY = str2num(YY);
    MM = str2num(MM);
    DD = str2num(DD);
    dirc = dir(folder);
    %Filter out all the folders.
    dirc = dirc(find(~cellfun(@isdir,{dirc(:).name})));
    %I contains the index to the biggest number which is the latest file
    date_creat = datetime(extractfield(dirc,'datenum'),'ConvertFrom','datenum');
    target_date = datetime(YY, MM, DD);
    idx = (date_creat >= target_date) & (date_creat < target_date + days(1));
    filenames = extractfield(dirc(idx),'name');
    

    processflag = 1;
end
% try as key word
if processflag ==0
    dirc = dir(folder);
    %Filter out all the folders.
    dirc = dirc(find(~cellfun(@isdir,{dirc(:).name})));
    filenames = extractfield(dirc,'name');
    if any(contains(filenames,Description))
        filenames = extractfield(dirc(contains(filenames,Description)),'name');
    else
        error('Please check the description')
    end
    processflag = 1;

    
end
