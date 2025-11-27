function main_SIS(w,Beta_0,Mu,netname,r,id,x,y)
%真实网络
% load networks\karate_w  %导入网络
% Beta_0=[0.2,0.4]';      %动力学参数感染率
% Mu=1；                  %动力学参数回复率   
% id=1;                   %表示网络只有一层，要生成网络，否则是多层网络
% netname="karate"        %网络名称
% r=0.5;                  %%閲嶅彔姣斾緥

% x=0.1:0.1:2;      %参数
% y=[50,100,200,500,800,1000,5000]; %时间序列长度



%%%%%如果只有一层网络要生成多层%%%%%%%%%%
if id==1
    w=Net_2_Mult_Net(w,r);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%

N=size(w,1);    %节点数
L=size(w,3);    %层数


res_all_best=0; %最好的结果
res_all_min=0;   %求得最优结果
TT=5;
for tt=1:TT  %五次平均
    res_best=zeros(length(x),(L+1)*2+L,length(y));
    res_min=zeros(length(x),(L+1)*2+L,length(y));

    for i=1:length(x)
        Beta_L=x(i)*Beta_0;  %%Beta_L=2J_L/(kT)
        SS=SIS_Multilayer_dynamics(w,Beta_L,Mu,0.3,max(y)*N); %数据的生成
        for j=1:length(y)
            S=SS(1:N*y(j),:);

            [w_r,E_r]=Reconstruction_Multilayer_Network_MA_SIS(S,L);
            [SUC_F1_best,SUC_F1_min,~]=RUN_Reconstruction_Multilayer_Network_MA_SIS(w_r,E_r,w);

            res_best(i,:,j)=SUC_F1_best;
            res_min(i,:,j)=SUC_F1_min;
        end
        res_best
        res_min
    end
    res_all_best=res_all_best+res_best
    res_all_min=res_all_min+res_min


    if id==1
        eval(strcat("save res\SIS_res_",netname,'_',num2str(r*100),' res_all_best res_all_min'))
    else
        eval(strcat("save res\SIS_res_nor_",netname,' res_all_best res_all_min'))
    end
end
