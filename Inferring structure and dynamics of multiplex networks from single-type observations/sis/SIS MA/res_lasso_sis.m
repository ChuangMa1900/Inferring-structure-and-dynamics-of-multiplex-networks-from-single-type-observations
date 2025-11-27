function w_P=res_lasso_sis(S)

n=size(S,2);
delta=0.45;
sigma=0.8;
lambda=10^(-4);
w_P=zeros(n,n);       %保存计算结果

for i=1:n
    p=fun_rec_network_lasso_y(S,i,delta,sigma,lambda);
    w_P(p(1,:),i)=p(2,:)';
end
