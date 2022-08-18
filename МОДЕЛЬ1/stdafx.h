//
// Created by cyberlap3 on 15.08.22.
//

#ifndef INC_1_STDAFX_H
#define INC_1_STDAFX_H

#include <iostream>

//параметры временные
extern double TIME,DT;
//количество параметров состояния и управления
extern int N,M;

//прототип функции, описывающей систему дифф. уравнений
typedef void (*FUNC_FX)(double[],double[],double[],double);

//функция управления
void CNTRL(int M,double U[],double T);

//функция движения объекта
void FX(double DX[], double X[], double U[], double T);
//1 шаг интегрирования по методу Рунге-Кутта
void RKS(int N,double DT, double& TIME, double DX[], double X[], double U[], FUNC_FX fFX);

// //функции минимизации критерия по методу вращающихся координат
// //генератор белого шума
// double GAUSS();
// //вычисление МО и СКО
// void STATIS(double x[], int n, double &MO, double &SKO, int k, double R[]);
// //формирующий фильтр
// void FFILTER(double DF[], double F[], double PAR[], double Q=0.0);


//подпрограмма моделирования
void MODELING();


#endif //INC_1_STDAFX_H
