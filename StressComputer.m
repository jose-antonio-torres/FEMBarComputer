classdef StressComputer < handle
    
    properties (Access = public)
        Stress
    end
    
    properties (Access = private)
        Strain
        R
        u_T = zeros(16,1)
        uprima_e
    end
    
    methods (Access = public)
        function obj = StressComputer(s)
            obj.init(s);
            obj.computeStress(s);
        end
    end
    
    methods (Access = private)
        
        function init(obj,s)
            obj.u_T(s.vL) = s.uL;
        end
        
        function computeStress(obj,s)
            for iel = 1:s.nElem
                s.iel = iel;
                BarElem = BarElemComputer();
                BarElem.compute(s);
                s.l = BarElem.l;
                obj.defineEuclidianMatrix(BarElem);
                obj.defineLocalElementalDisplacementVectors(s);
                obj.computeStrain(s);
                StressVector(iel,1) = s.mat1*obj.Strain(iel,1);
            end
            obj.Stress = StressVector;
        end
        
        function defineEuclidianMatrix(obj,BarElem)
            Robj  = EuclidianMatrixComputer;
            Robj.compute(BarElem);
            obj.R = Robj.R;
        end
        
        function defineLocalElementalDisplacementVectors(obj,s)
            for i = 1:4
                I        = s.Td(s.iel,i);
                u_e(i,1) = obj.u_T(I,1);
            end
            obj.uprima_e = obj.R*u_e;
        end
        
        function computeStrain(obj,s)
            obj.Strain(s.iel,1) = (1/s.l)*[-1 1]*obj.uprima_e;
        end
        
    end
end

