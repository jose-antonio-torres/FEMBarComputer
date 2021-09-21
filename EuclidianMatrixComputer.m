classdef EuclidianMatrixComputer < handle

    properties (Access = public)
        R
    end
    
    methods (Access = public)
        function obj = EuclidianMatrixComputer()
            
        end
        
        function compute(obj,s)
            obj.computeEuclidianMatrix(s);
        end
    end
    
    methods (Access = private)
        function computeEuclidianMatrix(obj,s)
            obj.R = (1/s.l)*[s.x2-s.x1 s.y2-s.y1 0 0; 0 0 s.x2-s.x1 s.y2-s.y1];
        end
    end
end

