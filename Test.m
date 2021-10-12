%% Test FEM

% Test de Stiffness i Connectivity: he utilitzat dues funcions atòmiques
% que apareixen en altres classes. S'haurien d'externalitzar?

clear all;
clc;

% profile('clear')
% profile('on')

%% DATA READ

tD = ['1';'2';'3'];
tI = ['4';'5'];

Check1 = TestFEMBar;
for i = 1:length(tD)
    Check1.selectSolver('Direct');
    Check1.test(tD(i));
end
for i = 1:length(tI)
    Check1.selectSolver('Iterat');
    Check1.test(tI(i));
end

Check2 = TestBarStiffnessMatrix;
t=[tD;tI];
for i=1:length(t)
    Check2.test(t(i));
end

Check3 = TestBarConnectivityMatrix;
for i=1:length(t)
    Check3.test(t(i));
end

% profile('viewer')
% profile('clear')
% profile('off')