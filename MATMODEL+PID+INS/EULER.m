function [xnew,xd]= EULER(fx,time,dt,xx,u)
%% 1st call
[xd]=fx(xx,u,time);
xnew=xx+xd*dt;
end