classdef BarElemComputer < handle
    
    properties (Access = public) 
        x1
        x2
        y1
        y2
        l
    end
    
    methods (Access = public)
        function obj = BarElemComputer(x,Tnod,iel)
            obj.computeFirstNode(x,Tnod,iel);
            obj.computeSecondNode(x,Tnod,iel);
            obj.computeLength();
        end
    end
    
    methods (Access = private)
        function computeFirstNode(obj,x,Tnod,iel)
            obj.x1 = x(Tnod(iel,1),1);
            obj.y1 = x(Tnod(iel,1),2);
        end
        
        function computeSecondNode(obj,x,Tnod,iel)
            obj.x2 = x(Tnod(iel,2),1);
            obj.y2 = x(Tnod(iel,2),2);
        end
        
        function computeLength(obj)
            obj.l  = sqrt((obj.x2-obj.x1)^2+(obj.y2-obj.y1)^2);
        end
        
    end
end

