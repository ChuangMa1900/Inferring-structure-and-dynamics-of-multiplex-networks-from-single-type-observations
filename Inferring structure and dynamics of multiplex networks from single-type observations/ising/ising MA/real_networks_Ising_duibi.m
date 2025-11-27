function real_networks_Ising_duibi
% 跑代码
% florentine_families_w
% high_tech_company_w
% CKM_w

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Beta_0=1.5*[0.2,0.4]';     %动力学参数
id=0;                   %表示是多层网络不需要生成
y=25:25:500; %时间序列长度
r=0;

load networks\florentine_families_w  %导入
netname="florentine_families"        %网络名称
main_Ising_duibi(w,Beta_0,netname,r,id,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beta_0=0.4*[0.2,0.4]';     %动力学参数
% id=0;                   %表示是多层网络不需要生成
% y=25:25:500; %时间序列长度
% r=0;
% 
% load networks\CS_Aarhus_2_w  %导入
% netname="CS_Aarhus_2"        %网络名称
% main_Ising_duibi(w,Beta_0,netname,r,id,y)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beta_0=1*[0.05,0.1,0.25]';     %动力学参数
% id=0;                   %表示是多层网络不需要生成
% y=50:50:1000;            %时间序列长度
% r=0;
% 
% load networks\high_tech_company_w  %导入
% netname="high_tech_company"        %网络名称
% main_Ising_duibi(w,Beta_0,netname,r,id,y)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beta_0=[0.05,0.1,0.25]';     %动力学参数
% id=0;                   %表示是多层网络不需要生成
% y=50:50:1000; %时间序列长度
% r=0;
% 
% load networks\CS_Aarhus_3_w  %导入
% netname="CS_Aarhus_3"        %网络名称
% main_Ising_duibi(w,Beta_0,netname,r,id,y)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beta_0=[0.05,0.1,0.25]';     %动力学参数
% id=0;                   %表示是多层网络不需要生成
% y=50:50:1000; %时间序列长度
% r=0;
% 
% load networks\CKM_w  %导入
% netname="CKM"        %网络名称
% main_Ising_duibi(w,Beta_0,netname,r,id,y)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%