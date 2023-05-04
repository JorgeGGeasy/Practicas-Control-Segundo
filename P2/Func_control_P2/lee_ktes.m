function lee_ktes(sp)
%lee_ktes lee los valores de configuracion de Kp, Kd y Ki


    fprintf(1,'Leyendo ktes ...  ')

    fopen(sp)
    fwrite(sp,'a','char');
    K_r = single([0 0 0 0]);
    for j =1:4
        K_r(j) = fread(sp,1,'float');
    end

    fclose(sp)
    fprintf('\n')
    kk = {'Kp','Kd','Ki','Kn'};
    for i = 1:4
        fprintf(['    %s = %2.3f   \n'],kk{i},K_r(i))
    end
end