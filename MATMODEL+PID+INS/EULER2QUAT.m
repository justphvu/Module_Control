function [q]=EULER2QUAT(TET,GAM,PSI)
    q0=cos(0.5*PSI)*cos(0.5*TET)*cos(0.5*GAM)-sin(0.5*PSI)*sin(0.5*TET)*sin(0.5*GAM);
    q1=cos(0.5*PSI)*cos(0.5*TET)*sin(0.5*GAM)+sin(0.5*PSI)*sin(0.5*TET)*cos(0.5*GAM);
    q2=sin(0.5*PSI)*cos(0.5*TET)*cos(0.5*GAM)+cos(0.5*PSI)*sin(0.5*TET)*sin(0.5*GAM);
    q3=cos(0.5*PSI)*sin(0.5*TET)*cos(0.5*GAM)-sin(0.5*PSI)*cos(0.5*TET)*sin(0.5*GAM);
    q=[q0;q1;q2;q3];
end