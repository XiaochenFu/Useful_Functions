function [Img_Block_Name, Img_Block_Data] = Segment_Img_Block(IMG,block_interval, overlap, varargin)
if ~isempty(varargin)
    option = varargin{1}; % parameters supplied by user
else
    option = [];
end
% isplot = getOr(option, 'isplot', 0);
% saveplot = getOr(option, 'saveplot', 0);
% block_size_option define the output size according to the input
% block_interval.
%       'min': inerval of output tilt>block_interval, and inerval of output tilt<block_interval*2
%       'max': inerval of output tilt<=block_interval
%       'precise': both side of the inerval of output tilt = block_interval.
%       The misssing part will be filled by zeros

block_size_option = getOr(option, 'block_size_option', 'min');

% output_format.
%       'pixel': pixel in in the original picture
%       'block': block in in the segmentation row_colomn_numebr

output_format = getOr(option, 'output_format', 'pixel');
output_data_format = getOr(option, 'output_data_format', 'double');

Img_Block_Name = {};
Img_Block_Data = {};
grayImage = IMG;
[rows, columns] = size(grayImage);
switch block_size_option
    case 'min'
        numBandsVertically = floor(rows/block_interval);
        numBandsHorizontally = floor(columns/block_interval);
        topRows = round(linspace(1, rows+1, numBandsVertically + 1));
        leftColumns = round(linspace(1, columns+1, numBandsHorizontally + 1));
        plotCounter = 1;
        for row = 1 : length(topRows) - 1
            row1 = topRows(row);
            if row < (length(topRows) - 1)
                row2 = topRows(row + 1) - 1+ overlap;
            else
                row2 = topRows(row + 1) - 1 ;
            end
            for col = 1 : length(leftColumns) - 1
                col1 = leftColumns(col);
                if col<(length(leftColumns) - 1)
                    col2 = leftColumns(col + 1) - 1 + overlap;
                else
                    col2 = leftColumns(col + 1) - 1;
                end

                subImage = grayImage(row1 : row2, col1 : col2, :);
                switch output_format
                    case 'pixel'
                        Output_Title = sprintf('Row_%d_%d_Col_%d_%d', row1, row2, col1, col2);
                    case 'block'
                        Output_Title = sprintf('Row_%d_Col_%d', row, col);
                end
                Img_Block_Name{plotCounter} = Output_Title;
                Img_Block_Data{plotCounter} = subImage;
                %         imwrite(subImage,Output_Title)
                plotCounter = plotCounter + 1;
            end
        end
    case 'max'
        numBandsVertically = ceil(rows/block_interval);
        numBandsHorizontally = ceil(columns/block_interval);
        topRows = round(linspace(1, rows+1, numBandsVertically + 1));
        leftColumns = round(linspace(1, columns+1, numBandsHorizontally + 1));
        plotCounter = 1;
        for row = 1 : length(topRows) - 1
            row1 = topRows(row);
            if row < (length(topRows) - 1)
                row2 = topRows(row + 1) - 1+ overlap;
            else
                row2 = topRows(row + 1) - 1 ;
            end
            for col = 1 : length(leftColumns) - 1
                col1 = leftColumns(col);
                if col<(length(leftColumns) - 1)
                    col2 = leftColumns(col + 1) - 1 + overlap;
                else
                    col2 = leftColumns(col + 1) - 1;
                end

                subImage = grayImage(row1 : row2, col1 : col2, :);
                switch output_format
                    case 'pixel'
                        Output_Title = sprintf('Row_%d_%d_Col_%d_%d', row1, row2, col1, col2);
                    case 'block'
                        Output_Title = sprintf('Row_%d_Col_%d', row, col);
                end
                Img_Block_Name{plotCounter} = Output_Title;
                Img_Block_Data{plotCounter} = subImage;
                %         imwrite(subImage,Output_Title)
                plotCounter = plotCounter + 1;
            end
        end
    case 'precise'
        numBandsVertically = ceil(rows/block_interval);
        numBandsHorizontally = ceil(columns/block_interval);
        topRows = 1:(block_interval):((numBandsVertically+1)*block_interval);
        leftColumns = 1:(block_interval):((numBandsHorizontally+1)*block_interval);
        % fill up a bigger image with zeros
        grayImage0 = zeros(numBandsVertically*block_interval,numBandsHorizontally*block_interval);
        grayImage0(1:rows,1:columns) = grayImage;
        plotCounter = 1;
        for row = 1 : length(topRows)-1
            row1 = topRows(row);
            %             if row < (length(topRows) - 1)
            row2 = topRows(row + 1) - 1+ overlap;
            %             else
            %                 row2 = topRows(row + 1) - 1 ;
            %             end
            for col = 1 : length(leftColumns)-1
                col1 = leftColumns(col);
                %                 if col<(length(leftColumns) - 1)
                col2 = leftColumns(col + 1) - 1 + overlap;
                %                 else
                %                     col2 = leftColumns(col + 1) - 1;
                %                 end

                subImage = grayImage0(row1 : row2, col1 : col2, :);
                switch output_format
                    case 'pixel'
                        Output_Title = sprintf('Row_%d_%d_Col_%d_%d', row1, row2, col1, col2);
                    case 'block'
                        Output_Title = sprintf('Row_%d_Col_%d', row, col);
                end
                Img_Block_Name{plotCounter} = Output_Title;
                Img_Block_Data{plotCounter} = subImage;
                %         imwrite(subImage,Output_Title)
                plotCounter = plotCounter + 1;
            end
        end
switch output_data_format
    case "uint8"
        Img_Block_Data = cellfun(@uint8,Img_Block_Data,'UniformOutput',false);
end
end

