function SS=Ising_Multilayer_dynamics(w,Beta_L,T)
%多层Ising模型-1
%Copyright：Chuang Ma(马闯) chuang_m@126.com
%输入：多层网络邻接矩阵  w
%      参数   Beta_L=2J_L/(kT)（列向量，代表每一层的参数）
%      时间序列长度 T
%输出：状态时间序列：SS (每一行代表每一时刻的状态)

% load SW_20_3
% w=w_3;
% Beta_L=[0.1,0.2,0.4]';
% T=100;

N=size(w,1);%节点个数
L=size(w,3);%层数
S0=rand(1,N);%随机生成1×N的矩阵
S0(S0>=0.5)=1;
S0(S0<0.5)=-1; %初始状态+1或-1
SS=zeros(T+1,N); %存储时间序列
SS(1,:)=S0;

for i=2:T+1
    hh=0;
    for l=1:L
       hh=hh+sum(S0.*w(:,:,l),2)*Beta_L(l);
    end
    EE=S0.*hh';
    PP=1./(1+exp(EE)); %反转概率 
    id=find(rand(1,N)<PP);%需要状态反转的节点
    S0(id)=-S0(id);%状态反转
    SS(i,:)=S0;
end