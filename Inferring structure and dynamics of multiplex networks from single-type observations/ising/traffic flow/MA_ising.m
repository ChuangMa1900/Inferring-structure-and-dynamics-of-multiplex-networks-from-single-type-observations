function [P,x,id0]=MA_ising(S,nod)
%输入时间序列 S
%输入节点     nod
%输出重构结果 P=Beta_LA  (列向量，N个)
%输出参数     x
%输出该结果是否合理，如果id0<0，则不合理
%版权：马闯   chuang_m@126.com 2017/5/25
    
    [~,n]=size(S);
    [A,B]=Extract_AB(S,nod);


    %求解参数,多求几次更鲁棒
    x0=0.999;
    for i=1:10
        try
            [x,~,id0]=fsolve(@(x) myfun(x,A,B),x0,optimset('Display','none'));
        catch
            [x,~,id0]=fsolve(@(x) myfun(x,A,B),0.1,optimset('Display','none'));
        end
        x0=x0*rand(1)*2;
        if id0>0
            break;
        end
    end


    %构造方程组求解 CX=D
    theta=sum(A,2);
    f=exp(x.*theta)./(1+exp(x.*theta));
    g=exp(x.*theta)./((1+exp(x.*theta)).^2);
    C=zeros(n-1,n-1);
    D=zeros(n-1,1);
    for i=1:n-1
        C(i,:)=sum(bsxfun(@times,A(:,i).*g,A));
        D(i)=sum(((1+B)./2-f+g.*x.*theta).*A(:,i));
    end
%     P1=C\D;
    P1=(C+0.0001*eye(n-1))\D;
    
    %变成nod的值为0
    P=zeros(n,1);
    id=1:n;
    id(nod)=[];
    P(id)=P1;
end


function F=myfun(x,A,B)
    theta=sum(A,2);
    F=sum(theta.*exp(x.*theta)./(1+exp(x.*theta)))-(sum((1+B).*theta))/2;   
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
        dl=find(sum(A,2)==1-n|sum(A,2)>=n-1);%删除全为1和全为0的
        A(dl,:)=[];
        B(dl)=[];
end
