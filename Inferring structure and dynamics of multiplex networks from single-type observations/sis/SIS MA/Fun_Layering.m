function [A,Z,E]=Fun_Layering(X,L,Z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%重构后的分层算法
%Copyright：马闯 chuang_m@126.com
% X=A_1*Beta_1+A_2*Beta_2+...+A_L*Beta_L
% 如何求解A_1,A_2,...A_L和Z_1=Beta_1,Z_2=Beta_2,...,Z_L=Beta_N
% 输入 X：重构值
%      L：层数
%      Z: 初始化Z=[Z_1,Z_2,...,Z_L]
%输出： A：L列，第L列是第L层的连边情况，
%      Z：每一层的均值
%      E：误差
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L=2;           %层数
% Z=[0.1,0.25]; %初始化每一层的Beta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %分层算法
%生成每一条边可能解
yy1=dec2bin(0:2^L-1);   %%转二进制
yy=zeros(2^L,L);
for i=1:2^L
    for j=1:L
        yy(i,j)=str2num(yy1(i,j)); %#ok<ST2NM>（%%将yy1字符串变为数字可能的组合）
    end 
end

for t=1:1000
    Z0=Z;
    [E,id]=min((X-sum(yy.*Z,2)').^2,[],2);%E是每一对边的误差
    A=yy(id,:);%每一列对应每一层网络
    Z=inv(A'*A+0.0001*eye(L))*A'*X;
    Z=Z';
    if norm(Z-Z0)<0.000001
        break;
    end
    Z(Z<0.0001)=0.0001;%保证都大于0
end
[Z,id]=sort(Z); %从小到大排列
A=A(:,id);
E=sum(E);%误差

if sum(Z)>1000  %参数过大，重构不出来，设置为0
    Z=zeros(1,L);
end


