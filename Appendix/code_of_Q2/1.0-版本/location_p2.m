%利用距离和相关角度信息求解
function Pos=location_p2(P)%导入相关数据
syms xx yy zz%接受源坐标
eq1 = (xx-P(1))^2+(yy-P(2))^2+(zz-P(3))^2==P(4)^2;
eq2 =  (P(1)-xx)*P(5)==P(2)-yy;
eq3 =  (P(3)-zz)*P(6)==sqrt((P(2)-yy)^2+((P(1)-xx))^2);
[solx,soly,solz]=solve([eq1,eq2,eq3],[xx,yy,zz]);
x=double(solx);
y=double(soly);
z=double(solz);
Pos=[x,y,z];
end