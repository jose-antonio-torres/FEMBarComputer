classdef TestRun < handle
    
    properties (Access = public)
        Result
    end
    
    methods (Access = public)
        function test(obj,s)
            cParams = obj.init(s);
            obj.checkError(cParams);
        end
    end
    
    methods (Access = private)
        function cParams = init(obj,s)
            obj.prepareTest(s);
            cParams.s = obj.Solver;
            cParams.t = s.t;
        end
    end
    
    methods (Access = protected)
        function checkError(obj,cParams)
            cParams.Value = obj.computeFEMProblem(cParams);
            error  = obj.calculateError(cParams);
            if error < 1e-5
                obj.Result = 'Test pass ';
                cprintf('green', obj.Result);
            else
                obj.Result = 'Test fail ';
                cprintf('red', obj.Result);
            end
        end
        
    end
    
    methods (Access = protected, Static)
   
        function [Value] = computeFEMProblem(cParams)
            FEM = FEMBarComputer(cParams);
            FEM.compute();
            Value = FEM.Stress;
        end
        
        function [error] = calculateError(cParams)
            control = load(['Results/Stress',cParams.t,'_ok.mat']);
            error   = norm(cParams.Value-control.Stress);
        end
    end
    
    methods (Abstract, Access = protected)
        prepareTest(obj);
    end
    
end

