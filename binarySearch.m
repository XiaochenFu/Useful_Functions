function idx = binarySearch(A, val)
    low = 1;
    high = length(A);

    while low <= high
        mid = floor((low + high) / 2);
        
        if A(mid) < val
            low = mid + 1;
        elseif A(mid) > val
            high = mid - 1;
        else
            idx = mid;
            return;
        end
    end
    idx = low; % Return the next higher index if exact value isn't found
end
