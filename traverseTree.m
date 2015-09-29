function [classLabel] = traverseTree(map, attrList, dataList)
dataMap = java.util.HashMap;

for i = 0 : attrList.size()-1
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

rootNodeLabel = map.get(1).get(0);
tempLabel = rootNodeLabel;
index = map.get(1).get(3);
nextNodeLabel='';

while(strcmp(nextNodeLabel, 'SETOSA') == 0 && strcmp(nextNodeLabel, 'OTHERS') == 0)
    [nextNodeIndex,nextNodeLabel] = findNextNode(map, index, dataMap.get(tempLabel));
    index = nextNodeIndex;
    if(map.get(nextNodeIndex)==0)
        tempLabel=rootNodeLabel;
    else
        tempLabel = map.get(nextNodeIndex).get(0);
    end
end

classLabel = nextNodeLabel;
end

function [nextNodeIndex, nextNodeLabel] = findNextNode(map, parentNodeIndex, value)
nextNodeIndex = 0;
nextNodeLabel = '';
childIndexList = java.util.ArrayList;


childIndexList=findChilds(map, parentNodeIndex);
for i = 0 : childIndexList.size()-1
    if(map.get(childIndexList.get(i)).get(2) > value)
        nextNodeIndex=childIndexList.get(i);
        %nextNodeIndex=i;
        nextNodeLabel=map.get(childIndexList.get(i)).get(0);
        break;
    end
end
end

function [childIndexList] = findChilds(map, parentNodeIndex)
childIndexList = java.util.ArrayList;
%size =  map.size()-1;
for i = 1 : map.size
    if(map.get(i).get(3)==parentNodeIndex && i~=1)
        childIndexList.add(i);
    end
end
end