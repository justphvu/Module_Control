%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   fdu.m                          %%
%%                                                  %%
%%  Author : Ying Huo                               %%
%%                                                  %%
%% This is to approximate the partial derivative    %%
%% of f w.r.t. control by computing the difference  %% 
%% of the state derivative, i.e. f(state, control)  %%
%% w.r.t.control at (control+du) and (control-du).  %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  dfdu = fdu( x, u, i, j, du )

    time = 0.0;
    t = u(j);
    u(j) = t - du;  
    [ x_dot] = FX(x,u,time);
    xd1 = x_dot(i);       
    u(j) = t + du;  
    [ x_dot ] = FX(x,u,time);
    xd2 = x_dot(i);       
    dfdu = ( xd2 - xd1 ) / ( du + du ); 
    control(j) = t;       % return to original control(j)
end
