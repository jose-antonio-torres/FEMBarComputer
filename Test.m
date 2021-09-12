%% Test FEM

clear all;
clc;

profile('clear')
profile('on')

%% DATA READ

tD = ['1';'2';'3'];
tI = ['4';'5'];
for i=1:length(tD)
    TestDirect(tD(i));
end
for i=1:length(tI)
    TestIterative(tI(i));
end

profile('viewer')
profile('clear')
profile('off')