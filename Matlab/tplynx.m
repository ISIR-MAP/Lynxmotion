% TP.m 
% Contrôle d'un robot à base de moteurs DYNAMIXEL

%clear all; clc;

%%  Initialization
COM = 'COM4';          % COM number
% Constructor call
robot = lynx(COM);

%% Votre code

% Quelques exemples :

robot.setPosSpeed(COM,2,1200,750)
robot.setPostime(COM,2,1800,10000)


for i=1:10;
robot.setMultiplePosSpeed(COM,[0,1,2,3,4,5],[1500,1500,1500,1000+50*i,1500,1500],[1000,1000,1000,1000,1000,1000]);
pause(0.5)
end


%Modele Geometrique
D=ModeleGeom(0,3.14,1.57,3.14);
D2=ModeleGeom(0,0,0,pi/4);






