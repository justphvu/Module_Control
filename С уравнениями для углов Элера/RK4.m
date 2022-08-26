function [xnew,xd]= RK4(fx,time,dt,xx,u)
%% 1st call
[xd]=fx(xx,u,time);
xnew=xx+xd*dt;
end
function [xnew,xd]= RK41(fx,time,dt,xx,u)
%% 1st call
[xd]=fx(xx,u,time);
xa=xd*dt;
x=xx+0.5*xa;
t=time+0.5*dt;
%% 2nd call
[xd]=fx(x,u,t);
q=xd*dt;
x=xx+0.5*q;
xa=xa+2.0*q;
%% 3rd call
[xd]=fx(x,u,t);
q=xd*dt;
x=xx+q;
xa=xa+2*q;
time=time+dt;
%% 4th call
[xd]=fx(x,u,time);
xnew=xx+(xa+xd*dt)/6.0;
end



