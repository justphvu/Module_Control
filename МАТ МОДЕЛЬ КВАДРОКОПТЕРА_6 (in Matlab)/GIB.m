function [ACEL_OUT,GYRO_OUT]=GIB(ACEL_IN,GYRO_IN)
    x=1;y=2;z=3;
    ACEL_OUT(x)=ACEL_IN(x);
    ACEL_OUT(y)=ACEL_IN(y);
    ACEL_OUT(z)=ACEL_IN(z);
    GYRO_OUT(x)=GYRO_IN(x);
    GYRO_OUT(y)=GYRO_IN(y);
    GYRO_OUT(z)=GYRO_IN(z);
end