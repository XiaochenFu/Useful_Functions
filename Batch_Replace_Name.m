% when I rename the tiff files, I stupidly convert all 'part1' and
% 'part2' to 'line1'
cd 'Z:\Xiaochen\IMG_backup\LSM780\Gene_Expression\Virus\ArchTeGFP\' %先将工作目录切换到目标文件夹下
oldstr = 'Tbx3';
newstr = 'Tbx_3';
% file = dir(['*.czi']) %找到所有的xlsx文件
file = dir()
% d = dir; % find all subfolders
% dfolders = d([d(:).isdir]) ;
% dfolders = dfolders(~ismember({dfolders(:).name},{'.','..'}));
% file = dfolders;

len = length(file) %循环替换文件名称，替换用strrep函数，用replace时出错，无解所以用的 %strrep，官方文档上推荐用replace
for i = 1 : len
    oldname = [file(i).name];
    if  contains(oldname , oldstr)
        newname = strrep(oldname,oldstr,newstr)
        eval(['!rename' 32 '"' oldname '"' 32 '"' newname '"' ]);
    end
end
