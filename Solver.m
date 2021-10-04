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
            obj.init(cParams);
            obj.computeUnknowns();
        end
        
    end
    
    methods (Access = private)
        function init(obj,cParams)
            obj.LHS = cParams.K_LL;
            obj.RHS = cParams.F_extL;
        end
    end
    
    methods (Abstract, Access = protected)
        computeUnknowns(obj);
    end
    
end

