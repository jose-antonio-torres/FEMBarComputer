classdef FEMBarComputer < handle
    
    properties (Access = private)
        F
        x
        Tnod
        Td
        mat
        Tmat
        nElem = 12
        K_G 
        vR = [1 2 9 10]
        vL = [3 4 5 6 7 8 11 12 13 14 15 16]
        uL
        solver
    end
    
    properties (Access = public)
        Stress
    end
    
    methods (Access = public)
        
        function obj = FEMBarComputer(s,t)
            obj.init(t);
            obj.createSolver(s);
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
            data     = load(['Tests/BC',t,'.mat']);
            obj.F    = data.BC(1).f;
            obj.x    = data.BC(2).f;
            obj.Tnod = data.BC(3).f;
            obj.mat  = data.BC(4).f;
            obj.Tmat = data.BC(5).f;
        end
        
        function computeStiffnessMatrix(obj)
            Kcomputed = StiffnessMatrixComputer(obj.nElem,obj.mat(1),obj.mat(2),obj.Tnod,obj.x,obj.Td);
            obj.K_G   = Kcomputed.K;
        end
        
        function computeDoFMatrix(obj)
            Tdcomputed = DoFMatrixComputer(obj.nElem,obj.Tnod);
            obj.Td     = Tdcomputed.Td;
        end
        
        function createSolver(obj,solverType)
                cParams.type = solverType;
                obj.solver   = SolverFactory.create(cParams);
        end
        
        function solveSystem(obj,K_LL,F_extL)
            obj.solver.solveSystem(K_LL,F_extL);
            obj.uL = obj.solver.u;
        end
        
        function computeUnknownDisplacements(obj)
            K_LL   = obj.K_G(obj.vL,obj.vL);
            F_extL = [0; obj.F; 0; obj.F; 0; obj.F; 0; 0; 0; 0; 0; 0];
            obj.solveSystem(K_LL,F_extL);
        end
        
        function computeStress(obj)
            stressObject = StressComputer(obj.nElem,obj.uL,obj.vL,obj.x,obj.Tnod,obj.Td,obj.mat(1));
            obj.Stress   = stressObject.Stress;
        end

    end
end

