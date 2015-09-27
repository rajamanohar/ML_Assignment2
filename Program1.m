load('iris.dat.mat');
Attributes=cellstr(char('SL','SW','PL','PW'));
% Change data into two partitions either setosa or not setosa
Cell=num2cell(Data);

[TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell);
dtr=ConstructDecisionTree(TrainData,Attributes,5);


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
    
    [classLabel] = traverseTree(dtr, Attributelist, dataList);
end

