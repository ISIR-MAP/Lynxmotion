% Modele geometrique direct:
function [U0]=ModeleGeom(th1,th2,th3,th4)
%% Initialisation:

T1=zeros(4);
T1(4,4)=1;
T1;
T2=T1;
T3=T1;
T4=T1;
T5=T1;
D3=10;
D4=20;

%% T1:

T1(1,1)=cos(th1);
T1(1,2)=-sin(th1);
T1(2,1)=sin(th1);
T1(2,2)=cos(th1);
T1(3,3)=1;


%% T2:

T2(1,1)=cos(th2);
T2(1,3)=-sin(th2);
T2(3,1)=sin(th2);
T2(3,3)=cos(th2);
T2(2,2)=-1;


%% T3:

T3(1,1)=cos(th3);
T3(1,2)=-sin(th3);
T3(1,4)=D3*cos(th3);
T3(2,1)=sin(th3);
T3(2,2)=cos(th3);
T3(2,4)=D3*sin(th3);
T3(3,3)=1;

%% T4:

T4(1,1)=cos(th4);
T4(1,2)=-sin(th4);
T4(1,4)=D4*cos(th4);
T4(2,1)=sin(th4);
T4(2,2)=cos(th4);
T4(2,4)=D4*sin(th4);
T4(3,3)=1;






U3=T4;
U2=T3*U3;
U1=T2*U2;
U0=T1*U1;
end




