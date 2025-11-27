function F1_SUC=clc_F1_SUC(A0,A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入:
%      A0  原始结果
%      A   重构的结果
%输出:
%   每一层和总的: success_rate正确率 + F1指标
 

L=size(A0,3);
ss=10^-10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tp=length(find(A0+A==2));       %%%%预测正确的有边的结果数
tn=length(find(A0+A==0));       %%%%预测正确的无边的结果数
fp=length(find(A-A0==1));       %%%%预测错误的有边的结果数
fn=length(find(A0-A==1));       %%%%预测错误的无边的结果数

precision=tp/(tp+fp+ss);       %%%%精确率
recall=tp/(tp+fn+ss);      %%%%召回率
F1=2*precision*recall/(precision+recall+ss);
success_rate=(tp+tn)/(tp+fn+tn+fp+ss);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F1_part=zeros(1,L);
success_rate_part=zeros(1,L);
for i=1:L
    tp=length(find(A0(:,:,i)+A(:,:,i)==2));       %%%%预测正确的有边的结果数
    tn=length(find(A0(:,:,i)+A(:,:,i)==0));       %%%%预测正确的无边的结果数
    fp=length(find(A(:,:,i)-A0(:,:,i)==1));       %%%%预测错误的有边的结果数
    fn=length(find(A0(:,:,i)-A(:,:,i)==1));       %%%%预测错误的无边的结果数
    precision=tp/(tp+fp+ss);       %%%%精确率
    recall=tp/(tp+fn+ss);      %%%%召回率
    F1_part(i)=2*precision*recall/(precision+recall+ss);
    success_rate_part(i)=(tp+tn)/(tp+fn+tn+fp+ss);
end
F1_SUC=[success_rate_part,success_rate,F1_part,F1];




