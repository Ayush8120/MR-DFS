    %vertex_name
function [incidence_angle_matrix] = get_incidence_matrix(G)
p = plot(G);
for i=1:size(G.Nodes)%start point
    for j = 1:size(G.Nodes) %end point
        if(i==j)
            incidence_angle_matrix(i,j) = 0;
        else
            if (atan2(p.YData(j) - p.YData(i),p.XData(j) - p.XData(i)) <= 0)
                incidence_angle_matrix(i,j) = atan2(p.YData(j) - p.YData(i),p.XData(j) - p.XData(i)) + 2*pi;
            elseif (atan2(p.YData(j) - p.YData(i),p.XData(j) - p.XData(i)) > 0)
                incidence_angle_matrix(i,j) = atan2(p.YData(j) - p.YData(i),p.XData(j) - p.XData(i));
            end
        end
    end
end
end
