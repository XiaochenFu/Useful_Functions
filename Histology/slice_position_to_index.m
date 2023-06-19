function section_index = slice_position_to_index(total_slide_number,slide_number0,line_number0,slice_in_line0)
total_slide_number = tonum(total_slide_number);
slide_number = tonum(slide_number0);
line_number = tonum(line_number0);
slice_in_line = tonum(slice_in_line0);
switch total_slide_number
    case 2
        part_index = (slide_number-1)*3 + line_number;
        section_index =  (slice_in_line-1)*6 + part_index;
    case 3
        part_index = (slide_number-1)*2 + line_number;
        section_index =  (slice_in_line-1)*6 + part_index;
    case 6
        part_index = slide_number;
        section_index =  (slice_in_line-1)*6 + part_index;
end
end
function s = tonum(nors)
if isa(nors,'string')
    s = str2num(nors);
else
    s = nors;
end
if isa(nors,'char')
    s = str2num(nors);
else
    s = nors;
end
end