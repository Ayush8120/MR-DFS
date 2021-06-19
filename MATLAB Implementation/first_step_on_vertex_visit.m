function [V,R] = first_step_on_vertex_visit(V,j,R,k,Id,n)  %this is executed when a robot reaches a new node after traversing an edge

%V : n-1 iteration , jth vertex
%R : n-1 iteration, kth robot
%Id : column vector corresponding to completed edge
j = convertStringsToChars(j);

if(V(j-64).iteration == 0)
    V(j-64).iteration = n -1 ;
end

tag_Id = Id.row_tags;
dd = struct('tags','','incidence_matrix',[],'edge_tags','');%Completed edge column vector
%Id
%R(k).incidence_matrix
%tag_Id
%R(k).row_tags

[dd.edge_tags, dd.tags, dd.incidence_matrix,~] = merge_matrices(Id.col_vector, R(k).incidence_matrix, tag_Id, R(k).row_tags, Id.edge_tags, R(k).edge_tags);
%debug
dd.incidence_matrix
%
V(j-64).incidence_matrix
[R(k).edge_tags, R(k).row_tags,I,E1_cap] = merge_matrices(dd.incidence_matrix, V(j-64).incidence_matrix, dd.tags, V(j-64).row_tags, dd.edge_tags, string(V(j-64).edge_tags));
R(k).present_location = Id.end;
%debug
I
%
R(k).iteration = R(k).iteration + 1;
V(j-64).iteration = V(j-64).iteration + 1;


[indexing_edge_tags,R(k).incidence_matrix,C]  = order_matrix(I,E1_cap);

%debug
indexing_edge_tags
%

V(j - 64).incidence_matrix  = R(k).incidence_matrix; 
j
V(j-64).incidence_matrix
R(k).edge_tags = R(k).edge_tags(indexing_edge_tags); 
%
C
%

V(j-64).row_tags =  R(k).row_tags;
V(j-64).edge_tags = R(k).edge_tags;
end
%Completed-verfied for B to E vertex
%Verfied for all leaf edges