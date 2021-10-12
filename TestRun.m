classdef TestRun < handle
    
    properties (Access = protected)
        error
    end
    
    properties (Access = public)
        result
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
            if obj.error < 1e-5
                obj.result = 'Test pass ';
                cprintf('green', obj.result);
            else
                obj.result = 'Test fail ';
                cprintf('red', obj.result);
            end
        end
        
    end
    
    methods (Abstract, Access = protected)
        performTest(obj);
        calculateError(obj);
    end
    
end

