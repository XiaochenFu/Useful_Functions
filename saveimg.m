function saveimg(figurehandle,Path,experiment,title,format)
% input
% figurehandle can be gcf
% Path: string
% experiment: string
% title: string
% format: number, where first digit from the right to left means jpg, fig,
% svg
f = num2str(format);
for j = 1:length(f)
    switch j
        case 1
            if strcmp(f(end-j+1),'1')
                extension = 'jpg';
                filename = sprintf ('%s_%s.%s',experiment,title,extension);
                saveas(figurehandle,fullfile(Path,filename))
            end
        case 2
            if strcmp(f(end-j+1),'1')
                extension = 'fig';
                filename = sprintf ('%s_%s.%s',experiment,title,extension);
                saveas(figurehandle,fullfile(Path,filename))
            end
        case 3
            if strcmp(f(end-j+1),'1')
                extension = 'svg';
                filename = sprintf ('%s_%s.%s',experiment,title,extension);
                saveas(figurehandle,fullfile(Path,filename))
            end

    end
end

