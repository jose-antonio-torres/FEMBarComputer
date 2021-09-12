classdef SolverFactory < handle
    
    methods (Access = public, Static)
        function obj = create(cParams)
            if cParams.type == 'D' 
                obj = DirectSolver;
            elseif cParams.type == 'I'
                obj = IterativeSolver;
            else
                disp('The solver method is incorrectly specified')
            end 
        end
    end
    
end

