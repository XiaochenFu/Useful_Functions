function [amatch, bmatch] = align_timestamps_stupid(a, b, thresh)
    assert(numel(a) > 1 && numel(b) > 1);

    amatch = [];
    bmatch = [];
    ai = 1;
    bi = 1;

    while ai <= numel(a) && bi <= numel(b)
        if abs(a(ai) - b(bi)) <= thresh
            % Only add to the match arrays if the element is not already present
            if ~ismember(a(ai), amatch)
                amatch = [amatch a(ai)];
                bmatch = [bmatch b(bi)];
            end
            ai = ai + 1;
            bi = bi + 1;
        elseif a(ai) < b(bi)
            ai = ai + 1;
        else
            bi = bi + 1;
        end
    end

    % Truncate the longer array to match the shorter one
    min_length = min(numel(amatch), numel(bmatch));
    amatch = amatch(1:min_length);
    bmatch = bmatch(1:min_length);
end
