function lee_feedback_mode(sp)
%lee_feedback_mode lee el tipo de realimentacion
% fb_mode = 0 --> realimenta el valor del angulo
% fb_mode = 1 --> realimenta el valor del velocidad

fprintf(1,'Leyendo feedback_mode...  \n')


fwrite(sp,'f','char');
val_r = fread(sp,1,'uint8');

ss = {'angulo','velocidad'};
fprintf(1,'      Feedback de %s  ',ss{val_r+1})

end

