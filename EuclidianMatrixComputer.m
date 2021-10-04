classdef EuclidianMatrixComputer < handle

    properties (Access = private)
        x1
        x2
        y1
        y2
        l
    end
    
    properties (Access = public)
        R
    end
    
    methods (Access = public)
        function obj = EuclidianMatrixComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.computeEuclidianMatrix();
        end
    end
    
    methods (Access = private)
        
        function init(obj,cParams)
            obj.x1 = cParams.x1;
            obj.x2 = cParams.x2;
            obj.y1 = cParams.y1;
            obj.y2 = cParams.y2;
            obj.l  = cParams.l;
        end
        
        function computeEuclidianMatrix(obj)
            obj.R      = zeros(2,4);
            obj.R(1,1) = (obj.x2-obj.x1)/obj.l;
            obj.R(1,2) = (obj.y2-obj.y1)/obj.l;
            obj.R(2,3) = obj.R(1,1);
            obj.R(2,4) = obj.R(1,2);
        end
    end
end

