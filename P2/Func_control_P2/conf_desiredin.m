function conf_desiredin(sp,val_ref,t_ref,display)
%conf_directin escribe el valor de la variable direct
% direct es la entrada directa al motor

fprintf(1,'Configurando entrada deseada ...  ')

%fopen(sp)
fwrite(sp,'R','char');
fwrite(sp,val_ref,'float');
val_ref_r = fread(sp,1,'float');
fwrite(sp,t_ref,'float');
t_ref_r = fread(sp,1,'float');
%fclose(sp)

d = val_ref ~= val_ref_r;
ss = {'OK','ERROR'};
if display == 1
    fprintf(1,'\n')
    fprintf(1,['     val_ref_r = %2.3f  (%s) \n'],val_ref_r,ss{d+1})
else
    fprintf(1,'%s\n',ss{double((d)>0)+1})
end
d = t_ref ~= round(t_ref_r*1e3)*1e-3;
ss = {'OK','ERROR'};
if display == 1
    %fprintf(1,'\n')
    fprintf(1,['     t_ref_r = %2.3f  (%s) \n'],t_ref_r,ss{d+1})
else
    fprintf(1,'%s\n',ss{double((d)>0)+1})
end
%pause(1)
end