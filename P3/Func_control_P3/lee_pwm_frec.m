function lee_pwm_frec(sp)
%lee_pwm_frec lee la frecuencia del PWM
% pwm_frec --> frecuencia en Hz

fprintf(1,'Configurando frecuencia del PWM...  \n')

%fopen(sp)
fwrite(sp,'p','char');
val_r = fread(sp,1,'uint32');

%fclose(sp)
fprintf(1,'   Frec. PWM = %d Hz : \n',val_r)
%pause(1)
end

