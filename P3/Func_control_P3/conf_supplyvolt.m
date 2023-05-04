function conf_supplyvoltt(sp,val,display)
%conf_supplyvolt escribe el valor del voltaje de alimentacion del motor

fprintf(1,'Configurando voltaje de alimentacion del motor ...  ')

%fopen(sp)
fwrite(sp,'V','char');
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