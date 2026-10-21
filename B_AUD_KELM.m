% Note: This file incorporates various public, open-source snippets from 
% anonymous and unknown authors across developer forums. Author is thankful
% to all those sources.

clear;clc
load('AUD_Dataset.mat');
P1 = train_data';
T1 = train_target;
P2 = test_data';
T2 = test_target;

%% Parameters of KELM
Regularization_coefficient = 0.5;   % Find best value by trials
Kernel_type = 'RBF_kernel';
Kernel_para = 80;                   % Find best value by trials

C = Regularization_coefficient;
NumberofTrainingData = size(P1,2);
NumberofTestingData = size(P2,2);

% ---------------- Training --------------------
[userview_1, ~] = memory;
tic
n = size(T1,2);
Omega_train = kernel_matrix(P1',Kernel_type, Kernel_para);
OutputWeight = ((Omega_train + speye(n)/C)\(T1')); 
Y = (Omega_train * OutputWeight)'; % Calculate training output

% Regression based threshold 
sxi = zeros(1,NumberofTrainingData);
for i = 1:NumberofTrainingData
    fxi = Y(:,i);
    Ti = T1(:,i);
    min_Si = min(fxi(Ti>0));
    if isempty(min_Si)
        min_Si = 0;
    end
    max_SiBar = max(fxi(Ti<0));
    sxi(i) = (min_Si + max_SiBar)/2;
end
E = ones(NumberofTrainingData,1);
YY = [Y',E];
S = sxi';
BETA = YY\S;
toc
[userview_2, ~] = memory;
memory_difference = userview_2.MemUsedMATLAB - userview_1.MemUsedMATLAB;
disp(['Memory increase: ', num2str(memory_difference), ' bytes']);

% ---------------- Testing ----------------------
Omega_test = kernel_matrix(P1',Kernel_type, Kernel_para,P2');
TY = (Omega_test' * OutputWeight)';  %   TY: the actual output of the testing data

E = ones(NumberofTestingData,1);
TYY = [TY',E];
thresh = (TYY*BETA)';

Outputs = 2*(TY>thresh)-1;
Pre_Labels = sign(Outputs);
test_target = T2;

ret.HL=Hamming_loss(Pre_Labels,test_target);
disp(['The accuracy is: ', num2str(ret.HL)]);







