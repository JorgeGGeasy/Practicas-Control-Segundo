function conf_iter_delay(sp,iter_delay)
%conf_iter_delay configura el num de iteraciones del delay_n()
% iter_delay --> numero de iteraciones (uint32)

fprintf(1,'Configurando numero de iteraciones del delay...  \n')

val = iter_delay;
%fopen(sp)
fwrite(sp,'L','char');
fwrite(sp,val,'uint32');
val_r = fread(sp,1,'uint32');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
fprintf(1,'   Num. iter. delay = %d : %s\n',val_r,ss{double((d)>0)+1})
%pause(1)
end

