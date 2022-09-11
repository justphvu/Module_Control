#include "stdafx.h"

//объявление и инициализация глобальных переменных
int N=0,M=0;
double TIME=0.0,DT=0.0;

void MODELING()
{
	//файл вывода
	FILE *fOUT;
	//создание и открытие для записи
	fOUT=fopen(".\\RESULT\\OUT.ris","w");	
	
	// инициализация параметров моделирования
	N=3;	//число параметров состояния	
	M=1;	//число сигналов управления	
	DT=0.1;	//шаг интегрирования
	
	//время моделирования
	double TMODEL=1.0;

	// объявление вектора состояния X(N)
	double* X = new double [N]; 
	// объявление вектора состояния X(N)
	double* DX = new double [N]; 
	//объявление сигнала управления
	double* U = new double [M]; 

	//инициализация начального состояния системы
	X[0]=1.0;
	X[1]=1.0;
	X[2]=0.0;

	//формат печати результатов: fprintf(fOUT,"U1 U2 ...Um X0 X1 X2 ... Xn");
	fprintf(fOUT,"U X0 X1 X2");	

	// цикл моделирования
	do
	{	
		//сигналы управления
		CNTRL(M,U,TIME);

		//печать результатов
		fprintf(fOUT,"\n%f ",TIME);		//время
		for (int i=0;i<M;i++)
			fprintf(fOUT,"%f ",U[i]);	//вектор управления	
		for (int i=0;i<N;i++)
			fprintf(fOUT,"%f ",X[i]);	//вектор состояния
		
		//интегрирование (1 шаг)
		RKS(N,DT,TIME,DX,X,U,FX);

	}while (TIME<TMODEL);
}