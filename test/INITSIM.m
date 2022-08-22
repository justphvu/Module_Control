
function [PARAM, Xzad]=INITSIM()
    PARAM.Ra    = 1.0;
    PARAM.La    = 0.5;
    PARAM.J     = 0.01;
    PARAM.B     = 0.1;
    PARAM.Lq    = 0.3;

    PARAM.kT    = 0.01;
    PARAM.kB    = 0.01;

    Xzad = zeros(1, 3);
end
