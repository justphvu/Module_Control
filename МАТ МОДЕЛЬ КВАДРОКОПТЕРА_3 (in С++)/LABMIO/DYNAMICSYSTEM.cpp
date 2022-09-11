#include "stdafx.h"

void FX(double DX[], double X[], double U[], double T)
{
	//задание коэффициентов передаточной функции системы
	double A = 1.0;
    double B = 2.0;
    double C = 3.0;
    double E = 0.2;
	
	/*здесь ставить систему дифф. уравнений вида
	DX[1]=f0(X,U,T)
	DX[2]=f1(X,U,T)
	....
	*/
	
	DX[0]=(C-B)/A*X[1]*X[2]-E/A*X[0];
	DX[1]=(A-C)/B*X[2]*X[0]-E/B*X[1];
	DX[2]=(B-A)/C*X[0]*X[1]-E/C*X[2];
}