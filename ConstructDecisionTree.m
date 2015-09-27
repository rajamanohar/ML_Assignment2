function [dtr]=ConstructDecisionTree(TrainData,Attributes,binsCount)

dtr = java.util.HashMap;
SampleData=TrainData;
% Root Node construction
  % Entropy Column index should be the last column number,as it
        % contains class labels
   EntrpCIndeX=length(Attributes)+1;
        
[SampleData NodeValue NodeIdx Entropies]=DetermineNodeValue(SampleData,TrainData,Attributes,dtr,0,binsCount,EntrpCIndeX)
dtr=createOrUpdateTree(dtr,NodeValue,NodeValue,0);

[binMaxes,binEndIndexs]=FindBinMaxes(SampleData,NodeIdx,TrainData);

% Removing root node name from the attributes list 
NewAttributes=Attributes;
NewAttributes{NodeIdx,1}= [];
NewAttributes(any(cellfun(@isempty,NewAttributes),2),:) = [];
  
ConstructChildNodes(dtr,NodeValue,NodeIdx,binMaxes,binEndIndexs,SampleData,TrainData,NewAttributes,binsCount);


end