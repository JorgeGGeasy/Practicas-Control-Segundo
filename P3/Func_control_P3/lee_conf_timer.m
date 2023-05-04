function lee_conf_timer(sp)
%lee_directin lee el valor de la variable direct

fprintf(1,'Leyendo configuracion del timer ...  \n')

    %fopen(sp)

    fwrite(sp,'t','char');
    timer_div_r = fread(sp,1,'uint32');
    timer_alarm_r = fread(sp,1,'uint32');

    fprintf(1,['     timer_divider = %d   \n'],timer_div_r)
    fprintf(1,['     timer_alarm = %d   \n'],timer_alarm_r)
    
    fprintf(1,'     Ts  = %d  ms \n',(timer_div_r*timer_alarm_r)/80e3)
    %fclose(sp)
end