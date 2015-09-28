function [SampleData,NodeValue,NodeIdx,Entropies]=DetermineNodeValue(SampleData,TrainData,Attributes, Map,NodeCondition,binsCount,EntrpCIndeX)

% Binning of Dataset on each attribute
for idx=1:length(Attributes)
    [SampleData,GradeMat]=EqualFrqncyPartn(SampleData,idx,binsCount,idx);
    TrainData=sortrows(TrainData,idx);
end
% Calculating Entropy for whole tree
startIndex=0;
[rows columns]=size(SampleData);
[Entropy]=CalculateEntropy(SampleData,EntrpCIndeX,startIndex,rows);
attributesLength=length(Attributes);

%  Calculating weighted entropy for each attribute
for idx=1:attributesLength
    Entropies(idx,1)=WeightedEntropy(SampleData,idx,TrainData,EntrpCIndeX);
end

% Finding min and index values
Entropies=Entropy-Entropies;
[M,NodeIdx] = min(Entropies);
NodeValue=Attributes(NodeIdx);

end
