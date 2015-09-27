load('iris.dat.mat');
Attributes=cellstr(char('SL','SW','PL','PW'));
% Change data into two partitions either setosa or not setosa
Cell=num2cell(Data);
[TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell);
dtr=ConstructDecisionTree(TrainData,Attributes);
