X1=importdata('./TLM/OUT.ris');
X=X1.data;
T=X(:,1);
GAM  = X(:,8);    % крен
PSI  = X(:,9);    % курс
TET  = X(:,10);    % тангаж
H=X(:,12);
plot(T,H);
grid on;
grid minor;
figure;
plot(T,TET*180/pi,T,GAM*180/pi,T,PSI*180/pi);
legend('vartheta','gamma','psi');
grid on;
grid minor;
