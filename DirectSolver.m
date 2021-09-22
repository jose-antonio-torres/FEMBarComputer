classdef DirectSolver < Solver
    
    methods (Access = protected)
        
        function computeUnknowns(obj)
            obj.u = obj.LHS\obj.RHS;
        end
        
    end
end

