function [Q,next_node,completion, V, R] = second_step_on_vertex_visit(p,G,R,k,V,j)
%R : nth iteration kth Robot 
%decides which edge next to travel
Q = []; % the edge queue
%I = R(k).incidence_matrix;

I = V(j-64).incidence_matrix;
[I_row,I_col] = size(I);
I_selected = I(:,I_col); % the last column : i.e. unexplored edge

[~,list] = completed(I);%list is a list of index of completed edges
[~,Ec] = size(list) % number of completed edges

if (non_zero_element_count(I(:,I_col))==2 || ~isempty(I_selected(I(:,I_col)<0)))%if last column represents completed edge

    fprintf("Yippie! Exploration Completed");
    completion = 1;
    Q = 0;
    next_node = 0;
    V;
    R;
    return ;

elseif ((isempty(Q)) || non_zero_element_count(V(Q(I_col)-64).incidence_matrix(:,I_col))== 0)    
    
    completion = 0;
    fprintf("AYUSH");
    k
    R(k).present_location
    
    I_edge = V(j-64).edge_tags(I_col)
    %I_row_tags = R(k).row_tags;
    I_row_tags = V(j-64).row_tags;
    
    %get the row tag at which the positive entry is kept in I(R(k)) and then
    %find the shortest path from the present robot location to that vertex,
    %add intermediate edges in queue Q
    %add the selected edge in Q which will be the edge_tag of right most
    %column of I(R(k))
    
    R(k).present_location;
    I_row_tags(I_selected ~= 0);
    V(j-64).edge_tags(I_col)
    
    erase(V(j-64).edge_tags(end),I_row_tags(I_selected ~= 0))
    
    [nodes_step_2,~,edgepath] = shortestpath(G,R(k).present_location,I_row_tags(I_selected ~= 0))%,erase(R(k).edge_tags(end),I_row_tags(I_selected ~= 0)));
    nodes_step_2
    
    
    %Q = [nodes_step_2 erase(V(j-64).edge_tags(I_col),I_row_tags(I_selected ~= 0))]
    Q = [nodes_step_2 erase(I_edge, I_row_tags(I_selected ~= 0))]
    
    %[nodes_step_2,~,edgepath] = shortestpath(G,I_row_tags(I_selected ~= 0),erase(R(k).edge_tags(end),I_row_tags(I_selected ~= 0)));%known_vertex
    %highlight(p,edgepath,'EdgeColor','g','LineWidth',2)
    
    %pause(1);
    %Trash - V(j-64).name
end
next_node = Q(2);
%[row,col] = size(I);
if (non_zero_element_sign(I_selected(I_selected ~= 0))>0)
    for i=1:I_row
    I(i,I_col) = -1*I(i,I_col);
    end
end


%I_completed_part = I(:,1:Ec)
%I_uncomplete_part = I(:,Ec+1:I_col)
I_temp = circshift(I(:,Ec+1:I_col),1,2)
R(k).edge_tags = circshift(R(k).edge_tags(:,Ec+1:I_col),1,2);
%[I(:,Ec),I_temp]
R(k).incidence_matrix = [I(:,1:Ec),I_temp]
V(j - 64).incidence_matrix = R(k).incidence_matrix
V(j-64).incidence_matrix
V(j-64).edge_tags = R(k).edge_tags
end

function [sign] = non_zero_element_sign(val)%column_vector)

%if((sum(column_vector>0)) == 1)
%    sign = 3; 
%elseif (sum(column_vector<0) == 1)
%    sign = -3;
%end
if(val>0)
    sign = 3; 
elseif (val<0)
    sign = -3;
end


end

function [completed_edges,comp_i] = completed(merged_matrix)
    merged_matrix;
    sliced_matrix = merged_matrix;
    [m,n] = size(merged_matrix);
    completed_edges = [];
    comp_i = [];
    for i = 1:n

        if(sum(sliced_matrix(:,i) ~= 0) == 2)
            completed_edges = [completed_edges , merged_matrix(:,i)];
            completed_edges;
            comp_i = [comp_i i];
            %merged_matrix(:,i) = [];
        end 
    end
    if(isempty(comp_i))
        comp_i = [];
    end
    %sliced_matrix = merged_matrix;
end % Completed

function [answer] = non_zero_element_count(column_vector) 
answer = sum(column_vector ~= 0);
end% Completed - verified - re-verified