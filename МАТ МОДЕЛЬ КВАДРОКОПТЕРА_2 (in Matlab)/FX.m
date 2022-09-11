function [DX] = FX(X, U, TIME)
    global  PARAM

    kT = PARAM.kT;   % Motor torque constant
    kB = PARAM.kB;   % Back emf constant

    Ra = PARAM.Ra;   % Armature resistance
    La = PARAM.La;   % Armature inductance

    B = PARAM.B;     % Friction conefficient
    J = PARAM.J;     % Mechanical inertia

    %%
    %
    % xd = (kT/(J*La))*U - ((Ra/La) + B/(J*La))*X(2) - (((Ra*B)/(J*La)) + ((kB*kT)/(J*La)))*X(1);
    DI = (U(1) - Ra*X(1) - kB*X(2))/La;

    DW = (kT*X(1) - B*X(2))/J;

    %%
    DX = [DI DW];
end

