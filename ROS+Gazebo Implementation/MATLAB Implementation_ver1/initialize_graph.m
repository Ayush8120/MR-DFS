function [R,V] = initialize_graph(Robo_number,vertex_name,incidence_matrix,G)
if (Robo_number ~= 0)
    
    R.iteration = 0;
    R.incidence_matrix = [];
    R.name = Robo_number;
    R.row_tags = [];
    R.edge_tags = [];
    R.spawn = char(68 + Robo_number);
    R.present_location = R.spawn;
end
if (Robo_number == 0)
    R = [];
end
%vertex_index = vertex_name - 64 ;
V.iteration =0;


V.name = vertex_name; %Google how to make a digraph's name matrix global
V.neighbors = [cell2mat(G.successors(V.name));cell2mat(G.predecessors(V.name))]
V.incidence_matrix = get_incidence_angle(V.name,V.neighbors,incidence_matrix);%.*ones(1,number_of_edges_connected)%.*get_incidence_angle(vertex_name,G);
[O,b] = size(V.neighbors); 

%working but "AB" "BA" types inconsistency but no error 
%name_rep = repmat(V.name,O,1);
%V.edge_tags = strcat(name_rep,V.neighbors);% can directly use G.Edge.Label ? Give it a thought
%V.edge_tags = string(V.edge_tags)'
V.edge_tags = string.empty(0,0)
%%%Alternative
for i=1:O
temp = unique(string(perms(strcat(V.name,V.neighbors(i)))),'rows');
size(temp)
if temp(1,1) == G.Edges.Label
    V.edge_tags = [V.edge_tags G.Edges.Label(temp(1,1) == G.Edges.Label)]
else
    V.edge_tags = [V.edge_tags temp(2,1)]
end
end

V.row_tags = [vertex_name];
V.E1_cap = 0;
V;

%when initialize then in accorance with j do link them to a name matrix ka
%entry jaisa kuch%done - sort of

end
%Completed-verified

function [angle] = get_incidence_angle(start,dest_array,matrix) 
angle = [];
%dest_array
[a,b]= size(dest_array);
dest_array = sort(dest_array);
for i=1:a
angle(1,i) = matrix(start - 64,dest_array(i) - 64);
end
end
%Completed-verified