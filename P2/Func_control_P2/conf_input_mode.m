function conf_input_mode(sp,input_mode)
%conf_input_mode configura el tipo de entrada
% input_mode = 0 --> escalon
% input_mode = 1 --> potenciometro

fprintf(1,'Configurando input_mode...  \n')
ss = {'Escalon','Potenciometro'};
fprintf(1,'     Input_mode -->  %s  ',ss{input_mode+1})

val = input_mode;
%fopen(sp)
fwrite(sp,'G','char');
fwrite(sp,val,'uint8');
val_r = fread(sp,1,'uint8');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
fprintf(1,'%s\n',ss{double((d)>0)+1})
%pause(1)
end

