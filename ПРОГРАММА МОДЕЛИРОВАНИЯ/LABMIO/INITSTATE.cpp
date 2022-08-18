#include "stdafx.h"

//объ€вление и инициализаци€ глобальных переменных
int N = 0, M = 0;
double TIME = 0.0, DT = 0.0;
double X_GLOBAL[10] = { 0.0 };

void INITSTATE(double X0[], double V0, double THETA0, double H0, double DRGR0, double DELEV0, double ALP0)
{
	//инициализаци€ начального состо€ни€ система
	X0[0] = V0; // V    
	X0[1] = 0.0; // Wz
	X0[2] = 0.0; // ”гол тангажа
	X0[3] = THETA0; // ”гол наклона траектории 
	X0[4] = H0; // H
	X0[5] = 0.0; // L
	X0[6] = DRGR0;
	X0[7] = DELEV0;
	X0[2] = X0[3] + ALP0;

}