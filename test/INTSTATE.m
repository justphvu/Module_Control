function [X0, U0] = INTSTATE(Xzad)
    U = 200.0;
    I = Xzad(1);
    W = Xzad(2);
    S = Xzad(3);

    X0 = [I, W, S];
    U0 = [U];
end
