function [NodeValue]=DetermineNodeValue(C,TrainData,Attributes, Map,NodeCondition)

% Binning of Dataset on each attribute
for idx=1:length(AttributeName)
    [C,GradeMat]=EqualFrqncyPartn(C,idx,5,idx);
end
% Calculating Entropy for whole tree
 startIndex=0;
 [Entropy]=CalculateEntropy(C,5,startIndex,length(C));
 attributesLength=length(Attributes);
  
%  Calculating weighted entropy for each attribute 
  for idx=1:attributesLength
    Entropies(idx,1)=WeightedEntropy(C,idx,TrainData);
  end
  
% Finding min and index values
 Entropies=Entropy-Entropies;
 [M,I] = min(Entropies);
 
 NodeValue=AttributeName(I);

end
