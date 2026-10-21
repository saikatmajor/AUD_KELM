% Note: This file incorporates various public, open-source snippets from 
% anonymous and unknown authors across developer forums. Author is thankful
% to all those sources.


clear all;
close all;
clc;

NumSamples = 4e4;   % Number of train and test samples (change as needed)
K = 40;             % Number of devices
L = 21;             % Preamble length
pa = 0.05;          % Activation probability

%% Channel noise variance
snr_db = 0;    % dB
sigma2z = 10^(-1*snr_db/10);

%% ZC preamble sequence set generation
Nr = ceil(K/L); % Number of roots required
A = zeros(L,K);
set_of_roots = 1:L-1;
looplimit = L-1;
lop = 1;
root_counter = 1;
root = set_of_roots(root_counter);
for k = 1:K
     seq = circshift(zadoffChuSeq(root,L),lop-1);
     A(:,k) = seq.';
     lop = lop + 1;
     if lop > looplimit
         lop = 1;
         root_counter = root_counter + 1;
         root = set_of_roots(root_counter);
     end
end


%% Simulate the scenario to get training data
Dataset_features = zeros(NumSamples,2*L);
Dataset_target = zeros(NumSamples,K);
NumActiveUsers = round(pa*K);
for s = 1:NumSamples
    h = (randn(K,1) + 1i*randn(K,1))/sqrt(2);
    alpha = rand(K,1)<pa;   % Activity state of devices
    x = alpha.*h;
    z = sqrt(sigma2z)*(randn(L,1) + 1i*randn(L,1))/sqrt(2); % Noise
    y = A*x + z;
    Dataset_features(s,:) = [real(y);imag(y)];
    Dataset_target(s,:) = alpha;
end

%% Save the dataset for training and testing ( Train ratio = 0.75)
train_data = Dataset_features(1:3*NumSamples/4,:);
train_target = (2*Dataset_target(1:3*NumSamples/4,:)-1)';
test_data = Dataset_features(3*NumSamples/4+1:NumSamples,:);
test_target = (2*Dataset_target(3*NumSamples/4+1:NumSamples,:)-1)';

save('AUD_Dataset.mat','train_data','train_target','test_data','test_target');



