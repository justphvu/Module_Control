// OPTIMIZATION.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

int _tmain(int argc, _TCHAR* argv[])
{
	// ���� ��� ������
	fout = fopen(".\\RESULT\\RES_OPT.ris", "w");
	// ������� ����������
	double K[5] = {0.0};
	// ������ ���������
	double EPS=1.E-6;
	// ����� ����������
	int N = 3;

	// ��������� �������� ������� ���������� (��������� ������������ �������)
	K[0]=1.0E-1;
	K[1]=1.0E-1;
	K[2]=1.0E-1;
	
	// ����������� �� ������������
	for (int i=0;i<4;i++)
	{
		XMAX[i]=10.0;
		XMIN[i]=-10.0;
	}
	// �����������

	WRK50(K,N);
	// ������ �����������
	fprintf(fout, "kP=%f kI=%f kD=%f FMIN=%f", K[0],K[1],K[2],K[3]);
	// ������� ����
	fclose(fout);

	// ������������� � ����������� �����������
//	K[0]=3.659620; K[1]=-2.669156; K[2]=-0.088680;
//	kP=3.659620 kI=-2.669156 kD=-0.088680
	MODELING(K);
	
	return 0;
}