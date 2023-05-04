function conf_avrg_adc(sp,adc_avrg)
%conf_avrg_adc configura el num de promediados del ADC)
% adc_avrg --> numero de promediados del ADC (uint8)

fprintf(1,'Configurando numero de promediados del ADC...  \n')

val = adc_avrg;
%fopen(sp)
fwrite(sp,'O','char');
fwrite(sp,val,'uint8');
val_r = fread(sp,1,'uint8');

%fclose(sp)

d = val ~= val_r;
ss = {'OK','ERROR'};
fprintf(1,'  Avrg. ADC = %d : %s\n',val_r,ss{double((d)>0)+1})
%pause(1)
end

