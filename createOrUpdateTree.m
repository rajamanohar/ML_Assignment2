%order in list: Node_Name, Parent_Name, Bin_Condition
function [map] = createOrUpdateTree(map,node_name, parent_name, bin_condition)

disp(node_name);

list = java.util.ArrayList;
list.add(char(node_name));
list.add(char(parent_name));
list.add(bin_condition);
disp(list);
size = map.size();
index = size + 1;

map.put(index, list);
end