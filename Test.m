%% Test FEM

% No puc imposar s=obj directament (props privades)

clear all;
clc;

% profile('clear')
% profile('on')

%% DATA READ

tD = ['1';'2';'3'];
tI = ['4';'5'];
sD.Solver = 'D';
sI.Solver = 'I';
for i = 1:length(tD)
    sD.t = tD(i);
    Check = SolverSelection;
    Check.test(sD);
end
for i = 1:length(tI)
    sI.t = tD(i);
    Check = SolverSelection;
    Check.test(sI);
end

% profile('viewer')
% profile('clear')
% profile('off')