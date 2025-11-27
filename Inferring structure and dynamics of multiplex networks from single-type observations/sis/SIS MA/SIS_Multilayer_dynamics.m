function SS=SIS_Multilayer_dynamics(w,Lambda,Mu,a0,T)
%多层SIS模型-1
%Copyright：Chuang Ma(马闯) chuang_m@126.com
%输入：多层网络邻接矩阵  w
%      感染率   Lambda（列向量，代表每一层感染率）
%      恢复率   Mu
%      初始感染比例 a0
%      时间序列长度 T
%输出：感染时间序列：SS (S:0，I:1)
% load SW_20_3
% w=w_3;
% %SIS-多层
% Lambda=[0.05,0.2,0.4]';
% Mu=1;
% a0=0.3;
% T=30;
N=size(w,1);
L=size(w,3);
S0=zeros(1,N);
S0(randperm(N,ceil(N*a0)))=1;      %%%%开始感染的节点序列
SS=zeros(T+1,N); %存储时间序列
SS(1,:)=S0;
S1=S0;

for i=2:T+1
    I_node=find(S0==1); %感染节点
    S_node=find(S0==0);  %未感染节点
    I_N=length(I_node);
    S_N=length(S_node);
    if I_N>0    %如果有感染节点
        S_node_I_NN=zeros(L,S_N);
        for j=1:L
            S_node_I_NN(j,:)=sum(w(:,S_node,j).*S0',1);
        end
        %传播
        S0(S_node(rand(1,S_N)<(1-prod((1-Lambda).^ S_node_I_NN,1))))=1;
        %恢复
        S0(I_node(rand(1,I_N)<Mu))=0;   %每个被感染的节点以Mu概率恢复
        SS(i,:)=S0;
    else
        S0=zeros(1,N);
        S0(randperm(N,ceil(N*a0)))=1;      %%%%开始感染的节点序列
        SS(i,:)=S0;                     %重启
%         break;
    end
end