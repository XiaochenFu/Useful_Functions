function [newname,extract_info] = convert_section_name6(oldname,number_of_slides)
% convert the name of the imaging, by guessing or by defination
% Since I usually split the sections to 6 and mount on 1/2/3/6 slides.
%% Spilt the name and try to get information
C = strsplit(oldname,'_');
%% define the keywords
% Use a dictionary to find the strain. The strain we use in this lab should
% be some thing with
strain_keywords1 = ["Tbx","LBHD","CCK", "BL6", "OMP","Vgat"];
strain_keywords2 = ["Ai","Ca"];
strain_keywords = [strain_keywords1, strain_keywords2];
% for each part in the file name, if it contain the strain key word, it
% should be strain, and the mouse ID should be after that

%
slide_keywords = "slide";

% There can be 2 to 3 parts on one slide
part_keywords =["part","line"];

% slice info
slice_keywords = ["slice","section"];

% maginification information might be saved
maginification_keywords = ["fine","course","x"];

%% find necessary information
Strain = [];
Number = [];
Slide = [];
Part = [];
Slice = [];
Objective = [];

%
[Strain1,Number1] = Find_Key_Word_and_ID(C,strain_keywords1);
[Strain2,Number2] = Find_Key_Word_and_ID(C,strain_keywords2);
Strain = strcat(Strain1,Strain2);
if isempty(Strain2)
    Number = Number1;
else
    Number = Number2;
end
animalid = strcat(Strain,"_",Number);

[~,Slide] = Find_Key_Word_and_ID(C,slide_keywords);
[~,Part] = Find_Key_Word_and_ID(C,part_keywords);
[~,Slice] = Find_Key_Word_and_ID(C,slice_keywords);
%%
switch number_of_slides
    case -1 % just guess
        if isempty(Slice)
            number_of_slides = 1;
        elseif isempty(Part)
            number_of_slides = 6;
            Part = 1;
        else
            number_of_slides = 3;
        end
    case 0 % dection index already there in the file since sections mounted in order
        number_of_slides = 1;
    case 2 % 2 slides, 3 parts per slide
    case 3 % 3 slides, 2 parts per slide
    case 6 % 6 slides, 1 part per slide
end
if number_of_slides ==1
    sectionid = Slice;
else
    sectionid = slice_position_to_index(number_of_slides,Slide,Part,Slice);
end
newname = sprintf('%s_section%d',animalid,sectionid);
[filepath,name,ext] = fileparts(oldname);
if ~isempty(ext)
    newname = strcat(newname,ext);
end
extract_info.animalid = animalid;
extract_info.sectionid = sectionid;
% extract_info.objective;

end
function [KeyWord,ID] = Find_Key_Word_and_ID(String,Pattern)
KeyWord = [];
ID = [];
for k = 1:length(String)
    info_piece = String{k};
    isname1 = contains(info_piece,Pattern,'IgnoreCase',true);

    if isname1
        for l = 1:length(Pattern)
            if contains(info_piece,Pattern{l},'IgnoreCase',true)
                KeyWord = Pattern(l);
            end
        end
        isnumber = strfind(String{k+1},digitsPattern);
        if ~isempty(isnumber)&& (isempty(strfind(String{k+1},lettersPattern)))
            ID = String{k+1}(isnumber);
        else
            isnumber = strfind(String{k},digitsPattern);
            if ~isempty(isnumber)
                ID = String{k}(isnumber);
            end
        end

    end

end

end




























