function [Entropy] = CalculateEntropy(Cell,EntrpCIndeX,startIndex,endIndex)

     startIndex=startIndex+1;
     entropyMat = cell2mat(Cell(startIndex:endIndex,EntrpCIndeX)); 
     entropyMat=sortrows(entropyMat,1);

    [distinctObj,EndIndeces,ObjNames] = unique(entropyMat,'last','rows');
    Entropy=0;
   for idx=1:length(distinctObj)
       p= (nnz(ObjNames==idx)/length(ObjNames));
       Entropy=Entropy-p*log2(p);
   end
end