classdef DoFMatrixComputer < handle
    
    properties (Access = public)
        Td
    end
    
    methods
        function obj = DoFMatrixComputer(nElem,Tnod)
            obj.defineDoFMatrix(nElem,Tnod)
        end
        
        function defineDoFMatrix(obj,nElem,Tnod)
            for iel=1:nElem
                for a=1:2
                    for j=1:2
                        i=2*(a-1)+j;
                        obj.Td(iel,i)=2*(Tnod(iel,a)-1)+j;
                    end
                end
            end
        end
    end
end

