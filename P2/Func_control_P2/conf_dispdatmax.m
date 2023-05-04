function conf_dispdatmax(sp,val,display)
%conf_dispdatmax escribe el valor de la variable max_datos
% max_datos indica el numero maximo de datos capturados

fprintf(1,'Configurando la variable max_datos...  ')

%fopen(sp)
fwrite(sp,'M','char');
fwrite(sp,val,'int');
val_r = fread(sp,1,'int');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
if display == 1
    fprintf(1,'\n')
    fprintf(1,['     val = %d  (%s) \n'],val_r,ss{d+1})
else
    fprintf(1,'%s\n',ss{double((d)>0)+1})
end
%pause(1)
end