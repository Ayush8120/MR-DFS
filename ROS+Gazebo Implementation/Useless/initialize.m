

function R(Robo_number),V(vertex_index) = initialize_graph(Robo_number, number_of_edges_connected ,vertex_name)
if (Robo_number ~= 0)
    R(Robo_number).iteration = 0;
    R(Robo_number).incidence_matrix = [];
    R(Robo_number).key = Robo_number;
    R(Robo_number)
    %R_k_o = [];
end
%if (Robo_number == 0)
%    R = [];
%end
vertex_index = vertex_name - 64 ;
V(vertex_index).iteration =0;
V(vertex_index).incidence_matrix = zeros(1,number_of_edges_connected);
V(vertex_index).key = vertex_name; %Google how to make a digraph's name matrix global
V(vertex_index)

%get_bearing_angle(i,j)
%when initialize then in accorance with j do link them to a name matrix ka
%entry jaisa kuch

end

function [merged_matrix]= Merge_Matrices(I1 , I2 , names_I1 , names_I2)
[V1 , E1] = size(I1);
[V2, E2] = size(I2);
V_cap = V1 + V2;

E1_cap = E1;
E2_cap = E2;

I = zeros(V_cap , E1_cap + E2_cap);
I;
I(1:V1,1:E1_cap) = I1;
I(V1+1:V_cap,E1_cap +1 :E1 + E2) = I2;
I
delj = [];
deli=[];
names = [names_I1;names_I2];
for i1 = 1:V1
    for j1 = 1:E1
        for i2 = V1+1:V1+V2
            for j2=E1+1:E1 + E2
            if(I(i1,j1) ~= 0 && I(i2,j2) ~= 0)    
            if((vertex_tag(names,i1)== vertex_tag(names,i2))&& (abs(I(i1,j1)) == abs(I(i2,j2))))
                if sign(I(i1,j1)) ~= sign(I(i2,j2))
                    c = -abs(I(i1,j1));
                    I(i1,j1) = c;
                    I(i2,j2) = c;
                end
                E1_cap
                if(non_zero_element_count(I(V1+1:V1 + V2,j2))==2)
                    delj = [delj,j1];
                    E1_cap = E1_cap -1;
                elseif non_zero_element_count(I(1:V1,j1))==2
                    delj = [delj,j2];
                    E2_cap = E2_cap -1;
                else
                    delj = [delj,j1];
                    E1_cap = E1_cap -1;
                end
              if (non_zero_element_count(I(V1+1:V1+V2,j1))<2)
                  I(V1+1:V1+V2,j1) = I(V1+1:V1+V2,j1) + I(V1+1:V1+V2,j2);
              end
              if (non_zero_element_count(I(1:V1,j2))<2)
                  I(1:V1,j2) = I(1:V1,j2) + I(1:V1,j1);
              end
              deli = [deli, i1];
            end
            end
        end
        
    end
    end
end
[deli,~,~] = unique(deli,'stable');
deli
[delj,~,~] = unique(delj,'stable');
delj
I
I = delete_rows(I, deli)
I = delete_column(I, delj)
merged_matrix = I;
[ordered_matrix,Comp_edges_count] = order_matrix(merged_matrix,E1_cap); % call for oredered_matrix 
end %Friday

function [tag] = vertex_tag(names,i)

tag = names(i);
tag
end 

function [deleted_matrix] = delete_rows(matrix , list)
for i=1:length(list)
    list = sort(list);
    matrix(list(i),:) = [];
    list(1,i) = 1;
    list = list - 1;
end
deleted_matrix = matrix;
end % Completed - verified

function [deleted_matrix] = delete_column(matrix , list)
list = sort(list);
for i=1:length(list)
    matrix(:,list(i)) = [];
    list(1,i) = 1;
    list = list - 1;
end
deleted_matrix = matrix;
end % Completed - verified 

function [answer] = non_zero_element_count(column_vector) 
answer = sum(column_vector ~= 0);
end% Completed - verified - re-verified


