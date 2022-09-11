// OPTIMIZATION.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

int _tmain(int argc, _TCHAR* argv[])
{
	// ���� ��� ������
	fout = fopen(".\\RESULT\\RES_OPT.ris", "w");
	// ������� ����������
	double K[6] = {0.0};
	// ������ ���������
	double EPS=1.E-6;
	// ����� ����������
	int N = 4;

	// ��������� �������� ������� ���������� (��������� ������������ �������)
	K[0]=0.0E-1;	//����� ���������
	K[1]=0.0E-1;	//kP
	K[2]=0.0E-1;	//kI
	K[3]=0.0E-1;	//kD
	// ����������� �� ������������
	XMAX[0]=5.0;   // ����� ������������
	XMIN[0]=0.0;
	for (int i=1;i<5;i++) // ������������ ��� ����������
	{
		XMAX[i]=100.0;
		XMIN[i]=-100.0;
	}
	
	// �����������
	WRK50(K,N);
	// ������ �����������
	fprintf(fout, "T0=%f kP=%f kI=%f kD=%f FMIN=%f", K[0],K[1],K[2],K[3],K[4]);
	// ������� ����
	fclose(fout);

	// ������������� � ����������� �����������
	//K[1]=-0.467101; K[2]=0.000925; K[3]=-0.35881;
	//kP=-0.467101; kI=0.000925; kD=-0.35881;
	MODELING(K);
	
	return 0;
}