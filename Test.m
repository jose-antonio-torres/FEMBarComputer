%% Test FEM

% No puc imposar s=obj directament (props privades)

clear all;
clc;

% profile('clear')
% profile('on')

%% DATA READ

tD = ['1';'2';'3'];
tI = ['4';'5'];

Check = TestFEMBar;
for i = 1:length(tD)
    Check.selectSolver('Direct');
    Check.test(tD(i));
end
for i = 1:length(tI)
    Check.selectSolver('Iterat');
    Check.test(tI(i));
end

% profile('viewer')
% profile('clear')
% profile('off')