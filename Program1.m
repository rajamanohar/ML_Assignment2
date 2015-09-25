load('iris.dat.mat');
AttributeName=cellstr(char('SL','SW','PL','PW'));
% Change data into two partitions either setosa or not setosa 
Cell=num2cell(Data);

[TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell);

TrainData=sortrows(TrainData,5);
C=TrainData;

% Binning of Dataset on each attribute

[C,GradeMat]=EqualFrqncyPartn(C,1,5,1);
[C,GradeMat]=EqualFrqncyPartn(C,2,5,2);
[C,GradeMat]=EqualFrqncyPartn(C,3,5,3);
[C,GradeMat]=EqualFrqncyPartn(C,4,5,4);

% Calculating Entropy for whole tree
startIndex=0;
[Entropy]=CalculateEntropy(C,5,startIndex,length(C));
 attributesLength=4;
 
%  Calculating weighted entropy for each attribute 
 for idx=1:attributesLength
   Entropies(idx,1)=WeightedEntropy(C,idx);
 end
[M,I] = min(Entropies);

TreeCell{1,1}=AttributeName{I,1};
TreeCell{1,2}=0;
TreeCell{1,3}=0;

