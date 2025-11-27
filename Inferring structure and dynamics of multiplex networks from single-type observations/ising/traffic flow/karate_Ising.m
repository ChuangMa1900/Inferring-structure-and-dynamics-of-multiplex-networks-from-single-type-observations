function karate_Ising
% 跑代码
load networks\karate_w  %导入w
Beta_0=[0.2,0.4]';     %动力学参数
id=1;                   %表示网络只有一层，要生成网络
netname="karate"        %网络名称

main_Ising(w,Beta_0,netname,0.1,id)
main_Ising(w,Beta_0,netname,0.3,id)
main_Ising(w,Beta_0,netname,0.5,id)
main_Ising(w,Beta_0,netname,0.7,id)
main_Ising(w,Beta_0,netname,0.9,id)