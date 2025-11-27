function S=add_noise_SIS(S,psi)
%加入噪音 psi为比列
% S=[1,0,1,0,1,0;1,1,1,1,0,0]
% psi=0.1
[m,n]=size(S);
nois_n=ceil(m*n*psi);  %加入噪音的个数  
id_rand=randperm(m*n);  %打乱
S(id_rand(1:nois_n))=abs(S(id_rand(1:nois_n))-1); %转换
