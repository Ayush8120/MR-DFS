function [edge_names_final, names_final, merged_matrix, E1_cap]= merge_matrices(I1 , I2 , names_I1 , names_I2 , edge_names_I1, edge_names_I2)
[V1 , E1] = size(I1);
[V2, E2] = size(I2);
V_cap = V1 + V2;

E1_cap = E1;
E2_cap = E2;
%names_I1- row tags of I1
%names_I2 - row tags of I2
%names_final = repmat([names_I1;names_I2],1,E1_cap+E2_cap)
names_final = [names_I1;names_I2];
%edge_names_I1
%edge_names_I2
%[edge_names_I1 edge_names_I2]
%edge_names_final = repmat([edge_names_I1 edge_names_I2],V_cap,1)
edge_names_I1
edge_names_I2
edge_names_final = [edge_names_I1 edge_names_I2];
I = zeros(V_cap , E1_cap + E2_cap);
%V_cap
%E1_cap
%E2_cap
I
I(1:V1,1:E1_cap) = I1;
I(V1+1:V_cap,E1_cap +1 :E1 + E2) = I2;
I
delj = [];
deli=[];
names_I1
names_I2

names = [names_I1;names_I2];
names
for i1 = 1:V1
    for j1 = 1:E1
        for i2 = V1+1:V1+V2
            for j2=E1+1:E1 + E2    
            if((vertex_tag(names,i1)== vertex_tag(names,i2))&& (abs(I(i1,j1)) == abs(I(i2,j2))) && abs(I(i2,j2))~=0 && abs(I(i1,j1)~=0))
               vertex_tag(names,i1)
               vertex_tag(names,i2)
               abs(I(i2,j2))
               abs(I(i1,j1))
                if sign(I(i1,j1)) ~= sign(I(i2,j2))
                    c = -abs(I(i1,j1));
                    I(i1,j1) = c;
                    I(i2,j2) = c;
                end
                
                fprintf('Entered!')
                %E1_cap
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
              non_zero_element_count(I(V1+1:V1+V2,j1))
              if (non_zero_element_count(I(V1+1:V1+V2,j1))<2)
                  I(V1+1:V1+V2,j1) = I(V1+1:V1+V2,j1) + I(V1+1:V1+V2,j2);
                  %I
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

[deli,~,~] = unique(deli,'stable');
%deli
delj
[delj,~,~] = unique(delj,'stable')
%delj
%I
I = delete_rows(I, deli);
names_final = delete_rows(names_final,deli)
%edge_names_final = delete_rows(names_final,deli);
%I
I = delete_column(I, delj);
%names_final = delete_column(names_final,delj);
edge_names_final = delete_column(edge_names_final,delj)
merged_matrix = I

names_final = unique(names_final,'stable')
edge_names_final = unique(edge_names_final,'stable')
end %Friday

function [tag] = vertex_tag(names,i) % incomplete

tag = names(i);
tag;
end %LITE

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



