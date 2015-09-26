function [Cell,MAT] = EqualFrqncyPartn(Cell,partnCIdx,no_Partn,newCIdx)
%Equal width partitioning will be applied on matrix B and partioned into
%no_partn( no. of partitions, orderGrade is ordered grading vector
B=cell2mat(Cell(:,partnCIdx));
B=sort(B);
width=length(B)/no_Partn;
edges(1,1)=B(1,1);
 for i=1:no_Partn;
     edges(1,1+i)=B(i*width,1);
 end

% K= histcounts(B,edges);
MAT = discretize(B,edges,'IncludedEdge','right');

Cell=sortrows(Cell,partnCIdx);
% % %inserting grades into Cell Array
 for index=1:length(MAT)
    Cell{index,newCIdx}=MAT(index,:);    
 end
 
 
end