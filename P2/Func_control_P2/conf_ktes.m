function conf_ktes(sp,Kp,Kd,Ki,Kn,Tf,Nder,maxSum,display)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

fprintf(1,'Configurando coeficientes ...  ')

%fopen(sp)
fwrite(sp,'@','char');
K = single([Kp Kd Ki Kn Tf Nder maxSum]);
K_r = single(zeros(1,length(K)));
for j =1:length(K)
    K_32 = typecast(K(j), 'uint32');
    for i=0:4:28
        var_nibble = bitshift(K_32,-i);
        var_nibble = bitand(var_nibble,uint32(15));
        fwrite(sp,uint8(var_nibble),'uint8');
    end
     K_r(j) = fread(sp,1,'float');
end

%fclose(sp)

d = K ~= K_r;
ss = {'OK','ERROR'};
if display == 1
    fprintf('\n')
    kk = {'Kp','Kd','Ki','Kn','Tf','Nder','maxSum'};
    for i = 1:length(K)
        fprintf(['    %s = %2.3f  (%s) \n'],kk{i},K_r(i),ss{d(i)+1})
    end
else
    fprintf('%s\n',ss{double(sum(d)>0)+1})
end
%pause(1)
end

