var = [0.67155e-7 0.0063 5];
TEM=fitness(var);

rx=71;
rt=850;

%%%%%%下面算法用以绘制3d图像并输出温度分布
% gra=[];
% k1=1:1:5400;
% o1=1:1:52;
% for k=1:5400
%     for o=1:52   %52为人体表面所处的网格位置
%         gra(k,o)= TEM((k+var(3))*rt,o);
%     end
% end
% mesh(o1,k1,gra);
% axis([0 60 0 6000 0 80]);
% xlabel('x')
% ylabel('t')
% zlabel('T')
%xlswrite('./problem1.xlsx',gra);  %%将分布数据写入文件
