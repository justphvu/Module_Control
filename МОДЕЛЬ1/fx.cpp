//
// Created by cyberlap3 on 15.08.22.
//

#include "stdafx.h"

void FX(double DX[], double X[], double U[], double T)
{
    // задание коэффициентов передаточной функции системы
    double Kt = 0.01;
    double Ra = 1.0;
    double Kb = 0.01;
    double La = 0.5;
    double B = 0.1;
    double J = 0.01;

    /*здесь ставить систему дифф. уравнений вида
	DX[1]=f0(X,U,T)
	DX[2]=f1(X,U,T)
	....
	*/

    DX[0] = (U[0] - Ra*X[0] - Kb*X[1])/La;
    DX[1] = (Kt*X[0] - B*X[1])/J;

    //    DX[0] = X[1];
    //    DX[1] = (Kt/(J*La))*U[0] - ((Ra/La) + B/(J*La))*X[1] - (((Ra*B)/(J*La)) + ((Kb*Kt)/(J*La)))*X[0];
}
