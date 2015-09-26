function [dtr]=ConstructDecisionTree(TrainData,Attributes)

dtr = java.util.HashMap;
SampleData=TrainData;
% Root Node construction 

NodeValue=determineNodeValue(SampleData,TrainData,Attributes,dtr,0);

dtr=createOrUpdateTree(dtr,AttributeName(I),AttributeName(I),0);


 C=sortrows(C,I);
 TrainData=sortrows(TrainData,I);
 GradeMat = C(:, I); 
 GradeMat=cell2mat(GradeMat);
 GradeMat=sortrows(GradeMat);
 [distinct,ia,ic] = unique(GradeMat,'last','rows');
 binMaxes=TrainData(ia(:,1),I);
%  check class labels data for each bin 
startIndex=1;
BinClasses=C(startIndex:ia(1,1),5);
BinClasses=cell2mat(BinClasses);
BinClasses=sortrows(BinClasses);
[binClassDist,binClassEnds,binClassVals] = unique(BinClasses,'last','rows');

if length(binClassDist)==1
    if binClassDist==1
        classLabel='SETOSA';
    elseif binClassDist==2
        classLabel='OTHERS';
    end
end


dtr=createOrUpdateTree(dtr,classLabel,AttributeName(I),binMaxes(1,1));
    
    

end