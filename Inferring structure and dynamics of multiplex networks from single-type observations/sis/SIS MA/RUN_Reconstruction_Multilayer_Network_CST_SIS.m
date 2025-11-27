function [SUC_F1_best,SUC_F1_all]=RUN_Reconstruction_Multilayer_Network_CST_SIS(w_r,w)
%SIS多层网络重构，跑实验，计算精度
%输入：   w_r：重构结果，元胞数组。w_r{k,1}:第k组结果重构参数; w_r{k,2}:第k组结果重构网络
%输入真实网络：w
% 输出： SUC_F1_best： 输出分层最好精度（精度上限） +对应参数
%        SUC_F1_all: 输出分层所有精度
%版权：马闯   chuang_m@126.com 2024/10/1

L=size(w,3);
n1=size(w_r,1);

%所有的精度
SUC_F1_all=zeros(n1,(L+1)*2);
for i=1:n1
    SUC_F1_all(i,:)=clc_F1_SUC(w,w_r{i,2});
end

% %最优精度+最优结果
[~,id1]=max(SUC_F1_all(:,end));
SUC_F1_best=[SUC_F1_all(id1,:),1-exp(w_r{id1,1})];


