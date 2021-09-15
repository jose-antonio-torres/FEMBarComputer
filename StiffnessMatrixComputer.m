classdef StiffnessMatrixComputer < handle
    
    properties (Access = private)
        Kel = zeros(4,4,12) 
        R
    end
    
    properties (Access = public)
        K = zeros(16,16) 
    end
    
    methods (Access = public)
        
        function obj = StiffnessMatrixComputer(nElem,mat1,mat2,Tnod,x,Td)
            obj.compute(nElem,mat1,mat2,Tnod,x,Td);
        end
        
    end
    
    methods (Access = private)
        
        function compute(obj,nElem,mat1,mat2,Tnod,x,Td)
            obj.computeElementalStiffnessMatrices(nElem,mat1,mat2,x,Tnod);
            obj.globalStiffnessMatrixAssembly(nElem,Td);
        end
        
        function computeEuclidianMatrix(obj,x1,x2,y1,y2,l)
            Robj  = EuclidianMatrixComputer(x1,x2,y1,y2,l);
            obj.R = Robj.R;
        end
        
        function computeElementalStiffnessMatrices(obj,nElem,mat1,mat2,x,Tnod)
            for iel=1:nElem
                [x1,x2,y1,y2,l] = obj.computeBarLength(x,Tnod,iel);
                obj.computeEuclidianMatrix(x1,x2,y1,y2,l);
                Kprima        = mat1*mat2/l*[1 -1; -1 1];
                Kelem         = obj.R'*Kprima*obj.R;
                K_el(:,:,iel) = Kelem;
            end
            obj.Kel = K_el;
        end
        
        function [x1,x2,y1,y2,l] = computeBarLength(obj,x,Tnod,iel) % Static without obj
                BarElem = BarElemComputer(x,Tnod,iel);
                x1      = BarElem.x1;
                x2      = BarElem.x2;
                y1      = BarElem.y1;
                y2      = BarElem.y2;
                l       = BarElem.l;
        end
        
        function globalStiffnessMatrixAssembly(obj,nElem,Td)
            K_global = obj.K;
            for iel = 1:nElem
                for i = 1:4
                    I = Td(iel,i);
                    for j = 1:4
                        J = Td(iel,j);
                        K_global(I,J) = K_global(I,J)+obj.Kel(i,j,iel);
                    end
                end
            end
            obj.K = K_global;
        end
        
    end
end
