%% люрпхжю мюопюбкъчыху яняхмсянб дкъ оепебндю бейрнпю хг яяй б цяй
function [Cbg]=C_bg(TET,PSI,GAM)

    Cbg(1,1)= cos(TET)*cos(PSI);
    Cbg(2,1)= sin(TET);
    Cbg(3,1)= -cos(TET)*sin(PSI);

    Cbg(1,2)= -sin(TET)*cos(GAM)*cos(PSI)+sin(GAM)*sin(PSI);
    Cbg(2,2)= cos(TET)*cos(GAM);
    Cbg(3,2)= sin(GAM)*cos(PSI)+sin(TET)*cos(GAM)*sin(PSI);

    Cbg(1,3)= sin(TET)*sin(GAM)*cos(PSI)+cos(GAM)*sin(PSI);
    Cbg(2,3)= -cos(TET)*sin(GAM);
    Cbg(3,3)= cos(GAM)*cos(PSI)-sin(TET)*sin(GAM)*sin(PSI);
end
