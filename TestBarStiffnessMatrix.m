classdef TestBarStiffnessMatrix < TestRun
    
    properties (Access = private)
        x
        Tnod
        mat
        nElem
        Td
    end
    
    properties (Access = public)
        K
    end
    
    methods (Access = protected)
        function performTest(obj,t)
            obj.init(t);
            obj.computeDoFMatrix();
            obj.computeStiffnessMatrix();
        end
        
        function calculateError(obj,t)
            control     = load(['Results/K',t,'.mat']);
            obj.error   = norm(obj.K-control.K);
        end
    end
    
    methods (Access = private)
        function init(obj,t)
            data           = load(['Tests/BC',t,'.mat']);
            obj.x          = data.BC(2).f;
            obj.Tnod       = data.BC(3).f;
            obj.mat        = data.BC(4).f;
            obj.nElem      = 12;
        end
        
        function computeDoFMatrix(obj)
            s.nElem    = obj.nElem;
            s.Tnod     = obj.Tnod;
            Tdcomputed = ConnectivityMatrixComputer(s);
            Tdcomputed.compute();
            obj.Td     = Tdcomputed.Td;
        end
        
        function computeStiffnessMatrix(obj)
            s.nElem   = obj.nElem;
            s.mat1    = obj.mat(1);
            s.mat2    = obj.mat(2);
            s.Tnod    = obj.Tnod;
            s.x       = obj.x;
            s.Td      = obj.Td;
            Kcomputed = StiffnessMatrixComputer(s);
            Kcomputed.compute();
            obj.K     = Kcomputed.K;
        end
    end
    
end