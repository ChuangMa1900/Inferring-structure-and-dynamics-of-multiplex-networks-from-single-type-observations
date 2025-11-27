function w_P=res_CST_sis(S)
dlmwrite('s_time_state.txt',S,' ');
T=10;
w_P=0;
for i=1:T
   w_P=w_P+CST(0.8)/T;
end
delete('s_time_state.txt')
