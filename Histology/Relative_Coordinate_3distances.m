% calculate the relative coordinate of a dot D_ref to two boundarys S1 and
% S2. S1 is scaled as 0 and S2 is scaled as 1. In other word, S1 as MCL and
% S2 as upper bound of EPL

% 1. Find the nearst dot D_S1 on S1 to D_ref, distance d_ds1
% 2. Draw a line L of D_S1 and D_ref
% 3. Find the nearst dot on S2 to L, D_S2, distance d_ds2
% 4. Calculate the distance of S1 to S2, s1_s2
% 5. relative coordinate by checking relative position of three dots
% D in the middle: d = d_ds1/s1_s2
% D_S1 in the middle: d = -d_ds1/s1_s2
% D_S2 in the middle: d = d_ds1/s1_s2
% so
%   d = -d_ds1/s1_s2, if d_ds2>s1_s2 & d_ds2>d_ds1
%        d_ds1/s1_s2, if d_ds2<s1_s2

function [d] = Relative_Coordinate_3distances(d_ds1, d_ds2, D_S1, D_S2)
% applyToGivenRow = @(func, matrix) @(row) func(matrix(row, :));
% newApplyToRows = @(func, matrix) arrayfun(applyToGivenRow(func, matrix), 1:size(matrix,1), 'UniformOutput', false)';
% takeAll = @(x) reshape([x{:}], size(x{1},2), size(x,1))';
% genericApplyToRows = @(func, matrix) takeAll(newApplyToRows(func, matrix));
% 
% 
% distance2dot = @(D) norm(D-D_ref);
% B = genericApplyToRows(distance2dot, S1);% for all dots on S1, calculate the distance to the reference dot
% [d_ds1,D_S1_idx] = min(B);
% D_S1 = S1(D_S1_idx,:);
% distance2line = @(D) point_to_line(D, D_ref, D_S1);
% C = genericApplyToRows(distance2line, S2);
% % [~,D_S2_idx] = min(C);
% % Since the nearest dot might be on the other site, we find a dot with
% % shortest d_ds2 in the 10 nearest dots
% [SS,D_S2_idxs] = sort(C);
% num_candidates =10;
% D_S2_candidates = S2(D_S2_idxs(1:num_candidates),:);
% % plot(D_S2_candidates(:,1),D_S2_candidates(:,2),'r*')
% D = genericApplyToRows(distance2dot, D_S2_candidates);
% [d_ds2,D_S2_idx_in_candidates] = min(D);
% D_S2 = D_S2_candidates(D_S2_idx_in_candidates,:);


% d_ds2 = norm(D_S2-D_ref);
d_ds1 = abs(d_ds1);
d_ds2 = abs(d_ds2);
s1_s2 = norm(D_S2-D_S1);
% check the relative position of three dots
if d_ds2>s1_s2 && d_ds2>d_ds1 
    d = -d_ds1/s1_s2;
else
    d = d_ds1/s1_s2;
end
end





function d = point_to_line(pt, v1, v2)
      a = v1 - v2;
      a = [a,0];
      b = pt - v2;
      b = [b,0];
      d = norm(cross(a,b)) / norm(a);
end