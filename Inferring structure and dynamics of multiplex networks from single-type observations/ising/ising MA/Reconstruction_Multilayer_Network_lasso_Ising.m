function [w_r,E_r]=Reconstruction_Multilayer_Network_lasso_Ising(S,L)
%输入时间序列 S（SIS动力学生成）
%输入层数       L
% 输出： w_r：重构结果，元胞数组。w_r{k,1}:第k组结果重构参数; w_r{k,2}:第k组结果重构网络
%       E_r：重构误差；w_r{k,:}：第k组结果的【分层误差，对称性误差】
%版权：马闯   chuang_m@126.com 2024/10/1
N=size(S,2);  %%节点个数
w_P=res_lasso_Ising(S);
X=w_P;
%处理极端解
X(X<-100)=0;
X(X>100)=0;
%%%%%%%%%%%%%%%%%%
aa=1.5*mean(max(X,[],1));
X(X>aa)=aa;

c1=min(100,N);
c2=1;
[w_r,E_r]=Adaptive_Layering(X(:),N,L,c1,c2);