%order in list: Node_Name, Parent_Name, Bin_Condition
function [map,index]=createOrUpdateTree(map,node_name, parent_name, bin_condition,parentIndex)

list = java.util.ArrayList;
list.add(char(node_name));
list.add(char(parent_name));
list.add(bin_condition);
list.add(parentIndex);
disp(list);
size = map.size();
index = size + 1;

map.put(index, list);

end