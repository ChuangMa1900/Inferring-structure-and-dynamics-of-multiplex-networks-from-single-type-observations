function real_networks_noise_Ising

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load networks\florentine_families_w
Beta_0=[0.2,0.4]';
T=10000;	%%时间序列长度
netname="florentine_families" ;
x=0:0.01:0.3;

main_noise_Ising(w,Beta_0,netname,T,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%