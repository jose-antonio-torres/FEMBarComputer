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
        vR=[1 2 9 10]
        vL=[3 4 5 6 7 8 11 12 13 14 15 16]
        uL
        solver
    end
    
    properties (Access = public)
        Stress
    end
    
    methods (Access = public)
        
        function obj = FEMBarComputer(s,t)
            obj.init(s);
            obj.loadData(t);
        end
        
        function compute(obj)
            obj.computeStiffnessMatrix();
            obj.computeUnknownDisplacements();
            obj.computeStress();
        end
    end
    
    methods (Access = private)
        
        function init(obj,s)
            obj.createSolver(s);
        end
        
        function loadData(obj,t)
            data = load(['Tests/BC',t,'.mat']);
            obj.F    = data.BC(1).f;
            obj.x    = data.BC(2).f;
            obj.Tnod = data.BC(3).f;
            obj.mat  = data.BC(4).f;
            obj.Tmat = data.BC(5).f;
        end
        
        function computeStiffnessMatrix(obj)
            Kcomputed = StMatrixComputed(obj.nElem,obj.mat(1),obj.mat(2),obj.Tnod,obj.x);
            obj.K_G = Kcomputed.K;
            obj.Td = Kcomputed.Td;
        end
        
        function createSolver(obj,solverType)
                cParams.type = solverType;
                obj.solver = SolverFactory.create(cParams);
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
            u_T=zeros(16,1);
            R=zeros(2,4,obj.nElem);
            u_T(obj.vL)=obj.uL;
            for iel=1:obj.nElem
                BarElem = BarElemComputed(obj.x,obj.Tnod,iel);
                R=(1/BarElem.l)*[BarElem.x2-BarElem.x1 BarElem.y2-BarElem.y1 0 0;...
                    0 0 BarElem.x2-BarElem.x1 BarElem.y2-BarElem.y1];
                for i=1:4
                    I=obj.Td(iel,i);
                    u_e(i,1)=u_T(I,1);
                end
                uprima_e=R*u_e;
                Strain(iel,1)=(1/BarElem.l)*[-1 1]*uprima_e;
                obj.Stress(iel,1)=obj.mat(1)*Strain(iel,1);
            end
        end

    end
end

