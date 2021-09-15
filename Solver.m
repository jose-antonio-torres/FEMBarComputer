classdef Solver < handle
    
    properties (Access = public)
        u
    end
    
    properties (Access = protected)
        LHS
        RHS
    end
    
    methods (Access = public)
        
        function solveSystem(obj,cParams)
            obj.init(cParams.K_LL,cParams.F_extL);
            obj.computeDisplacements();
        end
        
    end
    
    methods (Access = private)
        function init(obj,K,F)
            obj.LHS = K;
            obj.RHS = F;
        end
    end
    
    methods (Abstract, Access = protected)
        computeDisplacements(obj);
    end
    
end

