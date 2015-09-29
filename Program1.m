load('iris.dat.mat');
Attributes=cellstr(char('SL','SW','PL','PW'));
RepeatBinSizes=[5,10,15,20];

% Change data into two partitions either setosa or not setosa
Cell=num2cell(Data);
MinAvgMaxAcc=[];

% Repeating the decision tree for all bin sizes
for binIndex=1:length(RepeatBinSizes)
    
    BinAccuracies=[];
    
    [TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell);
    dtr=ConstructDecisionTree(TrainData,Attributes,RepeatBinSizes(binIndex));
    
    %     repeating the test for 10 times for each bin
    for index=1:10
        
        
        
        Attributelist = java.util.ArrayList;
        dataList = java.util.ArrayList;
        
        for idx=1:length(Attributes)
            Attributelist.add(Attributes{idx,1});
        end
        % % Perform testing on decision tree with validation data
        % Performing each run different test data
        [TestData, ValidationData, TestData]=DatasetPartition(Data,Cell);
        
        
        [rows cols]=size(ValidationData);
        classLabels=[];
        actialClassLabels=ValidationData(:,5);
        
        for idx=1:rows
            tempCell=ValidationData(idx,1:4);
            tempCell=cell2mat(tempCell);
            for i=1:length(tempCell)
                dataList.add(tempCell(1,i));
            end
            
            %             Traversing tree to predict the class labels
            classLabel = traverseTree(dtr, Attributelist, dataList);
            
            if (strcmp(classLabel,'SETOSA')) && (actialClassLabels{idx,1}==1)
                classLabels{1,idx}=1;
            elseif (strcmp(classLabel,'OTHERS')) && (actialClassLabels{idx,1}==2)
                classLabels{1,idx}=1;
            else
                classLabels{1,idx}=0;
            end
            
        end
        %         Accuracy of predicted class labels
        accurlabels=cell2mat(classLabels);
        accuracy=nnz(accurlabels==1)/length(accurlabels);
        BinAccuracies{index,1}=accuracy;
        
        
        
    end
    %     Finding min avg and max for each bin case
    BinAccuracymat=cell2mat(BinAccuracies);
    MinAvgMaxAcc{binIndex,1}=min(BinAccuracymat);
    MinAvgMaxAcc{binIndex,2}=mean(BinAccuracymat);
    MinAvgMaxAcc{binIndex,3}=max(BinAccuracymat);
end

mins=MinAvgMaxAcc(:,1);
mins=cell2mat(mins);
avgs=MinAvgMaxAcc(:,2);
avgs=cell2mat(avgs);
maxs=MinAvgMaxAcc(:,3);
maxs=cell2mat(maxs);

bins=RepeatBinSizes;

% Plotting bins min,avg and max accuracies
figure()
plot(bins,mins','-ro',bins,avgs','-.b',bins,maxs','-bx')
legend({'Minimum Accuracy','Average Accuracy','Maximum Accuracy'},...
    'FontSize',8,'FontWeight','bold');
ylim([0 1]);
title('Accuracy vs  No. of Bins');
xlabel('Bin Size');
ylabel('Accuracy');
