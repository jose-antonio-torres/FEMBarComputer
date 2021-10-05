classdef TestFEMBar < TestRun
    
    properties (Access = public)
        Solver
        Stress
    end
    
    methods (Access = public)
        function selectSolver(obj,s)
            obj.Solver = s;
        end
    end
    
    methods (Access = protected)
        function performTest(obj,t)
            if obj.Solver == 'Direct'
                FEM = FEMBarComputerDirect(t);
            elseif obj.Solver == 'Iterat'
                FEM = FEMBarComputerIterative(t);
            end
            FEM.compute();
            obj.Stress = FEM.Stress;
        end
        
        function calculateError(obj,t)
            control = load(['Results/Stress',t,'_ok.mat']);
            obj.Error   = norm(obj.Stress-control.Stress);
        end
    end
    
end