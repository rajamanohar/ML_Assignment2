function [InfoA] = WeightedEntropy(Cell,ClassIndexValue,TrainData,EntrpCIndeX)
GradeMat = Cell(:, ClassIndexValue);
GradeMat=cell2mat(GradeMat);
GradeMat=sortrows(GradeMat);
[C,ia,ic] = unique(GradeMat,'last','rows');

startIndex=0;
InfoA=0;
for idx=1:length(C)
    InfoA=InfoA+(nnz(ic==idx)/length(ic))*CalculateEntropy(Cell,EntrpCIndeX,startIndex,ia(idx,1));
    startIndex=ia(idx,1);
    
end
end