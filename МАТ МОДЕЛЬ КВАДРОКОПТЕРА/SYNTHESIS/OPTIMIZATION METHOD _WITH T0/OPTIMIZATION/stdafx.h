// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#include "targetver.h"
#include <time.h>
#include <windows.h>
#include <iostream>
#include <tchar.h>
#include <math.h>
#include <iomanip>
#include <fstream>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <clocale>


// TODO: reference additional headers your program requires here
extern FILE *fout;
extern double kP,kI,kD;
extern double YDES;
extern double XMAX[5],XMIN[5];
//�������� ������� ��������
typedef double(*Func_FCT)(double[]);
//�������� �������, ����������� ������� ����. ���������
typedef void (*FUNC_FX)(double[],double[],double[],double);
double FCT(double X[]);
void FX(double DX[], double X[], double U[], double T);
void RKS(int N,double DT, double& TIME, double DX[], double X[], double U[], FUNC_FX fFX);
//������� ����������� �������� �� ������ ����������� ���������
void WRK50(double VAR[], int N);
void MODELING(double K[]);
void CONTROL(double X[],double U[],double U0[]);