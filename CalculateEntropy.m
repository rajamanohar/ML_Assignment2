function [Entropy] = CalculateEntropy(Cell,EntrpCIndeX,startIndex,endIndex,type)
     startIndex=startIndex+1;
     entropyMat = Cell(startIndex:endIndex,EntrpCIndeX); 
     
     entropyMat=sortrows(entropyMat,1);

    if(type=='char')
  [distinctObj,EndIndeces,ObjNames] = unique(entropyMat,'last','legacy')
    else
        [distinctObj,EndIndeces,ObjNames] = unique(entropyMat,'last','rows')
    end
  
     Entropy=0;
   for idx=1:length(distinctObj)
       p= (nnz(ObjNames==idx)/length(ObjNames));
       Entropy=Entropy-p*log2(p);
    end
    
  
end