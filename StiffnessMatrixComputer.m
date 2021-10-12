classdef StiffnessMatrixComputer < handle
    
    properties (Access = private)
        Kel
        R
        nElem
        x
        Tnod
        Td
        mat1
        mat2
        Kprima
    end
    
    properties (Access = public)
        K
    end
    
    methods (Access = public)
        
        function obj = StiffnessMatrixComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.computeElementalStiffnessMatrices();
            obj.globalStiffnessMatrixAssembly();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj,cParams)
            obj.Kel   = zeros(4,4,12);
            obj.K     = zeros(16,16);
            obj.nElem = cParams.nElem;
            obj.x     = cParams.x;
            obj.Tnod  = cParams.Tnod;
            obj.Td    = cParams.Td;
            obj.mat1  = cParams.mat1;
            obj.mat2  = cParams.mat2;
        end
        
        function computeEuclidianMatrix(obj,s)
            Robj  = EuclidianMatrixComputer(s);
            Robj.compute();
            obj.R = Robj.R;
        end
        
        function computeElementalStiffnessMatrices(obj)
            Ke = zeros(4,4,obj.nElem);
            for iel=1:obj.nElem
                s.x        = obj.x;
                s.Tnod     = obj.Tnod;
                s.iel      = iel;
                s          = obj.computeBarLength(s);
                obj.computeEuclidianMatrix(s);
                obj.computeLocalElementalStiffnessMatrix(s.l);
                Ke(:,:,iel) = obj.computeGlobalElementalStiffnessMatrix();
            end
            obj.Kel = Ke;
        end
        
        function Kprima = computeLocalElementalStiffnessMatrix(obj,l)
            obj.Kprima = obj.mat1*obj.mat2/l*[1 -1; -1 1];
        end
        
        function Kelem = computeGlobalElementalStiffnessMatrix(obj)
            Kelem = obj.R'*obj.Kprima*obj.R;
        end
        
        function globalStiffnessMatrixAssembly(obj)
            KG = obj.K;
            for iel = 1:obj.nElem
                for i = 1:4
                    I = obj.Td(iel,i);
                    for j = 1:4
                        J = obj.Td(iel,j);
                        KG(I,J) = KG(I,J)+obj.Kel(i,j,iel);
                    end
                end
            end
            obj.K = KG;
        end
        
    end
    
    methods (Access = private, Static)
        
        function s = computeBarLength(s)
            BarElem = BarElemComputer(s);
            BarElem.compute();
            s.x1      = BarElem.x1;
            s.x2      = BarElem.x2;
            s.y1      = BarElem.y1;
            s.y2      = BarElem.y2;
            s.l       = BarElem.l;
        end
        
    end
    
end
