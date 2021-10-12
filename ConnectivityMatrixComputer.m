classdef ConnectivityMatrixComputer < handle
    
    properties (Access = private)
        nElem
        Tnod
    end
    
    properties (Access = public)
        Td
    end
    
    methods (Access = public)
        function obj = ConnectivityMatrixComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.defineConnectivityMatrix();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj,cParams)
            obj.nElem = cParams.nElem;
            obj.Tnod  = cParams.Tnod;
        end
        
        function defineConnectivityMatrix(obj)
            T   = zeros(obj.nElem,4);
            for iel = 1:obj.nElem
                for a = 1:2
                    for j = 1:2
                        i = 2*(a-1)+j;
                        T(iel,i) = 2*(obj.Tnod(iel,a)-1)+j;
                    end
                end
            end
            obj.Td = T;
        end
    end
end

