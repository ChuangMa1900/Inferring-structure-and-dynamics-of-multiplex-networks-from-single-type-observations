function [w_r,E_r]=Adaptive_Layering_SIS_0(X,N,L,c1,c2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%重构后的自适应分层算法，多组结果供选择(无似然误差)
%Copyright：马闯 chuang_m@126.com
% X=A_1*Beta_1+A_2*Beta_2+...+A_L*Beta_L
% X=A_1*ln(1-l_1)+A_2*ln(1-l_2)+...+A_L*ln(1-l_L)
% 如何求解A_1,A_2,...A_L和Z_1=ln(1-l_1),Z_2=ln(1-l_2),...,Z_L=ln(1-l_L)
% 输入 X：重构值
%     N:节点个数
%      L：层数
%     c1: 数据分布划分多少间隔（可取50）
%     c2:取候选集的参数
%      S：时间序列（算似然函数用）
%Gamma_0:求解的参数中间值
% 输出： w_r：重构结果，元胞数组。w_r{k,1}:第k组结果重构参数; w_r{k,2}:第k组结果重构网络
%       E_r：重构误差；w_r{k,:}：第k组结果的【分层误差，对称性误差】
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L=2;           %层数
% c1=100
% c2=3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %分层算法
%柱状图
%对X中的负值找分布的局部最大值
X1=X;
X1(X1>=-0.0001)=[];
[a,b]=hist(X1,c1); %#ok<HIST> %%a,b分别为每个间隔元素个数和中心（c1=min(100,N);）

%找局部最大值
TF=islocalmax(a,'MinProminence',c2);        %%%%局部最大值（元素个数）的间隔(c2=2;)
Z0=b(TF);       %%局部最大值（元素个数）的间隔的中心
Z0(Z0>-0.0001)=[]; %Z的候选集（%%过滤掉00所对应的候选集）
Z0=[-0.0001,Z0];%加一个最小，得到更好地解

Z0=nchoosek(Z0, L);% Z的的后选集(%%从Z0集合中一次选L个所有的可能的组合)
n1=size(Z0,1);      %%组合个数

if n1==0  %如果找不到局部最大
    try
        [~,Z0]=kmeans(X1,L);
    catch
        [~,Z0]=kmeans(X,L);
    end
    n1=1;
end




Z_all=zeros(n1,L);
w_r=cell(n1,2);   %存储结果参数和网络 
E_r=zeros(n1,2);  %存储2个误差指标
kk=0;
for i=1:n1 
    ZZ=Z0(i,:);   
    [A1,Z1,E0]=Fun_Layering(-X,L,-ZZ); %分层,SIS取对数变负了
    Z1=-Z1;                            %是负值

    if min(sum(abs(Z1-Z_all),2))<0.01*abs(mean(Z1)) %与分层结果前面一致不处理，节省时间
        continue;
    end
    kk=kk+1;
    Z_all(kk,:)=Z1;

    w_r1=zeros(N,N,L); %写成网络
    E_S=0;             %对称性误差
    for j=1:L
        w_r1(:,:,j)=reshape(A1(:,j),[N,N]);
        E_S=E_S+sum(abs(w_r1(:,:,j)-w_r1(:,:,j)'),"all"); %对称性误差
    end
    w_r{kk,1}=Z1;       %重构的参数
    w_r{kk,2}=w_r1;     %重构的网络   

    E_r(kk,:)=[E0,E_S];
end
w_r=w_r(1:kk,:);
E_r=E_r(1:kk,:);





