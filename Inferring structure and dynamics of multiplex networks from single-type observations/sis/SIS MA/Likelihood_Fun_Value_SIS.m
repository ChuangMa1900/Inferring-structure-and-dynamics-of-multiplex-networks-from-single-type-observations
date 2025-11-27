function [LFV,LFV1]=Likelihood_Fun_Value_SIS(w_r,Z,S)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%根据预测的结构+每一层的ln(1-lambda)求似然函数值
%Copyright：马闯 chuang_m@126.com
%输入：预测的结构: w_r
%     预测的参数： Z=1-Lambda
%     预测用的时间序列：S

%输出：似然函数值：LFV
%     重构每个节点的似然值：LFV1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
small_v=0.000000000000000001;
L=size(w_r,3); %层数
n=size(w_r,1); %节点数
aa=exp(Z);
LFV=zeros(1,n);
for nod=1:n
    [A,B]=Extract_AB(S,nod);
    w_nod=w_r(:,nod,:);
    w_nod=reshape(w_nod(:),[n,L]);
    w_nod(nod,:)=[];
    bb=prod(aa.^(A*w_nod),2);
    LFV(nod)=sum(B.*log(1-bb+small_v)+(1-B).*log(bb+small_v));
end
LFV1=LFV;
LFV=sum(LFV);

end

function [A,B]=Extract_AB(S,nod)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%提取 A B
%输入状态的时间序列矩阵 S
%输入要重构的节点      i
%输出  A B    i在t+1时刻的状态为B，其他节点在t时刻的状态为A
%%%%%%%%%%%%%%%%%%%%%%%%%5
[m,n]=size(S);
B1=S(:,nod);         %提取第i列B1
A1=S;
A1(:,nod)=[];        %除了第i列A1
t=find(B1==0);     %寻找B1,t时刻为0
t(find(t==m))=[];  %保证t+1时刻还有数据
A=A1(t,:);          %这一时刻邻居状态
B=B1(t+1,:);        %下一时i的状态
dl=find(sum(A,2)==0|sum(A,2)>=n-1);%删除全为1和全为0的
A(dl,:)=[];
B(dl)=[];
end



