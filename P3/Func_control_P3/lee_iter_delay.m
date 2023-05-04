function lee_iter_delay(sp,iter_delay)
%lee_iter_delay lee el num de iteraciones del delay_n()
% iter_delay --> numero de iteraciones (uint32)

fprintf(1,'Leyendo numero de iteraciones del delay...  \n')

fwrite(sp,'l','char');
val_r = fread(sp,1,'uint32');

%fclose(sp)

fprintf(1,'   Num. iter. delay = %d : %s\n',val_r)
%pause(1)
end

