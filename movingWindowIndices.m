function window_indices = movingWindowIndices(total_length,window_width, window_steps)
    for i = 1:window_steps:(total_length - window_width + 1)
        window_indices = i:(i + window_width - 1);
        disp(window_indices);
    end
end