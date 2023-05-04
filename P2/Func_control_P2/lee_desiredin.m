function lee_desiredin(sp)
%lee_directin lee el valor de la variable direct

fprintf(1,'Leyendo entrada deseada ...  ')

    %fopen(sp)

    fwrite(sp,'r','char');
    val_r = fread(sp,1,'float');

    fprintf('\n')
    fprintf(['     val = %2.3f  \n'],val_r)


    %fclose(sp)
end