function lee_input_mode(sp)
%lee_input_mode lee el tipo de entrada
% input_mode = 0 --> escalon
% input_mode = 1 --> potenciometro

fprintf(1,'Leyendo input mode...  \n')


fwrite(sp,'g','char');
val_r = fread(sp,1,'uint8');

ss = {'Escalon','Potenciometro'};
fprintf(1,'     Input_mode -->  %s  ',ss{val_r+1})

end

