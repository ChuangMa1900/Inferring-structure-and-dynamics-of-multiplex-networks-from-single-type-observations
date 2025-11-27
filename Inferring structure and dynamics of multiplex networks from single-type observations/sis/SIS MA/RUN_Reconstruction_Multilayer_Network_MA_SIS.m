function [SUC_F1_best,SUC_F1_min,SUC_F1_all]=RUN_Reconstruction_Multilayer_Network_MA_SIS(w_r,E_r,w)
%SIS多层网络重构，跑实验，计算精度
%输入：   w_r：重构结果，元胞数组。w_r{k,1}:第k组结果重构参数; w_r{k,2}:第k组结果重构网络
%输入：   E_r：重构误差；w_r{k,:}：第k组结果的【分层误差，参数一致性误差，似然误差，对称性误差】
%输入真实网络：w
% 输出： SUC_F1_best： 输出分层最好精度（精度上限） +对应参数
%        SUC_F1_min： 输出分层最优精度（算法求的） +对应参数
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


%%最小误差选择，这里基于对称性（辅助）+似然函数（主要）+分层误差（辅助）
E_0=E_r(:,1);     %分层误差
E_L=E_r(:,end-1); %似然误差
E_S=E_r(:,end);   %对称性误差

E_0_0=2*max(E_0);
E_L_0=2*max(E_L);
E_S_0=2*max(E_S);
id2=0;
%对称性误差足够小，且似然函数大致一样时候，选择对称性误差足够小的，否则选择似然函数最优的
for i=1:n1
    E_L_i=E_L(i);
    E_S_i=E_S(i);
    E_0_i=E_0(i);
     if (abs(E_L_i-E_L_0)/(E_L_0+E_L_i)<0.001) && (abs(E_S_i-E_S_0)/(min(E_S_0,E_S_i)+5)>0.2) %似然函数大致一样，对称性误差相差足够大,对称性误差起作用
     %if (abs(E_L_i-E_L_0)/(E_L_0+E_L_i)<0.001)&&(abs(E_0_i-E_0_0)/(E_0_0+E_0_i)<0.1) && (abs(E_S_i-E_S_0)/(min(E_S_0,E_S_i)+5)>0.2) %似然函数大致一样，对称性误差相差足够大,对称性误差起作用
         if E_S_i<E_S_0    
             E_S_0=E_S_i;
             E_L_0=E_L_i;
             E_0_0=E_0_i;
             id2=i;
         end
     else        %似然起作用
         if E_L_i<E_L_0
             E_S_0=E_S_i;
             E_L_0=E_L_i;
             E_0_0=E_0_i;
             id2=i;
         end
     end
end
SUC_F1_min=[SUC_F1_all(id2,:),1-exp(w_r{id2,1})];

