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
            Robj  = EuclidianMatrixComputer;
            Robj.compute(cParams);
            obj.R = Robj.R;
        end
        
        function computeElementalStiffnessMatrices(obj,s)
            K_el = zeros(4,4,s.nElem);
            for iel=1:s.nElem
                s.iel = iel;
                s = obj.computeBarLength(s);
                obj.computeEuclidianMatrix(s);
                Kprima = obj.computeLocalElementalStiffnessMatrix(s);
                s.Kprima = Kprima;
                Kelem = obj.computeGlobalElementalStiffnessMatrix(s);
                K_el(:,:,iel) = Kelem;
            end
            obj.Kel = K_el;
        end
        
        function Kelem = computeGlobalElementalStiffnessMatrix(obj,s)
            Kelem = obj.R'*s.Kprima*obj.R;
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
    
    methods (Access = private, Static)
        
        function s = computeBarLength(s)
            BarElem = BarElemComputer();
            BarElem.compute(s);
            s.x1      = BarElem.x1;
            s.x2      = BarElem.x2;
            s.y1      = BarElem.y1;
            s.y2      = BarElem.y2;
            s.l       = BarElem.l;
        end
        
        function Kprima = computeLocalElementalStiffnessMatrix(s)
            Kprima = s.mat1*s.mat2/s.l*[1 -1; -1 1];
        end
        
    end
    
end
