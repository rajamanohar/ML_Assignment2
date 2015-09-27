function [] = ConstructChildNodes(dtr,NodeValue,binMaxes,binEndIndexs,SampleData,TrainData)
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
elseif length(binClassDist)>1
    
    [SampleData NodeValue NodeIdx Entropies]=DetermineNodeValue(SampleData,TrainData,Attributes,dtr,0)
    dtr=createOrUpdateTree(dtr,NodeValue,NodeValue,0);
    [binMaxes,binEndIndexs]=FindBinMaxes(SampleData,NodeIdx,TrainData);
    ConstructChildNodes(dtr,NodeValue,binMaxes,binEndIndexs,SampleData,TrainData);

    
end

end

end

