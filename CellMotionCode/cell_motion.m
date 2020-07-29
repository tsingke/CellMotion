% -----------------------------------
% �����ܣ� ϸ���˶��켣����
% �㷨���ߣ� ɽ��ʦ����ѧ �����
% ������ϵ�� tsingke@hotmail.com
% ע����� �޸ı������ΪĿ����   
% -----------------------------------

% ��������
clear;
clc;
close all;

%% ---------------׼���������޸����ݱ�����-------------------------
% 1. �޸�ΪҪ�����Excel���ݱ����ƣ���Excel���ȸ��Ƶ�������Ŀ¼�����޸���� 
data = xlsread('PIM401.xlsx');%��ȡexcel����

% 2. ʵ�������·��
disp('---------------------------��ܰ��ʾ----------------------------------');
disp('> 1.������ƣ�data = xlsread("�޸ı������.xlsx")');
disp('> 2.�洢λ�ã�ͼ��洢�ڱ���Ŀ¼ ExperimentResults\');
filepath = 'ExperimentResults\';
disp('--------------------------------------------------------------------');

disp('  ��㰴�س�������ʼ���г���...');

pause;


%% -------------------** ���³��������벻Ҫ�޸�  **-----------------

% Ԥ��������洢�ռ�
[row,~]=size(data);

idmax=max(data(:,2));% ����155

groupid = 1:idmax;% �����ı��1-155

homei=1;
endi=1;

%% ���ݴ���
i=1;
count=1;
while i <= row
   
    % �ȱ�����һ����׸�x��y����ֵ
    homei = i;
    
    homex=data(i,3);
    homey=data(i,4);
    
    currentid = data(i,2);
    
    i = i+1; %��һ��
    
    if i>row
        break;
    end
    
    % ���ƥ��
    while data(i,2)== currentid
        
        %��������-�������λ��
        data(i,3) = data(i,3)- homex;
        data(i,4) = data(i,4)- homey;
        
        if i>=row
            break;
        end
        
         i = i+1;
       
    end
    
    % ��������
    data(homei,3) = 0;
    data(homei,4) = 0;
    
    endi=i-1;
    
   % fprintf('homei = %d , endi = %d\n',homei,endi);%
    
   %��ʼ���Ʊ���ͼ��
    plot(data(homei:endi,3),data(homei:endi,4),'-*','lineWidth', 1,'MarkerSize',5);
    grid on;  % ��ͼ���������
    %pause(0.05);% ��ͣ0.05�룬ȡ��ע�ͺ���Թۿ���̬�켣ͼ
    hold on;  
    

    disp(['������� ',num2str(count),' ������']);
    
    count=count+1;%ͳ������
  
    
end



%% �����˶��켣ͼ��
filename = strcat(filepath,'cell_motion');
saveas(gcf,filename,'pdf');
saveas(gcf,filename,'png');
saveas(gcf,filename,'jpg');
saveas(gcf,filename,'emf');

% ͼ��ע��
title('Cell motion');
xlabel('x ({\mu m})');
ylabel('y ({\mu m})');
set(gca,'linewidth',0.7);
xlim([-120 120]);%�����귶Χ�����������޸�������ʼ����
ylim([-100 100]);%�����귶Χ�����������޸�������ʼ����
%axis equal;     % ��������ε�ͼ��


%% �������ݵ�excel��
excelname = strcat(filepath,'cell_motion.xlsx');
xlswrite(excelname,data,'sheet1');

disp('------��ϲ�����ݴ������,ͼ�������� ��------');

clear;














