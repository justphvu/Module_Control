#include "stdafx.h"
void CONTROL(double X[],double U[],double U0[])
{
	double DU=0.0;
	double S=0.0;
	// приращение сигнала управления
	S=X[0];
	if (S>2.E00)
		S=2.E00;
	if (S<-2.E00)
		S=-2.E00;
	DU	 = kP*X[1]+kI*S+kD*X[2];
//	DU	 = kP*X[1]+kI*S+kD*X[3];
	U[0] = U0[0]+DU;
}