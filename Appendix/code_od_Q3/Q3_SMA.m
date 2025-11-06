clear;clc;warning off;
filename='fujian.xlsx';
Signal=readtable(filename,'Sheet','接收情况2');
Sig=table2array(Signal);

%随机偏差的消除
newSig=zeros(1001,10);
for j=1:10
    for i=1:1001
        meanS=mean(Sig(max(1,i-13):min(1001,i+13),j));
        r=(rand+2)/3;
        newSig(i,j)=r*meanS+(1-r)*Sig(i,j);
    end
end
newnewSig=zeros(1001,10);
for j=1:10
    for i=1:1001
        meanS=mean(newSig(max(1,i-13):min(1001,i+13),j));
        r=(rand+2)/3;
        newnewSig(i,j)=r*meanS+(1-r)*newSig(i,j);
    end
end
plot(Sig(1:1000,1),LineWidth=1)
hold on;
plot(newSig(1:1000,1),LineWidth=1)
hold on;
plot(newnewSig(1:1000,1),LineWidth=1)
xlabel('时间/10ms')
ylabel('TOA时间/s')
legend('原始数据','一次平滑后的数据','两次平滑后的数据')
saveas(gcf,'发射源2TOA数据消除偏差.jpg','jpeg')
xlswrite('SMA处理后的数据1.xlsx',newnewSig);