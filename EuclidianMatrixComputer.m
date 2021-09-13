classdef EuclidianMatrixComputer < handle

    properties (Access = public)
        R
    end
    
    methods (Access = public)
        function obj = EuclidianMatrixComputer(x1,x2,y1,y2,l)
            obj.R=(1/l)*[x2-x1 y2-y1 0 0;...
                0 0 x2-x1 y2-y1];
        end
    end
end

