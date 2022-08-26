X1=importdata('./OUT.ris');
X=X1.data;
T=X(:,1);
GAM  = X(:,15);    % крен
PSI  = X(:,16);    % курс
TET  = X(:,17);    % тангаж
L=X(:,12); H=X(:,13); Z=X(:,14);
% plot(T,L,T,H,T,Z);
% legend('L','H','Z');
% plot(T,H);
% legend('H');
% grid on;
% grid minor;
% figure;
% plot(T,TET*180/pi,T,GAM*180/pi,T,PSI*180/pi);
% legend('\vartheta','\gamma','\psi');
% grid on;
% grid minor;
plot3(L,Z,H);
grid on;
grid minor;
