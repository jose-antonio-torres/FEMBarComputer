classdef BarElemComputer < handle
    
    properties (Access = public) 
        x1
        x2
        y1
        y2
        l
    end
    
    methods (Access = public)
        function obj = BarElemComputer()

        end
        
        function compute(obj,s)
            obj.computeFirstNode(s);
            obj.computeSecondNode(s);
            obj.computeLength();
        end
    end
    
    methods (Access = private)
        function computeFirstNode(obj,s)
            obj.x1 = s.x(s.Tnod(s.iel,1),1);
            obj.y1 = s.x(s.Tnod(s.iel,1),2);
        end
        
        function computeSecondNode(obj,s)
            obj.x2 = s.x(s.Tnod(s.iel,2),1);
            obj.y2 = s.x(s.Tnod(s.iel,2),2);
        end
        
        function computeLength(obj)
            obj.l  = sqrt((obj.x2-obj.x1)^2+(obj.y2-obj.y1)^2);
        end
        
    end
end

