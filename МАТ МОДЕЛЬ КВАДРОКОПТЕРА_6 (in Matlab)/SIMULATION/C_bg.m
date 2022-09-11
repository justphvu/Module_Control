%% Ã¿“–»÷¿ œŒ¬Œ–Œ“¿

function [Cbg]=C_bg(TET,PSI,GAM)
    
    Cgb=zeros(3,3);

    Cgb(1,1)= cos(TET)*cos(PSI);
    Cgb(1,2)= sin(TET);
    Cgb(1,3)= -cos(TET)*sin(PSI);

    Cgb(2,1)= -sin(TET)*cos(GAM)*cos(PSI)+sin(GAM)*sin(PSI);
    Cgb(2,2)= cos(TET)*cos(GAM);
    Cgb(2,3)= sin(GAM)*cos(PSI)+sin(TET)*cos(GAM)*sin(PSI);

    Cgb(3,1)= sin(TET)*sin(GAM)*cos(PSI)+cos(GAM)*sin(PSI);
    Cgb(3,2)= -cos(TET)*sin(GAM);
    Cgb(3,3)= cos(GAM)*cos(PSI)-sin(TET)*sin(GAM)*sin(PSI);
    
    Cbg=Cgb';
end
