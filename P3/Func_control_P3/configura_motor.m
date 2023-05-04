%clear
%clc

fopen(sp)

%% Datos de configuracion
% Volt. de referencia
Vref = 12; % Volts
% CAptura de datos
max_datos = 200;
diezm_display = 1;
% Conf. periodo de muestreo
timer_div = 80;
timer_alarm = 10000;
Ts = (timer_div*timer_alarm)/80e6;
% Conf. Frecuencia del PWM
pwm_frec = 80e6/(timer_div*timer_alarm);

% Input mode (0 --> Escalon; 1 --> Potenciometro)
input_mode = 0;

% Promediados ADC
adc_avrg = 1;

% parametro retardo ADC
iter_delay = 1;

% Feedback mode (0-> FB de angulo; 1-> FB de velocidad)
fb_mode = 1; 

% Activar PID
pid_on = 1

%% Conf control angulo
if fb_mode == 0
    desired = 90; % Grados
    n_samp_desired = 1;
%     Kp = 1; %1.4
%     Ti = 2e3*Ts;
%     Td = 0*Ts; % 

    Kn = 1;
    direct = 0; % entre 0 y Vcc_motor (12v)
    % Control integral
    maxSum = 100;
    % Control derivativo
    Filtro_der_si = 0; % 1-> filtro derivativo; 0-> sin filtro
    Nder = 10; % #muestras para aproximar la derivada
    Tf = 5*Ts;
    Kd = Kp*Td;
    Ki = Kp/Ti; %5
    % NO CAMBIAR
    desired = desired*pi/180;
    if pid_on == 0
        Kp = 0;
        Ki = 0;
        Kd = 0;
        direct = Vdirect/desired;
        %direct = 1.53
    end
end
%% Conf. control velocidad
%pid_on = 0
%Vdirect =1.7
Volt_in = 0;
if fb_mode == 1
    Vdirect = Volt_in;
    desired = Vel_ref; % rps
    switch true
        case (strcmpi(tipo_entrada,'STEP') || strcmpi(tipo_entrada,'step'))
            n_samp_desired = 1; %500
        case (strcmpi(tipo_entrada,'RAMP') || strcmpi(tipo_entrada,'ramp'))
            n_samp_desired = round(max_datos);
        otherwise
            n_samp_desired = 1;
    end
    %Kp = 3; %3
    %Ti = 50e9*Ts; % 20
    %Td = 0*Ts;
    %Kp = 0;
    
%     Ti = inf*Ts;
%     Td = 0;
%     Kd = Kp*Td;
%     Ki = Kp/Ti; 
    switch true
        case (strcmpi(tipo_controlador,'P'))
            z_i = 1;
            z_d = 0;
        case (strcmpi(tipo_controlador,'PI'))
            z_d = 0;
        case (strcmpi(tipo_controlador,'PD'))
            z_i = 1;
        otherwise
    end   
    Kd = K*z_d*z_i;
    Kp = (K*(z_d+z_i)-2*Kd);
    Ki = K-Kp-Kd;

    Kd = Kd*Tm;
    Ki = Ki/Tm;
    
    Kn = 1;
    direct = 0; % entre 0 y Vcc_motor (12v)
     % Control integral
    maxSum = 100;
    % Control derivativo
    Filtro_der_si = 0; % 1-> filtro derivativo; 0-> sin filtro
    Nder = 1; % #muestras para aproximar la derivada
    Tf = 0*Ts;
    if pid_on == 0
        Kp = 0;
        Ki = 0;
        Kd = 0;
        direct = Vdirect/desired;
        %direct = 1.53
    end
end

%% Calculos
desired_ini = 0;
VmTs = (desired-desired_ini)/n_samp_desired;


%% Configurar 
clc
conf_timer(sp,timer_div,timer_alarm,1)
% leeconf_timer(sp)

% Frecuencia PWM
conf_pwm_frec(sp,pwm_frec)

% Promediados ADC
conf_avrg_adc(sp,adc_avrg)

% parameto retardo ADC
conf_iter_delay(sp,iter_delay)

% Configura input mode
conf_input_mode(sp,input_mode)


% Configura el tipo de feedback
conf_feedback_mode(sp,fb_mode)
%lee_feedback_mode(sp)

% Ktes Kp,Kd,Ki,Kn
conf_ktes(sp,Kp,Kd,Ki,Kn,Tf,Nder,maxSum,1)
%lee_ktes(sp)

