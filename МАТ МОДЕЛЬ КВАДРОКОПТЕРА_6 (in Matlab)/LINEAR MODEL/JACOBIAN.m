%% Вычисление матрицы Jacobian
function [ A, B, C] = JACOBIAN(X0, U0) 
    
    A = jacobian_A( X0, U0 );
    B = jacobian_B( X0, U0 );
    C = jacobian_C( X0, U0 );
end