%order in list: Node_Name, Parent_Name, Bin_Condition
function [map] = createOrUpdateTree(map,node_name, parent_name, bin_condition)
    list = java.util.ArrayList;
    list.add(node_name);
    list.add(parent_name);
    list.add(bin_condition);
    
    size = map.size();
    index = size + 1;
    
    map.put(index, list);
end