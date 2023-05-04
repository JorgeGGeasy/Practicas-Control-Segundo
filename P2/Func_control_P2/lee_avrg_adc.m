function lee_i_avrg_adc(sp,adc_avrg)
%lee_avrg_adc lee el num de promediados del ADC)
% adc_avrg --> numero de promediados del ADC (uint8)

fprintf(1,'Leyendo numero de promediados del ADC...  \n')

val = adc_avrg;
%fopen(sp)
fwrite(sp,'o','char');
fwrite(sp,val,'uint8');
val_r = fread(sp,1,'uint8');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
fprintf(1,'  Avrg. ADC = %d : %s\n',val_r,ss{double((d)>0)+1})
%pause(1)
end

