classdef TestBarConnectivityMatrix < TestRun
    
    properties (Access = private)
        x
        Tnod
        mat
        nElem
    end
    
    properties (Access = public)
        Td
    end
    
    methods (Access = protected)
        function performTest(obj,t)
            obj.init(t);
            obj.computeDoFMatrix();
        end
        
        function calculateError(obj,t)
            control     = load(['Results/Td',t,'.mat']);
            obj.error   = norm(obj.Td-control.Td);
        end
    end
    
    methods (Access = private)
        function init(obj,t)
            data           = load(['Tests/BC',t,'.mat']);
            obj.Tnod       = data.BC(3).f;
            obj.nElem      = 12;
        end
        
        function computeDoFMatrix(obj)
            s.nElem    = obj.nElem;
            s.Tnod     = obj.Tnod;
            Tdcomputed = ConnectivityMatrixComputer(s);
            Tdcomputed.compute();
            obj.Td     = Tdcomputed.Td;
        end
    end
    
end