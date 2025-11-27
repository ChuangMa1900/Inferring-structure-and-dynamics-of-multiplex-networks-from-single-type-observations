function w_L=Net_2_Mult_Net(w,r)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%由单层网络生成边数一样的双层网络(网络是对称的)
%Copyright：马闯 chuang_m@126.com
%输入：给定网络 w
%     重叠比例 r                   
%输出：双层网络 w_L
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load karate_w
% r=0.6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(w);        %%节点数
w1=zeros(n,n);

N_E=find(tril(ones(n)-w,-1));       %%%%w矩阵对角线以下的为0的位置
E_E=find(tril(w));      %%w矩阵对角线以下的为1的位置
m=length(E_E);      %%w矩阵对角线以下的为1的个数
m1=floor(m*r);      %%重叠边的个数
m0=m-m1;        %%不重叠的边的个数
E0=N_E(randperm(length(N_E),m0));
E1=E_E(randperm(length(E_E),m1));
w1([E0;E1])=1;
w1=w1+w1';
w_L=zeros(n,n,2);
w_L(:,:,1)=w;
w_L(:,:,2)=w1;