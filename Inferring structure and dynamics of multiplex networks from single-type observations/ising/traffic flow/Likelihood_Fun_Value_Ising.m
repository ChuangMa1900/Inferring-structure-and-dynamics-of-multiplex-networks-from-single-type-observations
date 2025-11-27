function [LFV,LFV1]=Likelihood_Fun_Value_Ising(w_r,Z,S)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%根据预测的结构+每一层的Beta_L求似然函数值
%Copyright：马闯 chuang_m@126.com
%输入：预测的结构: w_r
%     预测的参数： Z=Beta_L=2J_L/(kT)
%     预测用的时间序列：S

%输出：似然函数值：LFV
%     重构每个节点的似然值：LFV1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% small_v=0.000000000000000001;
L=size(w_r,3); %层数
n=size(w_r,1); %节点数
LFV=zeros(1,n);
for nod=1:n
    [A,B]=Extract_AB(S,nod);
    w_nod=w_r(:,nod,:);
    w_nod=reshape(w_nod(:),[n,L]);
    w_nod(nod,:)=[];
    bb=sum(A*w_nod.*Z,2);
    LFV(nod)=sum((1+B)./2.*bb-log(1+exp(bb)));
end
LFV1=LFV;
LFV=sum(LFV1);

end

function [A,B]=Extract_AB(S,nod)
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %提取 A B
    %输入状态的时间序列矩阵 S
    %输入要重构的节点      i
    %输出  A B    i在t+1时刻的状态为B，其他节点在t时刻的状态为A
    %%%%%%%%%%%%%%%%%%%%%%%%%5
        [m,n]=size(S);
        B=S(:,nod);         %提取第i列B
        A=S;        
        A(:,nod)=[];        %除了第i列A      
        A(m,:)=[];          %这一时刻邻居状态
        B(1)=[];        %下一时i的状态
        dl=find(sum(A,2)==1-n|sum(A,2)>=n-1);%删除全为1和全为-1的
        A(dl,:)=[];
        B(dl)=[];
end



