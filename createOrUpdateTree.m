%order in list: Node_Name, Parent_Name, Bin_Condition
function [map,index]=createOrUpdateTree(map,node_name, parent_name, bin_condition,parentIndex)

% disp(node_name);

list = java.util.ArrayList;
list.add(char(node_name));
list.add(char(parent_name));
list.add(bin_condition);
list.add(parentIndex);
disp(list);
size = map.size();
index = size + 1;

map.put(index, list);
%   if(strcmp(node_name,'SETOSA')|| strcmp(node_name,'OTHERS'))
%      
%       map.put(index, list);
%          
%   else
%       map.put(index, list);
%      
%   end
   
end