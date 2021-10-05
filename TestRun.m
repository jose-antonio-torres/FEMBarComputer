classdef TestRun < handle
    
    properties (Access = protected)
        Error
    end
    
    properties (Access = public)
        Result
    end
    
    methods (Access = public)
        function test(obj,t)
            obj.checkError(t);
        end
    end
    
    methods (Access = protected)
        function checkError(obj,t)
            obj.performTest(t);
            obj.calculateError(t);
            if obj.Error < 1e-5
                obj.Result = 'Test pass ';
                cprintf('green', obj.Result);
            else
                obj.Result = 'Test fail ';
                cprintf('red', obj.Result);
            end
        end
        
    end
    
    methods (Abstract, Access = protected)
        performTest(obj);
        calculateError(obj);
    end
    
end

