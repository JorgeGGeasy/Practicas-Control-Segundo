function lee_diezmadisplay(sp)
%lee_diezmadisplay lee el valor de la variable diezm_display
% max_datos indica el numero maximo de datos capturados

fprintf(1,'Leyendo la variable diezm_display ...  ')

%fopen(sp)
fwrite(sp,'n','char');
val_r = fread(sp,1,'int');

%fclose(sp)
    fprintf(1,'\n')
    fprintf(1,['     val = %d  \n'],val_r)
%pause(1)
end