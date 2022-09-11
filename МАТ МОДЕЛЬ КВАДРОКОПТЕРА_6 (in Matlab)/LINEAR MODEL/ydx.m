%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   ydx.m                          %%
%%                                                  %%
%%  Author : Ying Huo                               %%
%%                                                  %%
%% This is to approximate the partial derivative    %%
%% of output y w.r.t. state by computing the        %%
%% difference of the output y(state, control)       %%
%% w.r.t. state at (state+dx) and (state-dx).       %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  dydx = ydx( x, u, i, j, dx )

% y = [ an; q; alpha ];

time = 0.0;
t = x(j);
x(j) = t - dx;  
[ x_dot ] = FX(x,u,time);
y = [x(1);x(2);x(6);x(11);x_dot(1)];
y1 = y(i);      
x(j) = t + dx;  
[ x_dot ] = FX(x,u,time);
y = [x(1);x(2);x(6);x(11);x_dot(1)];
y2 = y(i);      
dydx = ( y2 - y1 ) / ( dx + dx ); 
x(j) = t;       % return to original x

