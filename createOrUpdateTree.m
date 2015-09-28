%order in list: Node_Name, Parent_Name, Bin_Condition
function [map] = createOrUpdateTree(map,node_name, parent_name, bin_condition)

if(length(map)<1)
    
    map{1,1}=char(node_name);
    map{1,2}=char(parent_name);
    map{1,3}=bin_condition;
    map{1,4}=[];
else
    map=updateChildNode(map,node_name, parent_name, bin_condition);
end

end

function[map]=updateChildNode(map,node_name, parent_name, bin_condition)


if char(map{1,1})==char(parent_name)
    
    tempCell{1,1}=char(node_name);
    tempCell{1,2}=char(parent_name);
    tempCell{1,3}=bin_condition;
    tempCell{1,4}=[];
    
    childNodes=map{1,4};
    childNodesCount=length(childNodes);
    
    if(childNodesCount<5)
        childNodes{1,childNodesCount+1}=tempCell;
        map{1,4}=childNodes;
    end
else
   childCells=map{1,4};
   if(length(childCells)<5)
      
   end
   map=updateChildNode(childCells,node_name, parent_name, bin_condition)
end
end