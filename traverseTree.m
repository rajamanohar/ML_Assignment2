function [classLabel] = traverseTree(map, attrList, dataList)
dataMap = java.util.HashMap;

for i = 0: attrList.size()-1
    
    if(strcmp(attrList.get(i), 'PL') == 1)
        dataMap.put(attrList.get(i), dataList.get(i));
    elseif(strcmp(attrList.get(i), 'PW')==1)
        dataMap.put(attrList.get(i), dataList.get(i));
    elseif(strcmp(attrList.get(i), 'SL')==1)
        dataMap.put(attrList.get(i), dataList.get(i));
    elseif(strcmp(attrList.get(i), 'SW')==1)
        dataMap.put(attrList.get(i), dataList.get(i));
    end
end

rootNodeLabel = map.get(0).get(0);
tempLabel = rootNodeLabel;

while(strcmp(tempLabel, 'SETOSA') == 0 && strcmp(tempLabel, 'OTHERS') == 0)
    [nextNodeIndex,nextNodeLabel] = findNextNode(map, tempLabel, dataMap.get(tempLabel));
    tempLabel = map.get(nextNodeIndex).get(0);
    break;
end

classLabel = tempLabel;
end

function [nextNodeIndex, nextNodeLabel] = findNextNode(map, parentNodeLabel, value)
nextNodeIndex = 0;
nextNodeLabel = '';
for i = 1 : map.size()
    nodeData = map.get(i);
    if(strcmp(nodeData.get(1), parentNodeLabel) && nodeData.get(2) > value)
        nextNodeLabel = nodeData.get(0);
        nextNodeIndex = i;
        break;
    end
end
end