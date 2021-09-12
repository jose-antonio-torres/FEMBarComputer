function TestDirect(t)

s = 'D'; % Direct(D)
FEM=FEMBarComputer(s,t);
FEM.compute();

Stress = FEM.Stress;
control = load(['Results/Stress',t,'_ok.mat']);

error = norm(Stress-control.Stress);

if error < 1e-5
    cprintf('green', 'Test pass ');
else
    cprintf('red', 'Test fail ');
end

end

