function [dtr]=ConstructDecisionTree(TrainData,Attributes)

dtr = java.util.HashMap;
SampleData=TrainData;
% Root Node construction

[SampleData NodeValue NodeIdx Entropies]=DetermineNodeValue(SampleData,TrainData,Attributes,dtr,0)
dtr=createOrUpdateTree(dtr,NodeValue,NodeValue,0);

[binMaxes,binEndIndexs]=FindBinMaxes(SampleData,NodeIdx,TrainData);
NewAttributes=Attributes;

NewAttributes{NodeIdx,1}= [];

ConstructChildNodes(dtr,NodeValue,binMaxes,binEndIndexs,SampleData,TrainData);



end