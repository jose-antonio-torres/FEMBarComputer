classdef DirectSolver < Solver
    
    methods (Access = protected)
        
        function computeDisplacements(obj)
            obj.u = obj.LHS\obj.RHS;
        end
        
    end
end

