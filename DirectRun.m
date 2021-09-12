classdef DirectRun < TestRun
    
    methods (Access = protected)
        
        function selectSolverType(obj)
            obj.Solver = 'D';
        end
        
    end
end

