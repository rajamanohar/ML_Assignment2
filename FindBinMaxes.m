function [binMaxes binEndIndexs]=FindBinMaxes(SampleData,NodeIdx,TrainData)


 
 NodeAttrClumnMat = SampleData(:, NodeIdx); 
 NodeAttrClumnMat=cell2mat(NodeAttrClumnMat);
 NodeAttrClumnMat=sortrows(NodeAttrClumnMat,1);
 
 [distinct,binEndIndexs,ic] = unique(NodeAttrClumnMat,'last','rows');
 
 
  TrainAttrClumnMat = TrainData(:, NodeIdx); 
  TrainAttrClumnMat=cell2mat(TrainAttrClumnMat);
  TrainAttrClumnMat=sortrows(TrainAttrClumnMat);
 
 
  binMaxes=TrainAttrClumnMat(binEndIndexs(:,1),1);
  
end