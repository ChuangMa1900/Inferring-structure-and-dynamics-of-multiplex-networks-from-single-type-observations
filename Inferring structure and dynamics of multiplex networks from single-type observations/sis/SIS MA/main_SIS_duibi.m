function main_SIS_duibi(w,Beta_0,Mu,netname,r,id,y)
%真实网络
% load networks\karate_w  %导入网络w
% Beta_0=[0.2,0.4]';      %动力学参数感染率
% Mu=1；                  %动力学参数回复率   
% id=1;                   %表示网络只有一层，要生成网络，否则是多层网络
% netname="karate"        %网络名称
% r=0.5;                  %重叠比
% y=[50,100,200,500,800,1000,5000]; %时间序列长度

%%%%%瀵煎叆缃戠粶%%%%%%%%%%
if id==1
    w=Net_2_Mult_Net(w,r);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%

N=size(w,1);    %节点数
L=size(w,3);    %层数


res_all_best=0;
TT=5;
for tt=1:TT  %五次平均
    res_best=zeros(length(y),(L+1)*2+L,3);

    SS=SIS_Multilayer_dynamics(w,Beta_0,Mu,0.3,max(y)*N); %数据的生成

    for j=1:length(y)
        S=SS(1:N*y(j),:);


        [w_r_CST,~]=Reconstruction_Multilayer_Network_CST_SIS(S,L);
        [SUC_F1_best_CST,~]=RUN_Reconstruction_Multilayer_Network_CST_SIS(w_r_CST,w);
        res_best(j,:,1)=SUC_F1_best_CST;

        [w_r_lasso,~]=Reconstruction_Multilayer_Network_lasso_SIS(S,L);
        [SUC_F1_best_lasso,~]=RUN_Reconstruction_Multilayer_Network_lasso_SIS(w_r_lasso,w);
        res_best(j,:,2)=SUC_F1_best_lasso;


        [w_r,E_r]=Reconstruction_Multilayer_Network_MA_SIS(S,L);
        [SUC_F1_best,~,~]=RUN_Reconstruction_Multilayer_Network_MA_SIS(w_r,E_r,w);
        res_best(j,:,3)=SUC_F1_best;

    end
    res_all_best=res_all_best+res_best

    if id==1
        eval(strcat("save res\SIS_res_duibi_",netname,'_',num2str(r*100),' res_all_best '))
    else
        eval(strcat("save res\SIS_res_duibi_",netname,' res_all_best '))
    end
end
