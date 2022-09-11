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
#include <clocale>

//��������� ���������
extern double TIME,DT;
//���������� ���������� ��������� � ����������
extern int N,M;

//�������� �������, ����������� ������� ����. ���������
typedef void (*FUNC_FX)(double[],double[],double[],double);

//������� ����������
void CNTRL(int M,double U[],double T);
//������� �������� �������
void FX(double DX[], double X[], double U[], double T);
//1 ��� �������������� �� ������ �����-�����
void RKS(int N,double DT, double& TIME, double DX[], double X[], double U[], FUNC_FX fFX);
//������� ����������� �������� �� ������ ����������� ���������
//��������� ������ ����
double GAUSS();
//���������� �� � ���
void STATIS(double x[], int n, double &MO, double &SKO, int k, double R[]);
//����������� ������
void FFILTER(double DF[], double F[], double PAR[], double Q=0.0);
//������������ �������������
void MODELING();
