clc
close all

%s = [1 1 1 2 2 2 3 3 3 4 4 4];
%t = [2 3 4 5 6 7 8 9 10 11 12 13];
%weights = [1 1 1 1 1 1 1 1 1 1 1 1];
%names = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M'};

s = [1,2,3,4,5,5,6,7,8,8,11,11,12,12,15,16,16,17,19,19,21,22,22];
t =  [3,3,4,5,6,11,7,8,9,10,12,15,13,14,16,17,19,18,20,21,22,23,24];
weights = [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10];
names = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X'}
%ab ac ad be bf bg ch ci cj dk dl dm
%as we did flip edges therefore ; end node is the start node now

%labels = {'BA','CA','DA','EB','FB','GB','HC','IC','JC','KD','LD','MD'};
labels = ["AC","BC","CD","DE","EF","EK","FG","GH","HI","HJ","KL","KO","LM","LN","OP","PQ","PS","QR","ST","SU","UV","VW","VX"]; 
G = digraph(s,t,weights,names);
G = flipedge(G);
G.Edges.Label = labels';
p = plot(G)
incidence_matrix = get_incidence_matrix(G);
incidence_matrix = (zeros(13,13) + G.adjacency + G.adjacency').*incidence_matrix
names = cell2mat(names'); %  cell to array

%robot_number 
K = input('Number Of Robots: ', 's');
K = str2num(K);

%Cluster Size
cluster_size = input('Number of Robots per Group: ', 's');
cluster_size = str2num(cluster_size);

%num_of_nodes
[x,y] = size(G.Nodes)
J = x

%input('Number of nodes:','s');
%J = str2num(J);

start_nodes = names(end -(K)+1:end,1);
R = repmat(struct('iteration','','incidence_matrix','','name','','row_tags','','spawn','','edge_tags','','present_location',''),K,1);%array of structure used for storing incidence matrix corresponding to a particular robot;iteration also updated
V = repmat(struct('iteration','','incidence_matrix','','name','','neighbors','','row_tags','','E1_cap','','edge_tags',[]),J,1);%array of structure used for storing incidence matrix corresponding to a particular vertex ;iteration also updated

%Initialization of all vertex with an incidence matrix + initialization of
%robot incidence matrix for 0th iteration

for u= 1:J-K
   names(u,1)
   [~,V(u)] = initialize_graph(0,names(u,1),incidence_matrix, G); % decided according to the topology chosen
end
for k=1:K
    [K,~] = size(start_nodes);
    start_nodes(k,1)
    [R(k) , V(J - K + k)] = initialize_graph(k,start_nodes(k,1),incidence_matrix, G);
end
%-------------------------------------------------------------------------%
completion = 0;
n = 1;
for k = 1:K
 p = plot(G); 
 
%{
As topology chosen as all robots at leaf nodes thus they have only 1 choice to initiate the algorithm 
%}
[Id,R,V] = what_to_do_if_next_node_known(p,G,incidence_matrix,R,k,V,n,R(k).spawn,V(R(k).spawn - 64).neighbors)  %%Function call for processing


%Just For The Purpose Of Visual Enhancement
%to tell that the node has been updated fully
for z = 0:(K/cluster_size)-1
    if(k==3*(z+1))
        for i=1:k-1 -3*z
            R(k-i).incidence_matrix = V(Id.end -64).incidence_matrix;
            %R(k-i).iteration = V(Id.end - 64).iteration;
            R(k-i).row_tags = V(Id.end - 64).row_tags
            R(k-i).edge_tags = V(Id.end - 64).edge_tags
        end
highlight(p,Id.end,'NodeColor','green') %Chage colour of reached vertex
pause(1)     
                                
    end
end
%--------------------------------------------------------------------------
end


for k=1:K
%second_step

%while(completion~=1) %agar ye kar diya then 1 robot poora explore karlega
[Q,next_node,completion,V] = second_step_on_vertex_visit(p,G,R,k,V,R(k).present_location)
if(completion == 1)
    continue;
else
    V(R(k).present_location - 64).incidence_matrix
    V(R(k).present_location - 64).incidence_matrix
    [Id,R,V] = what_to_do_if_next_node_known(p,G,incidence_matrix,R,k,V,n,R(k).present_location,next_node)
    V(R(k).present_location - 64).incidence_matrix
end
end
%end



function [Id,R,V] = what_to_do_if_next_node_known(p,G,incidence_matrix,R,k,V,n,start,end_node)
    %j: present node
    %next_node : the destination
    
    %change the colour of present vertex   
    highlight(p,start,'NodeColor','red')
    pause(1)
    
    Id = struct('start','','end','','row_tags','','col_vector','','edge_tags','');%Completed edge column vector
    
    Id.start = start;
    %class(Id.start)
    Id.end = convertStringsToChars(end_node)
    %class(Id.end)
    
    %change colour of the chosen edge to tell user that robot is on the way
    [~,~,edgepath] = shortestpath(G,Id.start,Id.end);
    %edgepath
    highlight(p,'Edges',edgepath,'EdgeColor','r','LineWidth',2)
    pause(1)
    
    %robot reaches a node
    Id.col_vector = [-1*incidence_matrix(Id.start - 64 , Id.end - 64);-1*incidence_matrix(Id.end - 64, Id.start - 64)];
    Id.row_tags = [Id.start;Id.end];
    
    %sorting the edge nomenclature issue
    temp = unique(string(perms([Id.start Id.end])),'rows')
    if G.Edges.Label == temp(1,1)
        Id.edge_tags = G.Edges.Label(temp(1,1) == G.Edges.Label)
    else
        Id.edge_tags = temp(2,1)
    end  
    
    V(R(k).present_location -64).incidence_matrix      
    %signifies that we have reached a node. Now update
    %V(j-64).incidence_matrix and R(k).incidence_matrix
    [V,R] = first_step_on_vertex_visit(V,end_node,R,k,Id,n)
    highlight(p,Id.end,'NodeColor','red')
    pause(1)

end



















%{
while completion ~=1
for k=1:K
    select a connected vertex at random to get started with the algo
    change color of start vertex ,
    pause(2)
    change the color of edge that it traversed while going to the selected node
    Id = struct('start','','end','','row_tags','');%Completed edge column vector
    pass the vertex struct and robot struct to "first_step_on_vertex_visit()"
    change the color of the reached vertex
    second_step_on_vertex_visit(R)
end
end
%}
