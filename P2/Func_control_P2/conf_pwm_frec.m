function conf_pwm_frec(sp,pwm_frec)
%conf_pwm_frec configura la frecuencia del PWM
% pwm_frec --> frecuencia en Hz

fprintf(1,'Configurando frecuencia del PWM...  \n')

val = pwm_frec;
%fopen(sp)
fwrite(sp,'P','char');
fwrite(sp,val,'uint32');
val_r = fread(sp,1,'uint32');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
fprintf(1,'   Frec. PWM = %d Hz : %s\n',pwm_frec,ss{double((d)>0)+1})
%pause(1)
end

