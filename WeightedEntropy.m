function [InfoA] = WeightedEntropy(Cell,ClassIndexValue)
GradeMat = Cell(:, ClassIndexValue); 

GradeMat=cell2mat(GradeMat);
GradeMat=sortrows(GradeMat);
 [C,ia,ic] = unique(GradeMat,'last','rows')

startIndex=0;
InfoA=0;
 for idx=1:length(C)     
       InfoA=InfoA+(nnz(ic==idx)/length(ic))*CalculateEntropy(Cell,ClassIndexValue,startIndex,ia(idx,1),'num');
     startIndex=ia(idx,1);
      
  end
end




%  SelfAssessedHealthStatus=categorical(GradeMat,...
%      {'Low' 'Mid' 'High'},'Ordinal',true);
% summary(SelfAssessedHealthStatus);