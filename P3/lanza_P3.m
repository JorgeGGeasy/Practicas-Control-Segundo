clear, clc%, close all
addpath('.\Func_control_P3')
tol = 1e-4;

%% Configurar puerto serie
puerto = 'COM3';
baudios = 115200;
sp = open_serial_port(puerto,baudios);

%% P2 Conf. control velocidad

% Velocidad de referencia
Vel_ref = 5; % rps

% Tipo de estímulo de entrada ('STEP' o 'RAMP')
tipo_entrada = 'RAMP' % 

% Periodo de muestreo del controlador
Tm = 0.01; %segundos

%% Control proporcional (P)
 %tipo_controlador = 'P';
 %K = 4;
 %Cz = K;

%% Control proporcional-integral (PI)
tipo_controlador = 'PI';
K = 4;
Ti = 100*Tm;
z_i = 1/(1+Tm/Ti);
Kpi = K/z_i;
Cz = zpk([z_i],[1],Kpi,Tm)

%% lanzar configuración del motor y activarlo
configura_motor

%% Sección: Modelo lineal
s = tf([1 0],1);

a = 1.6; % Polo dominante del motor
b = a*80; % 21 polo del motor (no dominante)
k = 3.6; % Ganancia del motor 
m = 1; % Retardo del sistema de control en numero de muestras
G = k*a/(s+a)*b/(s+b);
Gz = c2d(G,Tm)

% Función de transferencia en la linea directa
G_tot =  minreal(Cz*Gz);

% Funcion de transferencia en lazo cerrado (Gfb)
Gfb = minreal(G_tot/(1 + G_tot));

% Polos de la función Gfb
p_Gfb = pole(Gfb);


% Representación gráfica del diagrama de polos/ceros
close(figure (104))
fig = figure (104);
fig.Position = [550 550 400 400];
hold on

% Lugar de las raíces: rlocus
rlocus(G_tot)

% Dibujar contornos con zgrid 
zgrid
% Dibujar los polos
 plot(real(p_Gfb),imag(p_Gfb),'xm');

% Fijar ejes de la figura
axis([-1 1 -1 1])
hold off

%% Sección: Modelo no lineal

V_sat = 9.5; % Valor de saturación de salida
V_dead = 1; % Valor final de la zona muerta
k_nl = 3.6; % Factor de ajuste de ganancia


%% Simulacion con modelos
sim('modelo_motor_P3.slx')

