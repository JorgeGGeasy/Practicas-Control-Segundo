function lee_supplyvolt(sp)
%lee_supplyvolt lee el valor del voltaje de alimentacion del motor

fprintf(1,'Leyendo voltaje de alimentacion del motor ...  ')

    %fopen(sp)

    fwrite(sp,'v','char');
    val_r = fread(sp,1,'float');

    fprintf('\n')
    fprintf(['     val = %2.3f  \n'],val_r)


    %fclose(sp)
end