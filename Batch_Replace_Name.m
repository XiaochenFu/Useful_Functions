% when I rename the tiff files, I stupidly convert all 'part1' and
% 'part2' to 'line1'
cd 'Z:\Xiaochen\IMG_backup\LSM780\Gene_Expression\Virus\ArchTeGFP\' %�Ƚ�����Ŀ¼�л���Ŀ���ļ�����
oldstr = 'Tbx3';
newstr = 'Tbx_3';
% file = dir(['*.czi']) %�ҵ����е�xlsx�ļ�
file = dir()
% d = dir; % find all subfolders
% dfolders = d([d(:).isdir]) ;
% dfolders = dfolders(~ismember({dfolders(:).name},{'.','..'}));
% file = dfolders;

len = length(file) %ѭ���滻�ļ����ƣ��滻��strrep��������replaceʱ�����޽������õ� %strrep���ٷ��ĵ����Ƽ���replace
for i = 1 : len
    oldname = [file(i).name];
    if  contains(oldname , oldstr)
        newname = strrep(oldname,oldstr,newstr)
        eval(['!rename' 32 '"' oldname '"' 32 '"' newname '"' ]);
    end
end
