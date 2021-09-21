%% Test FEM

% Wednesday 22/09:
% all objects are 100% general - for instance check function of zip
% static functions when necessary
% DUDA: diferencia entre s y cParams + entran en constructor o compute¿?

clear all;
clc;

profile('clear')
profile('on')

%% DATA READ

tD = ['1';'2';'3'];
tI = ['4';'5'];
for i = 1:length(tD)
    Problem = DirectRun;
    Problem.selectTest(tD(i));
end
for i = 1:length(tI)
    Problem = IterativeRun;
    Problem.selectTest(tD(i));
end

profile('viewer')
profile('clear')
profile('off')