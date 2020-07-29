### CellMotion
细胞运动轨迹绘制


![image](cell_motion.jpg)

```matlab
% -----------------------------------
% 程序功能： 细胞运动轨迹计算
% 算法作者： 山东师范大学 张庆科
% 服务联系： tsingke@hotmail.com
% 注意事项： 修改表格名称为目标表格   
% -----------------------------------

% 数据清理
clear;
clc;
close all;

%% ---------------准备工作：修改数据表名称-------------------------
% 1. 修改为要处理的Excel数据表名称（把Excel表先复制到本程序目录后再修改这里） 
data = xlsread('PIM401.xlsx');%读取excel数据

% 2. 实验结果输出路径
disp('---------------------------温馨提示----------------------------------');
disp('> 1.表格名称：data = xlsread("修改表格名称.xlsx")');
disp('> 2.存储位置：图像存储在本地目录 ExperimentResults\');
filepath = 'ExperimentResults\';
disp('--------------------------------------------------------------------');

disp('  请点按回车键，开始运行程序...');

pause;


%% -------------------** 以下程序内容请不要修改  **-----------------

% 预分配变量存储空间
[row,~]=size(data);

idmax=max(data(:,2));% 组数155

groupid = 1:idmax;% 存放组的编号1-155

homei=1;
endi=1;

%% 数据处理
i=1;
count=1;
while i <= row
   
    % 先保存新一组的首个x，y的数值
    homei = i;
    
    homex=data(i,3);
    homey=data(i,4);
    
    currentid = data(i,2);
    
    i = i+1; %下一个
    
    if i>row
        break;
    end
    
    % 编号匹配
    while data(i,2)== currentid
        
        %减法操作-计算相对位移
        data(i,3) = data(i,3)- homex;
        data(i,4) = data(i,4)- homey;
        
        if i>=row
            break;
        end
        
         i = i+1;
       
    end
    
    % 组首清零
    data(homei,3) = 0;
    data(homei,4) = 0;
    
    endi=i-1;
    
   % fprintf('homei = %d , endi = %d\n',homei,endi);%
    
   %开始绘制本组图形
    plot(data(homei:endi,3),data(homei:endi,4),'-*','lineWidth', 1,'MarkerSize',5);
    grid on;  % 给图像添加网格
    %pause(0.05);% 暂停0.05秒，取消注释后可以观看动态轨迹图
    hold on;  
    

    disp(['处理完第 ',num2str(count),' 组数据']);
    
    count=count+1;%统计组数
  
    
end



%% 保存运动轨迹图像
filename = strcat(filepath,'cell_motion');
saveas(gcf,filename,'pdf');
saveas(gcf,filename,'png');
saveas(gcf,filename,'jpg');
saveas(gcf,filename,'emf');

% 图像注释
title('Cell motion');
xlabel('x ({\mu m})');
ylabel('y ({\mu m})');
set(gca,'linewidth',0.7);
xlim([-120 120]);%横坐标范围，可以自行修改坐标起始数据
ylim([-100 100]);%纵坐标范围，可以自行修改坐标起始数据
%axis equal;     % 输出正方形的图框


%% 保存数据到excel表
excelname = strcat(filepath,'cell_motion.xlsx');
xlswrite(excelname,data,'sheet1');

disp('------恭喜，数据处理完毕,图像绘制完成 ！------');

clear;

```
