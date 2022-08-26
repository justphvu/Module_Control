X1=importdata('OUT.ris');
X=X1.data;
T=X(:,1);
U = X(:,2);
I = X(:,3);
W = X(:,4);
S = X(:,6)*180/pi;
plot(T, S);
% legend('S');
grid on;
grid minor;

