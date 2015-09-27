function [dtr]=ConstructDecisionTree(TrainData,Attributes)

dtr = java.util.HashMap;
SampleData=TrainData;
% Root Node construction 

[SampleData NodeValue NodeIdx Entropies]=DetermineNodeValue(SampleData,TrainData,Attributes,dtr,0)
dtr=createOrUpdateTree(dtr,NodeValue,NodeValue,0);

<<<<<<< HEAD
binMaxes=FindBinMaxes(SampleData,NodeIdx,TrainData);
  
% ConstrcutChildNodes();
%  check class labels data for each bin 

% for binIndex=1:length(binMaxes)
% startIndex=1;
% BinClasses=C(startIndex:ia(binIndex,1),5);
% BinClasses=cell2mat(BinClasses);
% BinClasses=sortrows(BinClasses);
% [binClassDist,binClassEnds,binClassVals] = unique(BinClasses,'last','rows');
% end
% 
% if length(binClassDist)==1
%     if binClassDist==1
%         classLabel='SETOSA';
%     elseif binClassDist==2
%         classLabel='OTHERS';
%         
%         dtr=createOrUpdateTree(dtr,classLabel,NodeValue,binMaxes(NodeIdx,1));
%     end
% else length(binClassDist)>1
%     
% end
=======
[binMaxes,binEndIndexs]=FindBinMaxes(SampleData,NodeIdx,TrainData);
 ConstructChildNodes(dtr,NodeValue,binMaxes,binEndIndexs,SampleData);


>>>>>>> develop



    
    

end