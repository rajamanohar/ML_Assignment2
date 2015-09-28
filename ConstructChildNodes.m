
function [parentIdx,index]= ConstructChildNodes(dtr,NodeValue,NodeIdx,binMaxes,...
    binEndIndexs,SampleData,TrainData,NewAttributes,binsCount,parentIdx)

%  check class labels data for each bin

SampleData=sortrows(SampleData,NodeIdx);
TrainData=sortrows(TrainData,NodeIdx);

startIndex=1;
for binIndex=1:length(binMaxes)
    
    %  Check class labels values in each bin, i.e on last column
    [rows Columns]=size(SampleData);
    BinClasses=SampleData(startIndex:binEndIndexs(binIndex,1),Columns);
    BinClasses=cell2mat(BinClasses);
    BinClasses=sortrows(BinClasses);
    
    [binClassDist,binClassEnds,binClassVals] = unique(BinClasses,'last','rows');
    %     fprintf('you are in %d \n',binIndex);
    %     fprintf('node value \n');
    %     disp(NodeValue);
    
    if length(binClassDist)==1
        if  binClassDist==1
            classLabel='SETOSA';
        elseif binClassDist(1,1)==2
            classLabel='OTHERS';
        end
        [dtr,index]=createOrUpdateTree(dtr,classLabel,NodeValue,binMaxes(binIndex,1),parentIdx);
        
    elseif length(binClassDist)>1
        
        binTrainData=TrainData;
        binTrainData(:,NodeIdx)=[];
        binTrainData(any(cellfun(@isempty,binTrainData),2),:) = [];
        binTrainData=binTrainData(startIndex:binEndIndexs(binIndex,1),:);
        binSampleData=binTrainData;
        
        % Entropy Column index should be the last column number,as it
        % contains class labels
        EntrpCIndeX=length(NewAttributes)+1;
        
        [binSampleData,ChildNodeValue,ChildNodeIdx,ChildEntropies]=DetermineNodeValue(...
            binSampleData,binTrainData,NewAttributes,dtr,binMaxes(binIndex,1),...
            binsCount,EntrpCIndeX);
        
        
        [dtr,index]=createOrUpdateTree(dtr,ChildNodeValue,...
            NodeValue,binMaxes(binIndex,1),parentIdx);
        
        parentIdx=index;
        
        [childBinMaxes,ChildBinEndIndexs]=FindBinMaxes(binSampleData,...
            ChildNodeIdx,binTrainData);
        
        NewChildAttributes=NewAttributes;
        NewChildAttributes{ChildNodeIdx,1}= [];
        NewChildAttributes(any(cellfun(@isempty,NewChildAttributes),2),:) = [];
        
        
        
        
        [parentIdx,index]=ConstructChildNodes(dtr,ChildNodeValue,ChildNodeIdx,...
            childBinMaxes,ChildBinEndIndexs,binSampleData,binTrainData,...
            NewChildAttributes,binsCount,parentIdx);
        
        
        parentIdx=dtr.get(parentIdx).get(3);
        
        
    end
    startIndex=binEndIndexs(binIndex,1)+1;
end

