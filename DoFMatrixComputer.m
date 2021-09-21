classdef DoFMatrixComputer < handle
    
    properties (Access = public)
        Td
    end
    
    methods (Access = public)
        function obj = DoFMatrixComputer()
            
        end
        
        function compute(obj,s)
            obj.defineDoFMatrix(s);
        end
        
    end
    
    methods (Access = private)
        
        function defineDoFMatrix(obj,s)
            Tdmat = zeros(s.nElem,4);
            for iel = 1:s.nElem
                for a = 1:2
                    for j = 1:2
                        i = 2*(a-1)+j;
                        Tdmat(iel,i) = 2*(s.Tnod(iel,a)-1)+j;
                    end
                end
            end
            obj.Td = Tdmat;
        end
    end
end

