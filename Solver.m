classdef Solver < handle
    
    properties (Access = public)
        u
    end
    
    properties (Access = protected)
        LHS
        RHS
    end
    
    methods (Access = public)
        
        function solveSystem(obj,s)
            obj.init(s.K_LL,s.F_extL);
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

