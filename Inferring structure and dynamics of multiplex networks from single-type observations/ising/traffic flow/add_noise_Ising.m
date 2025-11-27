function S=add_noise_Ising(S,psi)
%加入噪音 psi为比列
% S=[1,-1,1,-1,1,-1;1,1,1,1,-1,-1]
% psi=0.1
[m,n]=size(S);
nois_n=ceil(m*n*psi);  %加入噪音的个数  
id_rand=randperm(m*n);  %打乱
S(id_rand(1:nois_n))=-S(id_rand(1:nois_n)); %转换
