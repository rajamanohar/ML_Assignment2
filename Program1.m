load('iris.dat.mat');
Attributes=cellstr(char('SL','SW','PL','PW'));
RepeatBinSizes=[5,10,15,20];

% Change data into two partitions either setosa or not setosa
Cell=num2cell(Data);
MinAvgMaxAcc=[];


for binIndex=1:length(RepeatBinSizes)
    BinAccuracies=[];
    for index=1:10
        [TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell);
        dtr=ConstructDecisionTree(TrainData,Attributes,RepeatBinSizes(binIndex));
        
        
        % % Perform testing on decision tree with validation data
        Attributelist = java.util.ArrayList;
        dataList = java.util.ArrayList;
        
        for idx=1:length(Attributes)
            Attributelist.add(Attributes{idx,1});
        end
        
        [rows cols]=size(ValidationData);
        classLabels=[];
        actialClassLabels=ValidationData(:,5);
        
        for idx=1:rows
            tempCell=ValidationData(idx,1:4);
            tempCell=cell2mat(tempCell);
            for i=1:length(tempCell)
                dataList.add(tempCell(1,i));
            end
            
            classLabel = traverseTree(dtr, Attributelist, dataList);
            
            if (strcmp(classLabel,'SETOSA')) && (actialClassLabels{idx,1}==1)
                 classLabels{idx,1}=1;
            elseif (strcmp(classLabel,'OTHERS')) && (actialClassLabels{idx,1}==2)
                 classLabels{idx,1}=1;
            else
                 classLabels{idx,1}=0;
            end
            
        end
        accurlabels=cell2mat(classLabels);
        accuracy=nnz(accurlabels==1)/length(accurlabels);
        BinAccuracies{1,index}=accuracy;
        
    end
    BinAccuracymat=cell2mat(BinAccuracies);
    
    MinAvgMaxAcc{binIndex,1}=min(BinAccuracymat);
    MinAvgMaxAcc{binIndex,1}=mean(BinAccuracymat);
    MinAvgMaxAcc{binIndex,1}=max(BinAccuracymat);
end
disp(MinAvgMaxAcc);
