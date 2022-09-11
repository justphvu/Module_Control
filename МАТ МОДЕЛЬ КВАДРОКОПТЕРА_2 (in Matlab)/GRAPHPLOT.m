X1=importdata('OUT.ris');
X=X1.data;
T=X(:,1);
I = X(:,2);
W = X(:,3);
U = X(:,4);
plot(T, I, T, W, T, U);
legend('I','W','U');
grid on;
grid minor;

