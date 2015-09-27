function [] = ConstructChildNodes(dtr,NodeValue,binMaxes,binEndIndexs,SampleData)
%  check class labels data for each bin 

for binIndex=1:length(binMaxes)
startIndex=1;
BinClasses=SampleData(startIndex:binEndIndexs(binIndex,1),5);
BinClasses=cell2mat(BinClasses);
BinClasses=sortrows(BinClasses);

[binClassDist,binClassEnds,binClassVals] = unique(BinClasses,'last','rows');
if length(binClassDist)==1
    if binClassDist==1
        classLabel='SETOSA';
    elseif binClassDist==2
        classLabel='OTHERS';
    end
     dtr=createOrUpdateTree(dtr,classLabel,NodeValue,binMaxes(binIndex,1));
else length(binClassDist)>1
    
    
    
end

end

end

