#include "stdafx.h"
void CONTROL(double X[],double U[],double U0[])
{
	double DU=0.0;
	double S=0.0;
	// приращение сигнала управления
	S=X[0];
	if (S>20)
		S=20.0;
	if (S<-20)
		S=-20.0;
	DU	 = kP*X[1]+kI*S+kD*X[2];
	U[0] = U0[0]+DU;
}