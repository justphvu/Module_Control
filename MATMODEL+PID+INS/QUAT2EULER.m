function [TET,GAM,PSI]=QUAT2EULER(Q)
    Q0=Q(1); Q1=Q(2); Q2=Q(3); Q3=Q(4);
    TET=asin(2*Q1*Q2+2*Q0*Q3);
    GAM=atan(-(2*Q2*Q3-2*Q0*Q1)/(2*Q0^2+2*Q2^2-1));
    PSI=atan(-(2*Q1*Q3-2*Q0*Q2)/(2*Q1^2+2*Q0^2-1));
    TET=TET*180/pi;
    GAM=GAM*180/pi;
    PSI=PSI*180/pi;
end