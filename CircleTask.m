function CircleTask(~,event)
 event_time = datestr(event.Data.time);   %使用event对象的data的time属性获得系统当前时间，并转换成字符串
 d=event_time(19:20);   %由于本身保存的是年月日小时分钟秒，但我只需要秒的数据，因此单独取出
 d=str2double(d); %将字符串转换成数字
filepath='E:\zd9a\';
filename=[filepath,'Dec\\1100209X001',datestr(now,'yyyymmdd'),'.epd'];
filenamee=[filepath,'Dec\\保存1100209X001',datestr(now,'yyyymmdd'),'.epd'];
cotent=['Dec\\1100209X001',datestr(now,'yyyymmdd'),'.epd']; 
f=ftp('10.11.51.34:22','xjl','123321');%连接ftp服务器    
dir(f);%显示ftp服务器上所有文件
mget(f,cotent,filepath);%将服务器上文件下载到本机指定的文件夹里
close(f);%关闭ftp 
fidr=fopen(filename,'r');
fidw=fopen(filenamee,'wt');
while ~feof(fidr)
    s=fgetl(fidr);
    s=strrep(s,'NULL','nan');
    fprintf(fidw,'%s\n',s);
end
fclose(fidr);
fclose(fidw);
A=importdata(filenamee);%将数据导入矩阵A中
% A=A.data;
% a=A;
% [m,n]=find(isnan(a)==1);
% a(m,:)=[];
% A=a;
subplot(6,1,1);plot(floor(A(:,1)/100)+(A(:,1)/100-floor(A(:,1)/100))/0.6,A(:,2));%????
xlabel('/h');
ylabel('mv/km');
set(gca,'XTick',0:1:24)
subplot(6,1,2);plot(floor(A(:,1)/100)+(A(:,1)/100-floor(A(:,1)/100))/0.6,A(:,3));
xlabel('/h');
ylabel('mv/km');
set(gca,'XTick',0:1:24)
subplot(6,1,3);plot(floor(A(:,1)/100)+(A(:,1)/100-floor(A(:,1)/100))/0.6,A(:,4));
xlabel('/h');
ylabel('mv/km')
set(gca,'XTick',0:1:24)
subplot(6,1,4);plot(floor(A(:,1)/100)+(A(:,1)/100-floor(A(:,1)/100))/0.6,A(:,5));
xlabel('/h');
ylabel('mv/km');
set(gca,'XTick',0:1:24)
subplot(6,1,5);plot(floor(A(:,1)/100)+(A(:,1)/100-floor(A(:,1)/100))/0.6,A(:,6));
xlabel('/h');
ylabel('mv/km');
set(gca,'XTick',0:1:24)
subplot(6,1,6);plot(floor(A(:,1)/100)+(A(:,1)/100-floor(A(:,1)/100))/0.6,A(:,7));
xlabel('/h');
ylabel('mv/km');
set(gca,'XTick',0:1:24)
if size(A,1)>=10
%     kong=floor(A(end,1)/100)*60+(A(end,1)/100-floor(A(end,1)/100))*100-floor(A(end-1,1)/100)*60-(A(end-1,1)/100-floor(A(end-1,1)/100))*100;
   A1=[A(end-9:end,2),A(end-9:end,3),A(end-9:end,4),A(end-9:end,5),A(end-9:end,6),A(end-9:end,7)];
    kong=numel(A1(isnan(A1)))/6;
    if kong>=10
        msgbox('观测数据已连续十分钟为NULL')
        Fs = 44100; % 采样频率
        FT = 4;     % 时间长度
        Fn = Fs*FT;  % 采样点数
        Ff = 500;   % 声音频率
        Fy = sin(2*pi*Ff*FT*linspace(0,1,Fn+1));
        sound(Fy,Fs)
    end
end
delete(filenamee);
end