conf_desiredin(sp,VmTs,n_samp_desired*Ts,1)
%lee_desiredin(sp)

conf_directin(sp,direct,1)
%lee_directin(sp)

conf_dispdatmax(sp,max_datos,1)
%lee_dispdatmax(sp)

conf_diezmadisplay(sp,diezm_display,1)
%lee_diezmadisplay(sp)

conf_supplyvolt(sp,Vref,1)
%lee_supplyvolt(sp)

conf_start(sp)
display('############################################')
display(['Tiempo de funcionamiento : ' num2str(max_datos * diezm_display * Ts, '%2.3f') ' seg'])
display('############################################')
prompt = 'Pulse intro para comenzar ';
%input(prompt)
%% Adquisición de resultados
y1 = zeros(1,max_datos)-1;
y2 = zeros(1,max_datos)-1;
y3 = zeros(1,max_datos)-1;
y4 = zeros(1,max_datos)-1;
y5 = zeros(1,max_datos)-1;
y6 = zeros(1,max_datos)-1;
y7 = zeros(1,max_datos)-1;
y8 = zeros(1,max_datos)-1;
y9 = zeros(1,max_datos)-1;

for i = 1:max_datos
   %y1(i) = fread(sp,1,'int'); % Contador
    y2(i) = fread(sp,1,'float'); % directa
    
    y3(i) = fread(sp,1,'float'); % Angulo feedback
    y4(i) = fread(sp,1,'float'); % Referencia
    y5(i) = fread(sp,1,'float'); % Error
    y6(i) = fread(sp,1,'float'); % Cp
    y7(i) = fread(sp,1,'float'); % Ci 
    y8(i) = fread(sp,1,'float'); % Cd
    y9(i) = fread(sp,1,'float'); % vmotor
 %   plot(1:max_datos,y1(1:max_datos),'+',1:max_datos,y2(1:max_datos),'*')
 %       linkdata on
 %   axis(a)
    
end

if fb_mode == 0
    y3 = y3*180/pi;
    y4 = y4*180/pi;
end
% figure (101)
% a = axis;
% a = [0 max_datos 0 255];
% axis(a)
% plot(1:max_datos,y1(1:max_datos),'+',1:max_datos,y2(1:max_datos),'*')
% grid

%% Representación gráfica
eje_t = (0:max_datos-1) * diezm_display * Ts;
fig = figure (102);
fig.Position = [50 550 400 400];
fig.Color = 'white';
a = [0 (max_datos-1)*Ts 0 4095];
t_plot = 0:diezm_display*Ts:(diezm_display*max_datos-1)*Ts;
axis(a)
subplot(2,1,1)
plot(eje_t,y4(1:max_datos),eje_t,y3(1:max_datos))
grid
legend('Referencia','Generada')
if fb_mode == 1
    ylabel('Velocidad (rps)')
else
    ylabel('Angulo (º)')
end
xlabel('t (seg)')
subplot(2,1,2)
plot(eje_t,y5(1:max_datos))
grid
xlabel('t')
if fb_mode == 1
    ylabel('Error velocidad (rps)')
else
    ylabel('Error angulo (º)')
end
xlabel('t (seg)')
%linkdata off
%pause(2)
fclose(sp)

fig = figure (103);
fig.Position = [50 50 400 400];
fig.Color = 'white';
subplot(4,1,1)
delay_s = 1;
plot(eje_t(delay_s:end),y9(delay_s:max_datos))
ylabel('v\_motor')
xlabel('t (seg)')
grid
subplot(4,1,2)
plot(eje_t(delay_s:end),y6(delay_s:max_datos))
ylabel('Cp')
xlabel('t (seg)')
grid
subplot(4,1,3)
plot(eje_t(delay_s:end),y7(delay_s:max_datos))
ylabel('Ci')
xlabel('t (seg)')
grid
subplot(4,1,4)
plot(eje_t(delay_s:end),y8(delay_s:max_datos))
ylabel('Cd')
xlabel('t (seg)')
grid

%%
Lt = length(eje_t);
r_in = Vdirect*ones(1,Lt);
salida_motor = y3;
T_end = eje_t(end);

Vel_final = round(mean(y3(end-50:end))*100)/100;
Error_vel_final = round(100*(Vel_ref-mean(y3(end-50:end)))/Vel_ref*100)/100;
display('#####################################')
display(['## Velocidad final = ' num2str(Vel_final) ' rps'])
display(['## Error velocidad final = ' num2str(Error_vel_final) ' %'])
display('#####################################')