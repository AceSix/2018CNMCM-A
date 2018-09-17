function TEM=fitness3(val) %%长度 
var = [0.67155e-7 0.0063 5];
l1=0.0006;
l2=val(1)/1000;   %二层厚度待定(单位转化为米)
l3=0.0036;
l4=val(2)/1000;  %四层厚度待定（单位转化为米）
l5=var(2);
Lambda=[0.082 0.37 0.045 0.028];
cp=[1377 2100 1726 1005];
rou=[300 862 74.2 1.18];
b = Lambda./rou./cp;
a = [b(1) b(2) b(3) b(4) var(1)];

rx=71;
rt=850;

xlen = l1+l2+l3+l4+l5;
xsec = [2 
        ceil(rx*l1/xlen)+1
        ceil(rx*l1/xlen)+ceil(rx*l2/xlen)+1
        ceil(rx*l1/xlen)+ceil(rx*l2/xlen)+ceil(rx*l3/xlen)+1 
        ceil(rx*l1/xlen)+ceil(rx*l2/xlen)+ceil(rx*l3/xlen)+ceil(rx*l4/xlen)+1
        ceil(rx*l1/xlen)+ceil(rx*l2/xlen)+ceil(rx*l3/xlen)+ceil(rx*l4/xlen)+ceil(rx*l5/xlen)+1];
xspan=[0 l1+l2+l3+l4+l5];
time =1820;
tspan=[0 time];
ind = 1:1:(time-20);

ngrid=[rt*tspan(2) xsec(6)];
[T,x,t]=rechuandao(a,xspan,tspan,ngrid,xsec);
Temp=[];
sum=0;
sprintf( 'The surface temperature at 1800s is %d',T((1800+var(3))*rt,xsec(5)) )
sprintf( 'The surface temperature at 1500s is %d',T((1500+var(3))*rt,xsec(5)) )

Temp=[];

for num=1:(time-20)
    Temp(num) = T((num+var(3))*rt,xsec(5));
end

plot(ind,Temp,'r');
% T(2000*800,xsec(5));
TEM = T;

function [U,x,t]=rechuandao(a,xspan,tspan,ngrid,xsec)
n=ngrid(1);
m=ngrid(2);
h=range(xspan)/(m-1);
x=linspace(xspan(1),xspan(2),m);
k=range(tspan)/(n-1);
t=linspace(tspan(1),tspan(2),n);
r=a*k/h^2;
for rowi=1:5
    if r(rowi)>0.5
        error('算法不收敛!')
    end
end
s=1-2*r;
U=zeros(ngrid);
U(1,:)=37;
for j=2:n
    for rowt=1:5
       for i=xsec(rowt):(xsec(rowt+1)-1)
          U(j,i)=s(rowt)*U(j-1,i)+r(rowt)*(U(j-1,i-1)+U(j-1,i+1));
       end
    end
    U(j,1)=80; %80℃
    U(j,m)=37;
    
end