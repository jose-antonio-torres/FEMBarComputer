classdef DirectSolver < Solver
    
    methods (Access = protected)
        
        function solve(obj)
            obj.u = obj.LHS\obj.RHS;
        end
        
    end
end

