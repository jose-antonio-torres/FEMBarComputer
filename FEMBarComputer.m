classdef FEMBarComputer < handle
    
    properties (Access = private)
        F
        x
        Tnod
        Td
        mat
        Tmat
        nElem
        K_G 
        vR
        vL
        vF
        uL
        solver
    end
    
    properties (Access = public)
        Stress
    end
    
    methods (Access = public)
        
        function obj = FEMBarComputer(cParams)
            obj.init(cParams.t);
            obj.createSolver(cParams.s);
        end
        
        function compute(obj)
            obj.computeDoFMatrix();
            obj.computeStiffnessMatrix();
            obj.computeUnknownDisplacements();
            obj.computeStress();
        end
    end
    
    methods (Access = private)
        
        function init(obj,t)
            data      = load(['Tests/BC',t,'.mat']);
            obj.F     = data.BC(1).f;
            obj.x     = data.BC(2).f;
            obj.Tnod  = data.BC(3).f;
            obj.mat   = data.BC(4).f;
            obj.Tmat  = data.BC(5).f;
            obj.nElem = 12;
            obj.vR    = [1 2 9 10];
            obj.vL    = [3 4 5 6 7 8 11 12 13 14 15 16];
            obj.vF    = [2 4 6];
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
            obj.K_G   = Kcomputed.K;
        end
        
        function computeDoFMatrix(obj)
            s.nElem    = obj.nElem;
            s.Tnod     = obj.Tnod;
            Tdcomputed = ConnectivityMatrixComputer(s);
            Tdcomputed.compute();
            obj.Td     = Tdcomputed.Td;
        end
        
        function createSolver(obj,solverType)
                s.type       = solverType;
                obj.solver   = SolverFactory.create(s);
        end
        
        function solveSystem(obj,s)
            obj.solver.solveSystem(s);
            obj.uL = obj.solver.u;
        end
        
        function computeUnknownDisplacements(obj)
            s.K_LL   = obj.computeReducedStiffnessMatrix();
            s.F_extL = obj.computeReducedExternalForcesVector();
            obj.solveSystem(s);
        end
        
        function K_LL = computeReducedStiffnessMatrix(obj)
            K_LL = obj.K_G(obj.vL,obj.vL);
        end
        
        function F_extL = computeReducedExternalForcesVector(obj)
            F_extL = zeros(obj.nElem,1);
            F_extL(obj.vF) = obj.F;
        end
        
        function computeStress(obj)
            s.nElem      = obj.nElem;
            s.uL         = obj.uL;
            s.vL         = obj.vL;
            s.x          = obj.x;
            s.Tnod       = obj.Tnod;
            s.Td         = obj.Td;
            s.mat1       = obj.mat(1);
            stressObject = StressComputer(s);
            stressObject.compute();
            obj.Stress   = stressObject.Stress;
        end

    end
end

