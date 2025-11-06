clear;clc;warning off;
filename='fujian.xlsx';
Signal=readtable(filename,'Sheet','接收情况1');
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
T(:,1)=Sig(:,1);
T(:,2)=Sig(:,1)-Sig(:,3);
T(:,3)=Sig(:,2)+Sig(:,4);
T(:,4)=Sig(:,2);
Len_TOA=T*3e8;

I=Sig(:,8:10);lens=zeros(1001,3);

for i=1:1001
    lens(i,1)=Length(I(i,1));   
    lens(i,2)=Length(I(i,2));  
    lens(i,3)=Length(I(i,3));
end

