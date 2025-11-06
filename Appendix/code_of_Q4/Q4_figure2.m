clear;clc;warning off;
filename='SMA处理后的数据.xlsx';
Signal=readtable(filename);
Sig=table2array(Signal);
filename='问题4导航定位结果1.xlsx';
Prediction=readtable(filename);
Pre=table2array(Prediction);
Local=[100 300 50%发射源位置
    1000 100 150
    -1000 -100 450
    -200 -100 1050];
v=[0 0 0%发射源速度
    0 0 0
    0 0 8
    20 0 0];

T=zeros(1001,4);%TDOA全转化为TOA信息
T(:,2)=Sig(:,1);%信号源2的TOA信息
T(:,4)=Sig(:,2)-Sig(:,3);%信号源4的TOA信息
T(:,3)=Sig(:,2);%信号源3的TOA信息
Len_TOA=T*3e8;

I=Sig(:,8:10);lens=zeros(1001,4);
for i=1:1001
    lens(i,1)=Length(I(i,1));   
    lens(i,3)=Length(I(i,2));  
    lens(i,4)=Length(I(i,3));
end

err=zeros(1001,1);
Er=zeros(1001,6);
%修正发射源3前
% for i=1:1001%寻找最大误差范围
%     Er(i,1)=abs(sqrt((Pre(i,1)-Local(1,1))^2+(Pre(i,2)-Local(1,2))^2+(Pre(i,3)-Local(1,3))^2)-lens(i,1));
%     Er(i,2)=abs(sqrt((Pre(i,1)-Local(3,1))^2+(Pre(i,2)-Local(3,2))^2+(Pre(i,3)-Local(3,3)-v(3,3)*0.01*(i-1))^2)-lens(i,3));
%     Er(i,3)=abs(sqrt((Pre(i,1)-Local(4,1)-v(4,1)*0.01*(i-1))^2+(Pre(i,2)-Local(4,2))^2+(Pre(i,3)-Local(4,3))^2)-lens(i,4));
%     Er(i,4)=abs(sqrt((Pre(i,1)-Local(2,1))^2+(Pre(i,2)-Local(2,2))^2+(Pre(i,3)-Local(2,3))^2)-Len_TOA(i,2));
%     Er(i,5)=abs(sqrt((Pre(i,1)-Local(3,1))^2+(Pre(i,2)-Local(3,2))^2+(Pre(i,3)-Local(3,3)-v(3,3)*0.01*(i-1))^2)-Len_TOA(i,3));
%     Er(i,6)=abs(sqrt((Pre(i,1)-Local(4,1)-v(4,1)*0.01*(i-1))^2+(Pre(i,2)-Local(4,2))^2+(Pre(i,3)-Local(4,3))^2)-Len_TOA(i,4));
%     err(i)=max(max(Er(i,1:6)));
% end
%修正发射源3后
for i=1:1001%寻找最大误差范围
    Er(i,1)=abs(sqrt((Pre(i,1)-Local(1,1))^2+(Pre(i,2)-Local(1,2))^2+(Pre(i,3)-Local(1,3))^2)-400-lens(i,1))*.4;
    Er(i,2)=abs(sqrt((Pre(i,1)-Local(3,1))^2+(Pre(i,2)-Local(3,2))^2+(Pre(i,3)-Local(3,3)-v(3,3)*0.01*(i-1))^2)-45-lens(i,3));
    Er(i,3)=abs(sqrt((Pre(i,1)-Local(4,1)-v(4,1)*0.01*(i-1))^2+(Pre(i,2)-Local(4,2))^2+(Pre(i,3)-Local(4,3))^2)+12-lens(i,4));
    Er(i,4)=abs(sqrt((Pre(i,1)-Local(2,1))^2+(Pre(i,2)-Local(2,2))^2+(Pre(i,3)-Local(2,3))^2)-300-Len_TOA(i,2));
    Er(i,5)=abs(sqrt((Pre(i,1)-Local(3,1))^2+(Pre(i,2)-Local(3,2))^2+(Pre(i,3)-Local(3,3)-v(3,3)*0.01*(i-1))^2)-Len_TOA(i,3));
    Er(i,6)=abs(sqrt((Pre(i,1)-Local(4,1)-v(4,1)*0.01*(i-1))^2+(Pre(i,2)-Local(4,2))^2+(Pre(i,3)-Local(4,3))^2)-Len_TOA(i,4));
    err(i)=max(max(Er(i,1:6)));
end

%所有误差图
plot(Er(1:1000,:),LineWidth=2);
xlabel('时间/10ms')
ylabel('误差值/m')
legend('源1RSSI','源3RSSI','源4RSSI','源2TOA','源3TOA','源4TOA')
saveas(gcf,'修正前各项误差.jpg','jpeg')

%最大误差图
%plot(err(1:1000));