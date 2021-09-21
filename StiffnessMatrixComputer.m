classdef StiffnessMatrixComputer < handle
    
    properties (Access = private)
        Kel
        R
    end
    
    properties (Access = public)
        K 
    end
    
    methods (Access = public)
        
        function obj = StiffnessMatrixComputer()
            obj.init();
        end
        
        function compute(obj,s)
            obj.computeElementalStiffnessMatrices(s);
            obj.globalStiffnessMatrixAssembly(s);
        end
        
    end
    
    methods (Access = private)
        
        function init(obj)
            obj.Kel = zeros(4,4,12);
            obj.K = zeros(16,16);
        end
        
        function computeEuclidianMatrix(obj,cParams)
            s = cParams;
            Robj  = EuclidianMatrixComputer;
            Robj.compute(s);
            obj.R = Robj.R;
        end
        
        function computeElementalStiffnessMatrices(obj,s)
            for iel=1:s.nElem
                s.iel = iel;
                [cParams] = obj.computeBarLength(s);
                obj.computeEuclidianMatrix(cParams);
                Kprima        = s.mat1*s.mat2/cParams.l*[1 -1; -1 1];
                Kelem         = obj.R'*Kprima*obj.R;
                K_el(:,:,iel) = Kelem;
            end
            obj.Kel = K_el;
        end
        
        function [cParams] = computeBarLength(obj,s) % Static without obj
                BarElem = BarElemComputer();
                BarElem.compute(s);
                cParams.x1      = BarElem.x1;
                cParams.x2      = BarElem.x2;
                cParams.y1      = BarElem.y1;
                cParams.y2      = BarElem.y2;
                cParams.l       = BarElem.l;
        end
        
        function globalStiffnessMatrixAssembly(obj,s)
            K_global = obj.K;
            for iel = 1:s.nElem
                for i = 1:4
                    I = s.Td(iel,i);
                    for j = 1:4
                        J = s.Td(iel,j);
                        K_global(I,J) = K_global(I,J)+obj.Kel(i,j,iel);
                    end
                end
            end
            obj.K = K_global;
        end
        
    end
end
