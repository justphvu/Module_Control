function [X] = MODELING(X0, U0, TF, DT)
    fOUT = fopen('OUT.ris', 'wt');
    fprintf(fOUT,'TIME I W S U\r\n');
    format = '%f %f %f %f %f\n';

    TIME=0;

    X=X0;
    U=U0;

    Xd=[60];

    f=@(X,U,TIME)FX(X,U,TIME);

    while (TIME<TF)
        [X,DX]=RK4(f,TIME,DT,X,U);
        fprintf(fOUT,format,TIME,X,U);
        [U]=CONTROL(U0,X,Xd,TIME);
        TIME=TIME+DT;
    end
end
