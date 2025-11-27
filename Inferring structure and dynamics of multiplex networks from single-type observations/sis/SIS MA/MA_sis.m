function [P,x,id0]=MA_sis(S,nod)
%输入时间序列 S
%输入节点     nod
%输出重构结果 P=ln(1-lamba)A  (列向量，N个)
%输出参数     x=pow(1-lamba,k/(N-1))
%输出该结果是否合理，如果id0<0，则不合理
%版权：马闯   chuang_m@126.com 2017/5/25
    
    [~,n]=size(S);
    [A,B]=Extract_AB(S,nod);
    %%求解参数
    [x,~,id0]=fsolve(@(x) myfun(x,A,B),0.9999,optimset('Display','off')); 
 
    %构造方程组求解 CX=D
    theta=sum(A,2);
    f=x.^theta./(1-x.^theta)-theta*log(x).*x.^theta./((1-x.^theta).^2);
    g=x.^theta./((1-x.^theta).^2);
    C=zeros(n-1,n-1);
    D=zeros(n-1,1);
    for i=1:n-1
        C(i,:)=sum(bsxfun(@times,B.*A(:,i).*g,A));
        D(i)=sum((1-B-B.*f).*A(:,i));
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
    F=sum(B.*theta.*(x.^theta./(1-x.^theta)))-sum((1-B).*theta);   
end

function [A,B]=Extract_AB(S,nod)

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %提取 A B
    %输入状态的时间序列矩阵 S
    %输入要重构的节点      i
    %输出  A B    i在t时刻为零的情况

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
