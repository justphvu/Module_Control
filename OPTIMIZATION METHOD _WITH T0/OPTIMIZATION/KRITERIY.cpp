#include "stdafx.h"

// ������� �������
double FCT(double K[])
{
	// ����� ���������� ���������
	int N;
	// ��������� ����������
	double TF,DT,TIME,T0;
	// ����������� �� �������� ������
	double YDES, YMAX, DYMAX;
	// �������� �����������
	double J; 
	// ���������� ������� ��������� X(N)
	double X[4]={0.0}; 
	// ���������� ������� ��������� X(N)
	double DX[4]={0.0}; 
	// ���������� ������� ����������
	double U[1]={0.0};
	double U0[1]={0.0};
	// ������������� ���������� ��������� �������
	X[0]=0.0;
	//X[1]=10.0;				// ������
	X[1]=1.0*3.14/180;		    // ����
	X[2]=0.0;
	X[3]=0.0;
	// ������������� ����������
	U0[0]=0.0;
	U[0]=U0[0];
	// �������� ���������
	N=4;
	TF=10.0;
	DT=0.001;
	TIME=0.0;
	YDES=0.0;
	YMAX=5.0;
	// DYMAX=5.E00;               // ������������ ��������
	DYMAX=10.E00*3.14/180;        // ������� ��������
	J=0.0;
	
	// ������� �������� ������� ����������
	T0=K[0];
	kP=K[1];
	kI=K[2];
	kD=K[3];

	// ���� �������������
	do
	{
		// �������������� (1 ���)
		RKS(N,DT,TIME,DX,X,U,FX);
		// ������� ����������
		CONTROL(X,U,U0);
		// �������� �����������
		/*if (fabs(X[2])>DYMAX)
			J=J+1.E+6*pow(X[2]/DYMAX,2.0);*/
		if (TIME>T0)
			J=J+1.E+3*pow(X[1]-YDES,2.0)+2.E+2*pow(X[2],2.0);
		if (J!=J)
			J=1.E+9;
	}while (TIME<TF);
	J=J+15.E+3*T0*T0;
//	static int count=0;
//	if (count==0)
	printf("T0=%f kP= %f kI=%f kD=%f U=%f F=%f\n",T0,kP,kI,kD,X[1],J);
//	count=1;
	// ������� �������� ��������
	return J;
}