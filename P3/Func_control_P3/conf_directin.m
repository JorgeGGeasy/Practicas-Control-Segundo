function conf_directin(sp,val,display)
%conf_directin escribe el valor de la variable direct
% direct es la entrada directa al motor

fprintf(1,'Configurando entrada directa ...  ')

%fopen(sp)
fwrite(sp,'D','char');
fwrite(sp,val,'float');
val_r = fread(sp,1,'float');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
if display == 1
    fprintf(1,'\n')
    fprintf(1,['     val = %2.3f  (%s) \n'],val_r,ss{d+1})
else
    fprintf(1,'%s\n',ss{double((d)>0)+1})
end
%pause(1)
end