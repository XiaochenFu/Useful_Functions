function [min_distance,P] = Distance_when_Hit(entering,ending,FV)
min_distance = nan;
P = nan;
% [n_fiber,~] = size(entering,end);
% if n_fiber>1
%     distance(i) = distance_when_hit(entering(i,:),ending,FV(i,:));
% else
Faces = FV.faces;
Vertices = FV.vertices;
for i = 1:size(Faces,1)
    i1 = Faces(i,1);
    i2 = Faces(i,2);
    i3 = Faces(i,3);
    P1 = Vertices(i1,:);
    P2 = Vertices(i2,:);
    P3 = Vertices(i3,:);
    [tf,P0] = is_intersection(entering,ending,P1,P2,P3);
    if tf
        distance0 = norm(ending-P0);
        if isnan(min_distance)
            min_distance = distance0;
        else
            if distance0<min_distance
                min_distance = distance0;
            end
        end
        P = P0;
    end
end
% end
end
function [tf,P0] = is_intersection(Q1,Q2,P1,P2,P3)
% https://www.mathworks.com/matlabcentral/answers/74848-intersection-of-a-surface-generated-by-scattered-points-and-a-line
N = cross(P2-P1,P3-P1); % Normal to the plane of the triangle
P0 = Q1 + dot(P1-Q1,N)/dot(Q2-Q1,N)*(Q2-Q1); % The point of intersection
    tf = dot(cross(P2-P1,P0-P1),N)>=0 & ...
        dot(cross(P3-P2,P0-P2),N)>=0 & ...
        dot(cross(P1-P3,P0-P3),N)>=0;
end
