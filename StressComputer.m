classdef StressComputer < handle
    
    properties (Access = public)
        Stress
    end
    
    properties (Access = private)
        nElem
        x
        Tnod
        Td
        mat1
        Strain
        R
        u_T = zeros(16,1)
        uprima_e
    end
    
    methods (Access = public)
        function obj = StressComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.computeStress();
        end
    end
    
    methods (Access = private)
        
        function init(obj,cParams)
            obj.u_T(cParams.vL) = cParams.uL;
            obj.nElem           = cParams.nElem;
            obj.x               = cParams.x;
            obj.Tnod            = cParams.Tnod;
            obj.Td              = cParams.Td;
            obj.mat1            = cParams.mat1;
        end
        
        function computeStress(obj)
            StressVector = zeros(obj.nElem,1);
            for iel = 1:obj.nElem
                s.x    = obj.x;
                s.Tnod = obj.Tnod;
                s.iel  = iel;
                s      = obj.computeElementCoordinates(s);
                obj.defineEuclidianMatrix(s);
                obj.defineLocalElementalDisplacementVectors(s);
                obj.computeStrain(s);
                StressVector(iel,1) = obj.mat1*obj.Strain(iel,1);
            end
            obj.Stress = StressVector;
        end
        
        function defineEuclidianMatrix(obj,s)
            Robj  = EuclidianMatrixComputer(s);
            Robj.compute();
            obj.R = Robj.R;
        end
        
        function defineLocalElementalDisplacementVectors(obj,s)
            u_e = zeros(4,1);
            for i = 1:4
                I        = obj.Td(s.iel,i);
                u_e(i,1) = obj.u_T(I,1);
            end
            obj.uprima_e = obj.R*u_e;
        end
        
        function computeStrain(obj,s)
            obj.Strain(s.iel,1) = (1/s.l)*[-1 1]*obj.uprima_e;
        end
        
    end
    
    methods (Access = private, Static)
        
        function s = computeElementCoordinates(s)
            BarElem = BarElemComputer(s);
            BarElem.compute();
            s.x1 = BarElem.x1;
            s.x2 = BarElem.x2;
            s.y1 = BarElem.y1;
            s.y2 = BarElem.y2;
            s.l = BarElem.l;
        end
        
    end
    
end

