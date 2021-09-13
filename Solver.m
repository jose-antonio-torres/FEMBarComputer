classdef Solver < handle
    
    properties (Access = public)
        u
    end
    
    properties (Access = protected)
        LHS
        RHS
    end
    
    methods (Access = public)
        
        function solveSystem(obj,K,F)
            obj.LHS = K;
            obj.RHS = F;
            obj.computeDisplacements();
        end
        
    end
    
    methods (Abstract, Access = protected)
        computeDisplacements(obj);
    end
    
end

