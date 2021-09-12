classdef IterativeRun < TestRun
    
    methods (Access = protected)
        
        function selectSolverType(obj)
            obj.Solver = 'I';
        end
        
    end
end

