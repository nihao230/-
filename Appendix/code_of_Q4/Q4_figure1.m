clear;clc;warning off;
filename='SMA处理后的数据.xlsx';
Signal=readtable(filename);
Sig=table2array(Signal);
Local=[100 300 50%发射源位置
    1000 100 150
    -1000 -100 450
    -200 -100 1050];
v=[0 0 0%发射源速度
    0 0 0
    0 0 8
    20 0 0];

T=zeros(1001,4);%TDOA全转化为TOA信息
T(:,2)=Sig(:,1);
T(:,4)=Sig(:,2)-Sig(:,3);
T(:,3)=Sig(:,2);
Len_TOA=T*3e8;

I=Sig(:,8:10);lens=zeros(1001,4);
for i=1:1001
    lens(i,1)=Length(I(i,1));   
    lens(i,3)=Length(I(i,2));  
    lens(i,4)=Length(I(i,3));
end

Del=lens(:,3:4)-Len_TOA(:,3:4);
plot(Del(1:1000,:))
mean3=mean(Del(1:1001,1));
mean4=mean(Del(1:1001,2));
xlabel('时间/10ms')
ylabel('差值/m')
legend('发射源3','发射源4')
saveas(gcf,'发射源3-4RSSI-TOA数据差值.jpg','jpeg')