classdef TestRun < handle
    
    properties (Access = protected)
        Solver
    end
    
    methods (Access = public)
        function selectTest(obj,t)
            obj.selectSolverType();
            cParams = obj.init(t);
            obj.testSolver(cParams);
        end
    end
    
    methods (Access = private)
        function cParams = init(obj,t)
            cParams.s = obj.Solver;
            cParams.t = t;
        end
    end
    
    methods (Access = protected)
        function testSolver(obj,cParams)
            cParams.Stress = obj.computeProblemStress(cParams);
            error  = obj.calculateError(cParams);
            if error < 1e-5
                cprintf('green', 'Test pass ');
            else
                cprintf('red', 'Test fail ');
            end
        end
   
        function [Stress] = computeProblemStress(obj,cParams)
            FEM = FEMBarComputer(cParams);
            FEM.compute();
            Stress = FEM.Stress;
        end
        
        function [error] = calculateError(obj,cParams)
            control = load(['Results/Stress',cParams.t,'_ok.mat']);
            error   = norm(cParams.Stress-control.Stress);
        end
    end
    
    methods (Abstract, Access = protected)
        selectSolverType(obj);
    end
    
end

