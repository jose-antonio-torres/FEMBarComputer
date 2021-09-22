classdef SolverSelection < TestRun
    
    properties (Access = public)
        Solver
    end
    
    methods (Access = protected)
        function prepareTest(obj,s)
            obj.Solver = s.Solver;
        end
        
    end
end

