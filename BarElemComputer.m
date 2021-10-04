classdef BarElemComputer < handle
    
    properties (Access = private)
        x
        iel
        Tnod
    end
    
    properties (Access = public) 
        x1
        x2
        y1
        y2
        l
    end
    
    methods (Access = public)
        function obj = BarElemComputer(cParams)
            obj.init(cParams)
        end
        
        function compute(obj)
            obj.computeFirstNode();
            obj.computeSecondNode();
            obj.computeLength();
        end
    end
    
    methods (Access = private)
        
        function init(obj,cParams)
            obj.x    = cParams.x;
            obj.iel  = cParams.iel;
            obj.Tnod = cParams.Tnod;
        end
        function computeFirstNode(obj)
            obj.x1 = obj.x(obj.Tnod(obj.iel,1),1);
            obj.y1 = obj.x(obj.Tnod(obj.iel,1),2);
        end
        
        function computeSecondNode(obj)
            obj.x2 = obj.x(obj.Tnod(obj.iel,2),1);
            obj.y2 = obj.x(obj.Tnod(obj.iel,2),2);
        end
        
        function computeLength(obj)
            obj.l  = sqrt((obj.x2-obj.x1)^2+(obj.y2-obj.y1)^2);
        end
        
    end
end

