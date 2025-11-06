function Len=Length(I)%发射源与接收源相对距离
Ist=100;    %标称信号强度
eta=20;     %信道衰减系数
Lenst=1000; %标称距离（与标称信号强度对应,m）
Len=Lenst*exp((Ist-I)*log(10)/10/eta); 
end