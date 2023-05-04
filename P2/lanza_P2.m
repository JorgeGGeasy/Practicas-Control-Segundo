clear, clc
addpath('.\Func_control_P2')

%% Configurar puerto serie
puerto = 'COM3';
baudios = 115200;
sp = open_serial_port(puerto,baudios);

%% P1 Conf. control velocidad

% Velocidad de referencia
Vel_ref = 5; % rps

% Voltaje aplicado al motor
Volt_in = 1.45; % Volts
% Volts lineal 1.45

%% lanzar configuración del motor y activarlo
configura_motor

%% Sección B: Modelo lineal

% Periodo de muestreo del controlador
Tm = 0.01; %segundos

% Variable Laplace
s = tf([1 0],1);

a = 1.6; % Polo del motor
k = 3.6; % Ganancia del motor 
G = k*a/(s+a);
Gz = c2d(G,Tm);

% Retardo
m = 3;

%% Sección D: Modelo no lineal I

% Valor de saturación de salida
Vel_sat = 9.5;

% Valor final de la zona muerta
Volt_dead =1;

% Factor de ajuste de ganancia
k_nl = 3.6;

%% Sección D: Modelo no lineal II
Volt = [0.25 0.5 0.75 1 2 3 4 5 6 7 8 9];
Vel = [0 0 1 3.2 6.9 8.3 9 9 9.5 9.5 9.9 10];


%% Simulacion con modelos
%sim('modelo_motor_P2.slx') % Secciones B, C y D

sim('modelo_motor_P2_LUT.slx') % Sección E

