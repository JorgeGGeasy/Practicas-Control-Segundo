function lee_dispdatmax(sp)
%lee_dispdatmax lee el valor de la variable max_datos
% max_datos indica el numero maximo de datos capturados

fprintf(1,'Leyendo la variable max_datos ...  ')

%fopen(sp)
fwrite(sp,'m','char');
val_r = fread(sp,1,'int');

%fclose(sp)
    fprintf(1,'\n')
    fprintf(1,['     val = %d  \n'],val_r)
%pause(1)
end