function CircleTask(~,event)
 event_time = datestr(event.Data.time);   %ʹ��event�����data��time���Ի��ϵͳ��ǰʱ�䣬��ת�����ַ���
 d=event_time(19:20);   %���ڱ��������������Сʱ�����룬����ֻ��Ҫ������ݣ���˵���ȡ��
 d=str2double(d); %���ַ���ת��������
filepath='E:\zd9a\';
filename=[filepath,'Dec\\1100209X001',datestr(now,'yyyymmdd'),'.epd'];
filenamee=[filepath,'Dec\\����1100209X001',datestr(now,'yyyymmdd'),'.epd'];
cotent=['Dec\\1100209X001',datestr(now,'yyyymmdd'),'.epd']; 
f=ftp('10.11.51.34:22','xjl','123321');%����ftp������    
dir(f);%��ʾftp�������������ļ�
mget(f,cotent,filepath);%�����������ļ����ص�����ָ�����ļ�����
close(f);%�ر�ftp 
fidr=fopen(filename,'r');
fidw=fopen(filenamee,'wt');
while ~feof(fidr)
    s=fgetl(fidr);
    s=strrep(s,'NULL','nan');
    fprintf(fidw,'%s\n',s);
end
fclose(fidr);
fclose(fidw);
A=importdata(filenamee);%�����ݵ������A��
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
        msgbox('�۲�����������ʮ����ΪNULL')
        Fs = 44100; % ����Ƶ��
        FT = 4;     % ʱ�䳤��
        Fn = Fs*FT;  % ��������
        Ff = 500;   % ����Ƶ��
        Fy = sin(2*pi*Ff*FT*linspace(0,1,Fn+1));
        sound(Fy,Fs)
    end
end
delete(filenamee);
end