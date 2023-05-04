function conf_feedback_mode(sp,fb_mode)
%conf_feedback_mode configura el tipo de realimentacion
% fb_mode = 0 --> realimenta el valor del angulo
% fb_mode = 1 --> realimenta el valor del velocidad

fprintf(1,'Configurando feedback_mode...  \n')
ss = {'angulo','velocidad'};
fprintf(1,'     Feedback de %s  ',ss{fb_mode+1})

val = fb_mode;
%fopen(sp)
fwrite(sp,'F','char');
fwrite(sp,val,'uint8');
val_r = fread(sp,1,'uint8');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
fprintf(1,'%s\n',ss{double((d)>0)+1})
%pause(1)
end

