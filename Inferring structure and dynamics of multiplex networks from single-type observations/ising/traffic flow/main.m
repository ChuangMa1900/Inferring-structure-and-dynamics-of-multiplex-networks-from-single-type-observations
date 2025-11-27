% function main
%导入数据
load x
xx=x;
%是否拥堵
xx=xx./max(xx,[],2);
%r=quantile(xx,0.8,2);
r=0.5
xx(xx>r)=-1;
xx(xx~=-1)=1;
S=xx';



%导入网络
load w
ww=w^2+w^3;
ww(ww>0)=1;
ww=ww-diag(diag(ww));
w0(:,:,2)=w;
w0(:,:,1)=ww;



[w_r,E_r]=Reconstruction_Multilayer_Network_MA_Ising(S,2)
[~,mm]=min(E_r(:,3));
%mm=1;
w1=w_r{mm,2};
w1(:,:,1)=w1(:,:,1)+w1(:,:,1)';
w1(:,:,2)=w1(:,:,2)+w1(:,:,2)';
w1(w1>0)=1;
F1_SUC=clc_F1_SUC(w1,w0)
canshu=w_r{mm,1}

F1_SUC_1=0;
canshu_1=0;
% 1. 将矩阵拉平成列向量
for k=1:100
    A_flat = S(:);
    A_shuffled_flat = A_flat(randperm(length(A_flat)));
    S = reshape(A_shuffled_flat, size(S));

    [w_r,E_r]=Reconstruction_Multilayer_Network_MA_Ising(S,2);
    [~,mm]=min(E_r(:,3));
    w1=w_r{mm,2};
    w1(:,:,1)=w1(:,:,1)+w1(:,:,1)';
    w1(:,:,2)=w1(:,:,2)+w1(:,:,2)';
    w1(w1>0)=1;
    F1_SUC_1=F1_SUC_1+clc_F1_SUC(w1,w0)/100;
    canshu_1=canshu_1+w_r{1,1}/100;
end
F1_SUC_1
canshu_1




