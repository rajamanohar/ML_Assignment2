load('iris.dat.mat');

% Change data into two partitions either setosa or not setosa 
Cell=num2cell(Data);

[TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell);

TrainData=sortrows(TrainData,5);
C=TrainData;

% Binning of Dataset on each attribute
[C,GradeMat]=EqualFrqncyPartn(TrainData,1,5,1);
[C,GradeMat]=EqualFrqncyPartn(C,2,5,2);
[C,GradeMat]=EqualFrqncyPartn(C,3,5,3);
[C,GradeMat]=EqualFrqncyPartn(C,4,5,4);

startIndex=0;
%    [Entropy]=CalculateEntropy(C,5,startIndex,length(C),'char');
 
  InfoA=WeightedEntropy(C,1);



