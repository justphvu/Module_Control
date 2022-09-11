// OPTIMIZATION.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

int _tmain(int argc, _TCHAR* argv[])
{
	// файл для записи
	fout = fopen(".\\RESULT\\RES_OPT.ris", "w");
	// искомые переменные
	double K[5] = {0.0};
	// модуль градиента
	double EPS=1.E-6;
	// число переменных
	int N = 3;

	// начальное значение искомых переменных (начальное приближенное решение)
	K[0]=1.0E-1;
	K[1]=1.0E-1;
	K[2]=1.0E-1;
	
	// ограничения на коэффициенты
	for (int i=0;i<4;i++)
	{
		XMAX[i]=10.0;
		XMIN[i]=-10.0;
	}
	// оптимизация

	WRK50(K,N);
	// печать результатов
	fprintf(fout, "kP=%f kI=%f kD=%f FMIN=%f", K[0],K[1],K[2],K[3]);
	// закрыть файл
	fclose(fout);

	// моделирование с результатом оптимизации
//	K[0]=3.659620; K[1]=-2.669156; K[2]=-0.088680;
//	kP=3.659620 kI=-2.669156 kD=-0.088680
	MODELING(K);
	
	return 0;
}