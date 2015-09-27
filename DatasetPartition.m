function [TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell)
[rows,columns]=size(Data);

for idx=1:length(Cell)
    if(Cell{idx,5}==1)
        Cell{idx,5}=1;
    else
        Cell{idx,5}=2;
    end
end

randIdx=randperm(rows);
trainIdx=randIdx(1,1:105);
validationIdx=randIdx(1,106:127);
testIdx=randIdx(1,128:150);

TrainData=Cell(trainIdx,:);
ValidationData=Cell(validationIdx,:);
TestData=Cell(testIdx,:);
end
