classdef TestFEMBar < TestRun
    
    properties (Access = public)
        solver
        stress
    end
    
    methods (Access = public)
        function selectSolver(obj,s)
            obj.solver = s;
        end
    end
    
    methods (Access = protected)
        function performTest(obj,t)
            if obj.solver == 'Direct'
                FEM = FEMBarComputerDirect(t);
            elseif obj.solver == 'Iterat'
                FEM = FEMBarComputerIterative(t);
            end
            FEM.compute();
            obj.stress = FEM.stress;
        end
        
        function calculateError(obj,t)
            control     = load(['Results/Stress',t,'_ok.mat']);
            obj.error   = norm(obj.stress-control.Stress);
        end
    end
    
end