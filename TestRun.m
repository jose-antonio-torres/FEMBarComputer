classdef TestRun < handle
    
    properties (Access = protected)
        Solver
    end
    
    methods (Access = public)
        function selectTest(obj,t)
            obj.selectSolverType();
            obj.testSolver(obj.Solver,t);
        end
    end
    
    methods (Access = protected)
        function testSolver(obj,s,t)
            Stress = obj.computeProblemStress(s,t);
            error = obj.calculateError(Stress,t);
            if error < 1e-5
                cprintf('green', 'Test pass ');
            else
                cprintf('red', 'Test fail ');
            end
        end
   
        function [Stress] = computeProblemStress(obj,s,t)
            FEM=FEMBarComputer(s,t);
            FEM.compute();
            Stress = FEM.Stress;
        end
        
        function [error] = calculateError(obj,Stress,t)
            control = load(['Results/Stress',t,'_ok.mat']);
            error = norm(Stress-control.Stress);
        end
    end
    
    methods (Abstract, Access = protected)
        selectSolverType(obj);
    end
    
end

