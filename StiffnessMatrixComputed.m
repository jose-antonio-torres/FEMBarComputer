classdef StiffnessMatrixComputed < handle
    
    properties (Access = private)
        Kel = zeros(4,4,12) 
        R
    end
    
    properties (Access = public)
        Td
        K = zeros(16,16) 
    end
    
    methods (Access = public)
        
        function obj = StiffnessMatrixComputed(nElem,mat1,mat2,Tnod,x)
            obj.computeElementalStiffnessMatrices(nElem,mat1,mat2,x,Tnod);
            obj.defineDoFMatrix(nElem,Tnod);
            obj.globalStiffnessMatrixAssembly(nElem);
        end
        
    end
    
    methods (Access = private)
        
        function computeRotationMatrix(obj,nElem,x1,x2,y1,y2,l)
            obj.R = zeros(2,4,nElem);
            obj.R=(1/l)*[x2-x1 y2-y1 0 0; 0 0 x2-x1 y2-y1];
        end
        
        function computeElementalStiffnessMatrices(obj,nElem,mat1,mat2,x,Tnod)
            for iel=1:nElem
                [x1,x2,y1,y2,l] = obj.computeBarLength(x,Tnod,iel);
                obj.computeRotationMatrix(nElem,x1,x2,y1,y2,l);
                Kprima=mat1*mat2/l*[1 -1; -1 1];
                Kelem=obj.R'*Kprima*obj.R;
                K_el(:,:,iel)=Kelem;
            end
            obj.Kel = K_el;
        end
        
        function [x1,x2,y1,y2,l] = computeBarLength(obj,x,Tnod,iel) % Static without obj
                BarElem = BarElemComputed(x,Tnod,iel);
                x1 = BarElem.x1;
                x2 = BarElem.x2;
                y1 = BarElem.y1;
                y2 = BarElem.y2;
                l = BarElem.l;
        end
        
        function defineDoFMatrix(obj,nElem,Tnod)
            for iel=1:nElem
                for a=1:2
                    for j=1:2
                        i=2*(a-1)+j;
                        obj.Td(iel,i)=2*(Tnod(iel,a)-1)+j;
                    end
                end
            end
        end
        
        function globalStiffnessMatrixAssembly(obj,nElem)
            for iel=1:nElem
                for i=1:4
                    I=obj.Td(iel,i);
                    for j=1:4
                        J=obj.Td(iel,j);
                        obj.K(I,J)=obj.K(I,J)+obj.Kel(i,j,iel);
                    end
                end
            end
        end
        
    end
end
