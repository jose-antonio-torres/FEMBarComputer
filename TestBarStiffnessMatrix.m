classdef TestBarStiffnessMatrix < TestRun
    
    properties (Access = public)
        K
    end
    
    methods (Access = protected)
        function performTest(obj,t)
            FEM = FEMBarComputerDirect(t);
            FEM.compute();
            obj.K = FEM.KG;
        end
        
        function calculateError(obj,t)
            control = load(['Results/K',t,'.mat']);
            obj.Error   = norm(obj.K-control.K);
        end
    end
    
end