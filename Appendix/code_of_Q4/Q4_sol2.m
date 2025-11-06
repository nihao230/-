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

pos=zeros(1001,3);%保存TOA的0-10s位置信息
cnt=1;%TOA&AOA求解
for i=1:1001
    Sol=Location_Q4([Local(4,:)+v(4,:)*0.01*(i-1),Len_TOA(i,4)+45,Sig(i,6:7)]);
    if((Sol(1,1)-Sol(2,1))*Sig(i,6)>0)
        pos(cnt,:)=Sol(1,:);
    else
        pos(cnt,:)=Sol(2,:);
    end
    cnt=cnt+1;
end
xlswrite('问题4导航定位结果2.xlsx',pos);

for i=1:1001
    scatter3(pos(i,1),pos(i,2),pos(i,3),'MarkerFaceColor',[i/1001, i/1001,i/1001]);hold on;
end
xlabel('x/m')
ylabel('y/m')
zlabel('z/m')
saveas(gcf,'Q4_trace2.jpg', 'jpeg')

% % 定义GIF文件名 
% figname = 'Q4_2.gif';
% % 创建一个循环，生成动画的每一帧
% for i = 1:20:1001
%     % 更新图形数据
%     scatter3(Local(1,1),Local(1,2),Local(1,3),'g','filled');hold on;
%     scatter3(Local(2,1),Local(2,2),Local(2,3),'y','filled');hold on;
%     scatter3(Local(3,1),Local(3,2),Local(3,3)+v(3,3)*0.01*(i-1),'k','filled');hold on;
%     scatter3(Local(4,1)+v(4,1)*0.01*(i-1),Local(4,2),Local(4,3),'b','filled');hold on;
%     scatter3(pos(i,1),pos(i,2),pos(i,3),'r','filled');hold on;
%     xlabel('x/m')
%     ylabel('y/m')
%     zlabel('z/m')
%     legend('发射源1','发射源2','发射源3','发射源4','飞行器')
%     % 设置坐标轴的界限
%     %axis([0 10 -1 1])
% 
%     % 捕获当前图形的帧
%     drawnow
%     frame = getframe(1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     % 写入GIF文件
%     if i == 1
%         imwrite(imind,cm,figname,'gif', 'Loopcount',inf);
%     else
%         imwrite(imind,cm,figname,'gif','WriteMode','append');
%     end
% end