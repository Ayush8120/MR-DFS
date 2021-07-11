
function [indexing_edge_tags,I_ordered,completed_edges_count] = order_matrix(merged_matrix,E1_cap)
I = merged_matrix;
[V,E] = size(I); 
E1_cap
E2_cap = E - E1_cap;

I1 = I(:,1:E1_cap);
%I1
I2 = I(:,E1_cap+1:E);
%I2
[a,comp_i1] = completed(I1);
comp_i1
[a1,comp_i2] = completed(I2);

if(~isempty(comp_i2))
comp_i2 = (comp_i2 + E1_cap)
end

[~,l] = size(a);
[~,p] = size(a1);
completed_edges_count = l + p;

[a2,out_i1] = out(I1);
out_i1
[a3,out_i2] = out(I2);

if(~isempty(out_i2))
out_i2 = (out_i2 + E1_cap)
end
 
[a4,unexp_i1] = unexplored(I1);
unexp_i1
[a5,unexp_i2] = unexplored(I2);
if(~isempty(unexp_i2))
unexp_i2 = (unexp_i2 + E1_cap)
end


I_ordered = [a,a1,a2,a3,a4,a5]
[comp_i1 comp_i2]
indexing_edge_tags = [comp_i1 comp_i2 out_i1 out_i2 unexp_i1 unexp_i2]; 
%a1


end%completed
%sliced_matrix- as second arg
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

%merged_matrix -as second arg
function [out_edges, out_i] = out(merged_matrix)
[m,n] = size(merged_matrix);
merged_matrix;
out_edges = [];
out_i = [];
for i = 1:n
    if(sum(merged_matrix(:,i) < 0) == 1)
        out_edges = [out_edges , merged_matrix(:,i)]
        out_i = [out_i i];
        %merged_matrix(:,i) = [];
    end
end
    if(isempty(out_i))
        out_i = [];
    end
end% Completed



function [unexplored_edges,unexp_i] = unexplored(merged_matrix) 
[~,n] = size(merged_matrix);
unexplored_edges = [];
unexp_i = [];
for i=1:n
if ((sum(merged_matrix(:,i) ~= 0) ~= 2) &&  (sum(merged_matrix(:,i) < 0) ~= 1))
unexplored_edges = [unexplored_edges,merged_matrix(:,i)];
unexp_i = [unexp_i i];
%sum(merged_matrix(:,i) ~= 0
%i
end
end
    if(isempty(unexp_i))
        unexp_i = [];
    end
end
%[~,comp_list] = completed(merged_matrix);
   % if (~isempty(comp_list))
   %     merged_matrix(comp_list) = [];
  %  end
%merged_matrix
%[~,out_list] = out(merged_matrix);
 %   if (~isempty(out_list))
 %       merged_matrix(out_list) = [];
  %  end
%merged_matrix
%unexplored_edge_matrix = merged_matrix;
%Completed