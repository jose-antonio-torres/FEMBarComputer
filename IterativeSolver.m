classdef IterativeSolver < Solver
    
    methods (Access = protected)
        
        function computeUnknowns(obj)
            u0    = zeros(length(obj.RHS),1);
            obj.u = u0;
            obj.executeGaussSeidel(u0);
        end
        
    end
    
    methods (Access = private)
        
        function executeGaussSeidel(obj,u0)
            error = 1;
            while (error>1e-16)
                for i = 1:length(u0)
                    aii = obj.LHS(i,i);
                    bi  = obj.RHS(i);
                    if i==1
                        sum0 = 0;
                        for j = i+1:length(u0)
                            aij  = obj.LHS(i,j);
                            sum0 = sum0+aij*u0(j);
                        end
                        obj.u(i) = (bi-sum0)/aii;
                    elseif i==length(u0)
                        sum = 0;
                        for j = 1:i-1
                            aij  = obj.LHS(i,j);
                            sum  = sum+aij*obj.u(j);
                        end
                        obj.u(i) = (bi-sum)/aii;
                    else
                        sum0 = 0;
                        sum  = 0;
                        for j = i+1:length(u0)
                            aij  = obj.LHS(i,j);
                            sum0 = sum0+aij*u0(j);
                        end
                        for j = 1:i-1
                            aij  = obj.LHS(i,j);
                            sum  = sum+aij*obj.u(j);
                        end
                        obj.u(i) = (bi-sum-sum0)/aii;
                    end
                    
                end
                error = max(abs(obj.u-u0))/max(u0);
                u0    = obj.u;
            end
        end
    end
end
