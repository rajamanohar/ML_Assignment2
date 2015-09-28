load('iris.dat.mat');
Attributes=cellstr(char('SL','SW','PL','PW'));
% Change data into two partitions either setosa or not setosa
Cell=num2cell(Data);
repeats=[5,10,15,20];


for index=1:10
for repIndex=1:length(repeats)
[TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell);


dtr=ConstructDecisionTree(TrainData,Attributes,repeats(repIndex));

% % Perform testing on decision tree with validation data
Attributelist = java.util.ArrayList;
dataList = java.util.ArrayList;

for idx=1:length(Attributes)
    Attributelist.add(Attributes{idx,1});
end

[rows cols]=size(ValidationData);

for idx=1:rows
    tempCell=ValidationData(idx,1:4);
    tempCell=cell2mat(tempCell);
    for i=1:length(tempCell)
        dataList.add(tempCell(1,i));
    end
    
       PredictedClassLabels{idx,1}= traverseTree(dtr, Attributelist, dataList);

end

end

end

