function p_score=fun_rec_network_lasso_y(S,nod,delta,sigma,lambda)
    %          delta=0.45;
    %          sigma=0.8;
    %          lambda=10^(-1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %输入S：信息矩阵
        %输入控制参数：delta(截断韩明距离),sigma（选取基的个数）,lambda（lasso中参数）
        %输入节点 nod
        %输出所有节点和nod的关系
    %         A=[1,1,0;1,0,1;1,1,0;1,1,1;0,0,1]
    %         B=[1,1,0,1,1]'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [A,B]=Extract_AB(S,nod);
        [n_A,n1]=size(A);
    %     base_num=ceil(n1*sigma);
        base_num=n1;


        A_means=zeros(base_num,n1);
        B_means=zeros(base_num,1);
        base=randperm(n_A,base_num);

        for i=1:base_num
           base_set=find(sum(abs(bsxfun(@minus, A, A(base(i),:))),2)/n1<delta);
           A_means(i,:)=mean(A(base_set,:));
           B_means(i)=mean(B(base_set));
        end
       Y=B_means;     
       phi=[ones(base_num,1),A_means];     %构造论文中等式
      
       %实验次数
       p_score=0;
       nn=10;
       for ll=1:nn
           xj=randperm(n1,ceil(n1*sigma));
           node_p=lasso(phi(xj,:),Y(xj),'Lambda',lambda,'RelTol',10^-4);
           p_score=p_score+node_p(2:end)/nn;
       end
       iidd=1:n1+1;
       iidd(nod)=[];
       p_score=[iidd;p_score'];
       
end

function [A,B]=Extract_AB(S,i)

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %提取 A B
    %输入状态的时间序列矩阵 S
    %输入要重构的节点      i
    %输出  A B

    %%%%%%%%%%%%%%%%%%%%%%%%%5
    %提取AB
    % S=[1,0,1,0,1;1,1,0,1,1;1,0,1,0,1;1,0,1,1,0]
    % i=3
    [m,n]=size(S);
    B1=S(:,i);
    A1=S;
    A1(:,i)=[];
    t=find(B1==0);%寻找B1,t时刻为0
    t(find(t==m))=[]; %保证下一时刻还有数据
    A=A1(t,:);         %这一时刻邻居状态
    B=B1(t+1,:);      %下一时刻有没有从0变为1
    dl=find(sum(A,2)==0|sum(A,2)>=n-1);%删除全为1和全为0的
    A(dl,:)=[];
    B(dl)=[];
end



