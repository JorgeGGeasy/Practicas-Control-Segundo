function conf_timer(sp,timer_div,timer_alarm,display)
%conf_timer escribe las variables para configurar las interrupciones del
%timer
% "timer_div" factor divisor del timer [2..65536]
% "timer_alarm" valor de la alarma (uint32)
% Frec_interrupcion = 80*timer_alarm/timer_div
%

fprintf(1,'Configurando variables del timer ... \n ')
fprintf(1,'     Ts  = %d  ms \n',(timer_div*timer_alarm)/80e3)

if (timer_div == 65536)
    timer_div = 0;
end

%fopen(sp)
fwrite(sp,'T','char');
fwrite(sp,timer_div,'uint32');
timer_div_r = fread(sp,1,'uint32');
fwrite(sp,timer_alarm,'uint32');
timer_alarm_r = fread(sp,1,'uint32');

%fclose(sp)

d1 = timer_div ~= timer_div_r;
d2 = timer_alarm ~= timer_alarm_r;
ss = {'OK','ERROR'};
if display == 1
    %fprintf(1,'\n')
    fprintf(1,['     timer_divider = %d  (%s) \n'],timer_div_r,ss{d1+1})
    fprintf(1,['     timer_alarm = %d  (%s) \n'],timer_alarm_r,ss{d2+1})
    
else
    fprintf(1,'%s - %s \n',ss{double((d1)>0)+1},ss{double((d2)>0)+1})
end
%pause(1)
end