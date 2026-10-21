# AUD_KELM
Code for paper "Fast and memory-efficient kernel extreme learning machine method for active user detection in grant-free random access"

Abstract: Grant-free random access is a promising solution to enable connectivity for massive machine-type communications (mMTC) where a large number of devices activate sporadically and transmit short packets comprising of pilot sequences to the base station (BS). Since there is no coordination of the devices with the BS before transmission and multiple devices can transmit simultaneously, active user detection (AUD) being performed at BS identifies the transmitting users from the superimposed received signals. However, existing deep learning (DL)-based AUD methods are computationally expensive to train and require extensive hyperparameter tuning. Moreover, because of long training times, they cannot be quickly adapted for fast changing scenarios. In this article, we model the AUD problem as a multi-label classification task and propose a fast trainable approach for detecting active devices using kernel extreme learning machine (KELM). In addition, we address the challenge of high computation resource requirement for training the KELM by proposing a fast and memory efficient AUD algorithm by incorporating low-rank kernel matrix approximation. Specifically, proposed method ‘compresses’ kernel matrix to a lower rank by utilizing randomly pivoted Cholesky (RPC) factorization and the Sherman–Morrison–Woodbury relation is used for avoiding computing the inverse of full-rank matrix, thereby significantly reducing the training time and peak memory requirement. Numerical results demonstrate that proposed method outperform existing deep learning models for pilot sequence detection in terms of training time, while providing comparable detection performance for data-limited scenarios.

Paper can be accessed at https://www.sciencedirect.com/science/article/pii/S1389128626008546. 

Useage:
For experimenting with AUD-KELM method with regression method given in Section 5.3:
1. Generate dataset using matlab script `A_Dataset_Generator_for_KELM.m'
2. Run the script `B_AUD_KELM.m'

For experimenting with AUD-FME-KELM method 
1. Generate dataset using matlab script `C_Dataset_Generator_for_AUD_KELM_wt_RPC.m'
2. Run Python notebook `D_AUD_KELM_wt_RPC.ipynb'
(Subroutine for regression given in Section 5.3 not included in this version of the code)


The paper may be cited as \
@article{smaud2026, \
  title = {Fast and memory-efficient kernel extreme learning machine method for active user detection in grant-free random access}, \
  journal = {Computer Networks},\
  volume = {290},\
  pages = {112842},\
  year = {2026},\
  issn = {1389-1286},\
  doi = {https://doi.org/10.1016/j.comnet.2026.112842}\
}

Note: This file incorporates various public, open-source snippets from anonymous and unknown authors across developer forums. Author is thankful to all those sources. RPC libraries taken from https://github.com/eepperly/Randomly-Pivoted-Cholesky

