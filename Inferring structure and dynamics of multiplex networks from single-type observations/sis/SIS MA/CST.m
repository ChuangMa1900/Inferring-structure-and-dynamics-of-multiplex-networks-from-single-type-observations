function w_P=CST(data_x)
% data_x=0.35;
DatapreSIS;%µ÷ÓÃC++
pause(2);
format short;
Ymatrix=load('Ymatrix.txt');
Ymatrix = Ymatrix';
Amatrix=load('Amatrix.txt');
[i00,num_nodes]=size(Ymatrix);
w_P=zeros(num_nodes,num_nodes);
data_total=num_nodes;
for node=1:num_nodes
%     node
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  revised
    A=Amatrix((node-1)*data_total+1:(node)*data_total,:);
    A(:,node)=[];
    dif=Ymatrix(:,node);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% revised
    
    [temp,len]=size(A);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         norm=zeros(1,len);
%         for i=1:len
%             norm(i)=sqrt(sum(A(:,i).*A(:,i)));
%             A(:,i)=A(:,i)/norm(i);
%         end
%        NOR=norm;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    AMA=A;
    B=dif;
    K =round(data_x*len);
    % K equations to get all parameters
    selected_no=[];
    i=0;
    while i<K
        test_selected_no=ceil(len*rand);
        if isempty(find(selected_no==test_selected_no, 1))
            i=i+1;
            selected_no(i)=test_selected_no;
        end
    end
    A=AMA(selected_no,:);

    y=B(selected_no,1);
    x0=A'*y;
    xp = l1eq_pd_1(x0, A, [], y, 1e-128);
%     xp=l1eq_pd(x0, A, [], y);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         xp =xp./NOR';             % xp is what we need, you can plot it to check the results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xp(find(isnan(xp)==1)) = 0;
    xp(find(isinf(xp)==1)) = 0;
    
    
    id=1:num_nodes;
    id(node)=[];
    w_P(node,id)=xp';
    
end
delete('Amatrix.txt')
delete('Ymatrix.txt')









