/*СТАТИСТИКА*/
#include "stdafx.h"

//генератор белого шума
double GAUSS()
{
	double ran=0.0;
	for (int i=1;i<=12;i++)
		ran+=(1 - (1-0)*((double)rand()/32768));;        
	ran-=6.0;
	return ran;
}//end GAUSS

//вычисление МО и СКО
void STATIS(double x[], int n, double &MO, double &SKO, int k, double R[])
{
	//локальная переменная
	double SUM=0.0;
	
//1. вычисление МО 
	//сумма всех реализаций СП
	for (int i = 0; i < n; i++)
		SUM += x[i];
	//математическое ожидание
	MO = SUM / n;

//2. вычисление СКО	
	//обнулить переменную для вычисления СКО
	SUM = 0.0;
	//сумма всех центрированных значений
	for (int i = 0; i <n; i++)
		SUM += pow(x[i] - MO, 2.0);		
	//СКО
	SKO = pow(SUM / n, 0.5);
	
//3. вычисление корреляционной функции
	SUM=0.0;
	for (int j=0;j<=k;j++)
	{
		for (int i=0;i<n-j;i++)
			SUM+=(x[i]-MO)*(x[i+j]-MO);
		//корреляционная функция со смещением k
		R[j]=SUM/(n-j+1);
		//обнулить переменную для нового вычисления
		SUM=0.0;
	}	
}//end STATIS

//формирующий фильтр
void FFILTER(double DF[], double F[], double PAR[], double Q)
{
	//коэффициенты передаточной функции фильтра
	double k=PAR[0], b0=PAR[1], b1=PAR[2];
	double xi=GAUSS();
	//дифферценциальные уравнения фильтра
	DF[0]= (k*xi- b0*F[0])/b1;	
}//end FFILTER