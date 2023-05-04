function conf_start(sp)
%conf_start pone a cero el acumulador y pone en marcha el lazo

fprintf(1,'Configurando start ...  ')
val = 1;
%fopen(sp)
fwrite(sp,'S','char');
fwrite(sp,val,'char');
val_r = fread(sp,1,'char');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
fprintf(1,'%s\n',ss{double((d)>0)+1})
%pause(1)
end

