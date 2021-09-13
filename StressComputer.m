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
        function obj = StressComputer(nElem,uL,vL,x,Tnod,Td,mat1)
            obj.defineGlobalDisplacementVector(uL,vL);
            obj.computeStress(nElem,x,Tnod,Td,mat1);
        end
    end
    
    methods (Access = private)
        
        function defineGlobalDisplacementVector(obj,uL,vL)
            obj.u_T(vL) = uL;
        end
        
        function computeStress(obj,nElem,x,Tnod,Td,mat1)
            for iel = 1:nElem
                BarElem = BarElemComputer(x,Tnod,iel);
                obj.defineEuclidianMatrix(BarElem.x1,BarElem.x2,...
                    BarElem.y1,BarElem.y2,BarElem.l);
                obj.defineLocalElementalDisplacementVectors(Td,iel);
                obj.computeStrain(BarElem.l,iel);
                StressVector(iel,1) = mat1*obj.Strain(iel,1);
            end
            obj.Stress = StressVector;
        end
        
        function defineEuclidianMatrix(obj,x1,x2,y1,y2,l)
            Robj  = EuclidianMatrixComputer(x1,x2,y1,y2,l);
            obj.R = Robj.R;
        end
        
        function defineLocalElementalDisplacementVectors(obj,Td,iel)
            for i = 1:4
                I        = Td(iel,i);
                u_e(i,1) = obj.u_T(I,1);
            end
            obj.uprima_e = obj.R*u_e;
        end
        
        function computeStrain(obj,l,iel)
            obj.Strain(iel,1) = (1/l)*[-1 1]*obj.uprima_e;
        end
        
    end
end

