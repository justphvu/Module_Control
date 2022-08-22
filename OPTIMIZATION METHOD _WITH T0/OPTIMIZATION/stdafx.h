// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#include "targetver.h"
#include <ctime>
//#include <windows.h>
#include <iostream>
//#include <tchar.h>
#include <cmath>
#include <iomanip>
#include <fstream>
#include <curses.h>
#include <cstdio>
#include <cstdlib>
#include <clocale>


// TODO: reference additional headers your program requires here
extern FILE *fout;
extern double kP,kI,kD;
extern double XMAX[5],XMIN[5];
//прототип функции критерия
typedef double(*Func_FCT)(double[]);
//прототип функции, описывающей систему дифф. уравнений
typedef void (*FUNC_FX)(double[],double[],double[],double);
double FCT(double X[]);
void FX(double DX[], double X[], double U[], double T);
void RKS(int N,double DT, double& TIME, double DX[], double X[], double U[], FUNC_FX fFX);
//функции минимизации критерия по методу вращающихся координат
void WRK50(double VAR[], int N);
void MODELING(double K[]);
void CONTROL(double X[],double U[],double U0[]);