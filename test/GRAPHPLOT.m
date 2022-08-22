X1=importdata('OUT.ris');
X=X1.data;
T=X(:,1);
I = X(:,2);
W = X(:,3);
S = X(:,4);
U = X(:,5);
plot(T, I, T, W, T, S, T, U);
legend('I','W','S','U');
grid on;
grid minor;

