function TEM=fitness(var)  %var(�м�ϵ��a  ���  ʱ��ƫ����)���˲���
real = csvread('./A.csv');
real = real';
l1=0.0006;
l2=0.006;
l3=0.0036;
l4=0.005;
l5=var(2);
Lambda=[0.082 0.37 0.045 0.028];%����ϵ��
cp=[1377 2100 1726 1005];%����
rou=[300 862 74.2 1.18];%�ܶ�
b = Lambda./rou./cp;%�����м�ϵ��
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
time =5420;
tspan=[0 time];
ind = 1:1:(time-20);
inter=real(1:time-20);
ngrid=[rt*tspan(2) xsec(6)];
[T,x,t]=rechuandao(a,xspan,tspan,ngrid,xsec);

Temp=[];
sum=0;
for num=1:(time-20)
    Temp(num) = T((num+var(3))*rt,xsec(5));
    sum=sum+abs(T((num+var(3))*rt,xsec(5))-real(num)); %%���Լ����������
end

figure(1)
plot(ind,Temp,'r');
hold on;
plot(ind,inter,'b');
legend('����','ʵ��')
 T(2000*800,xsec(5))
TEM = T;
%TEM=sum %�����ֵ

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
        error('�㷨������!')
    end
end

s=1-2*r;
U=zeros(ngrid);%����ֵ
U(1,:)=37;%�ٶ���ʼ�¶�Ϊ37
for j=2:n
    for rowt=1:5
       for i=xsec(rowt):(xsec(rowt+1)-1)
          U(j,i)=s(rowt)*U(j-1,i)+r(rowt)*(U(j-1,i-1)+U(j-1,i+1));
       end
    end
        %%%%%%%�����Ǳ߽�����
    U(j,1)=75;
    U(j,m)=37;%���ȱ߽�����
    
end