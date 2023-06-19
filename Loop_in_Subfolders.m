cd 'C:\Users\yycxx\Documents\LOT_sections\' %先将工作目录切换到目标文件夹下
D = dir; % A is a struct ... first elements are '.' and '..' used for navigation.
for k = 3:length(D) % avoid using the first ones
    currD = D(k).name; % Get the current subdirectory name
    % Run your function. Note, I am not sure on how your function is written,
    % but you may need some of the following
    cd(currD) % change the directory (then cd('..') to get back)
    fList = dir(currD); % Get the file list in the subdirectory
    %%
%     oldstr = 'ALBHD';
%     newstr = 'LBHD';
%     file = dir(); %找到所有的xlsx文件
%     len = length(file) %循环替换文件名称，替换用strrep函数，用replace时出错，无解所以用的 %strrep，官方文档上推荐用replace
%     for i = 1 : len
%         oldname = [file(i).name];
%         if  contains(oldname , oldstr)
%             newname = strrep(oldname,oldstr,newstr)
%             eval(['!rename' 32 '"' oldname '"' 32 '"' newname '"' ]);
%         end
%     end







    %%

    cd 'C:\Users\yycxx\Documents\LOT_sections\' %先将工作目录切换到目标文件夹下
end

