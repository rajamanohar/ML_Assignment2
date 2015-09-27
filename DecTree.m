classdef DecTree
    properties
        TrainData=[];
        ValidationData=[];
        TestData=[];
    end
    
    methods
        
        function obj= DecisionTree(a,b,c)
            [obj.TrainData,obj.ValidationData,obj.TestData]=obj.DatasetPartition(a,b);
            obj.dectr=ConstructDecisionTree(obj.TrainData,c);
        end
        
        
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
        
        function [map] = createOrUpdateTree(map,node_name, parent_name, bin_condition)
            list = java.util.ArrayList;
            list.add(node_name);
            list.add(parent_name);
            list.add(bin_condition);
            
            size = map.size();
            index = size + 1;
            
            map.put(index, list);
        end
        
        function [NodeValue]=DetermineNodeValue(C,TrainData,Attributes, Map,NodeCondition)
            
            % Binning of Dataset on each attribute
            for idx=1:length(AttributeName)
                [C,GradeMat]=EqualFrqncyPartn(C,idx,5,idx);
            end
            % Calculating Entropy for whole tree
            startIndex=0;
            [Entropy]=CalculateEntropy(C,5,startIndex,length(C));
            attributesLength=length(Attributes);
            
            %  Calculating weighted entropy for each attribute
            for idx=1:attributesLength
                Entropies(idx,1)=WeightedEntropy(C,idx,TrainData);
            end
            
            % Finding min and index values
            Entropies=Entropy-Entropies;
            [M,I] = min(Entropies);
            
            NodeValue=AttributeName(I);
            
        end
        
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
        
        function [InfoA] = WeightedEntropy(Cell,ClassIndexValue,TrainData)
            GradeMat = Cell(:, ClassIndexValue);
            GradeMat=cell2mat(GradeMat);
            GradeMat=sortrows(GradeMat);
            [C,ia,ic] = unique(GradeMat,'last','rows');
            
            
            startIndex=0;
            InfoA=0;
            for idx=1:length(C)
                InfoA=InfoA+(nnz(ic==idx)/length(ic))*CalculateEntropy(Cell,5,startIndex,ia(idx,1));
                startIndex=ia(idx,1);
                
            end
        end
        
        function [] = ConstructChildNodes(dtr,NodeValue,binMaxes,binEndIndexs,SampleData)
            %  check class labels data for each bin
            
            for binIndex=1:length(binMaxes)
                startIndex=1;
                BinClasses=SampleData(startIndex:binEndIndexs(binIndex,1),5);
                BinClasses=cell2mat(BinClasses);
                BinClasses=sortrows(BinClasses);
                
                [binClassDist,binClassEnds,binClassVals] = unique(BinClasses,'last','rows');
                if length(binClassDist)==1
                    if binClassDist==1
                        classLabel='SETOSA';
                    elseif binClassDist==2
                        classLabel='OTHERS';
                    end
                    dtr=createOrUpdateTree(dtr,classLabel,NodeValue,binMaxes(binIndex,1));
                else length(binClassDist)>1
                    
                    
                    
                end
                
            end
            
        end
        
        function [classLabel] = traverseTree(map, attrList, dataList)
            dataMap = java.util.HashMap;
            
            for i = 0 : attrList.size()
                if(strcmp(attrList.get(i), 'PL') == 1)
                    dataMap.put(attrList.get(i), dataList.get(i));
                elseif(strcmp(attrList.get(i), 'PW')==1)
                    dataMap.put(attrList.get(i), dataList.get(i));
                elseif(strcmp(attrList.get(i), 'SL')==1)
                    dataMap.put(attrList.get(i), dataList.get(i));
                elseif(strcmp(attrList.get(i), 'SW')==1)
                    dataMap.put(attrList.get(i), dataList.get(i));
                end
            end
            
            rootNodeLabel = map.get(0).get(0);
            tempLabel = rootNodeLabel;
            
            while(strcmp(tempLabel, 'SETOSA') == 0 && strcmp(tempLabel, 'OTHERS') == 0)
                [nextNodeIndex,nextNodeLabel] = findNextNode(map, tempLabel, dataMap.get(tempLabel));
                tempLabel = map.get(nextNodeIndex).get(0);
                break;
            end
            
            classLabel = tempLabel;
        end
        
        function [nextNodeIndex, nextNodeLabel] = findNextNode(map, parentNodeLabel, value)
            nextNodeIndex = 0;
            nextNodeLabel = '';
            for i = 1 : map.size()
                nodeData = map.get(i);
                if(strcmp(nodeData.get(1), parentNodeLabel) && nodeData.get(2) > value)
                    nextNodeLabel = nodeData.get(0);
                    nextNodeIndex = i;
                    break;
                end
            end
        end
        
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
        
        
        function [TrainData, ValidationData, TestData]=DatasetPartition(Data,Cell)
            [rows,columns]=size(Data);
            
            for idx=1:length(Cell)
                if(Cell{idx,5}==1)
                    Cell{idx,5}=1;
                else
                    Cell{idx,5}=2;
                end
            end
            
            
            randIdx=randperm(rows);
            trainIdx=randIdx(1,1:105);
            validationIdx=randIdx(1,106:127);
            testIdx=randIdx(1,128:150);
            
            TrainData=Cell(trainIdx,:);
            ValidationData=Cell(validationIdx,:);
            TestData=Cell(testIdx,:);
        end
        
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
    end
end