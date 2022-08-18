#include "stdafx.h"

//���������� � ������������� ���������� ����������
int N=0,M=0;
double TIME=0.0,DT=0.0;

void MODELING()
{
	//���� ������
	FILE *fOUT;
	//�������� � �������� ��� ������
	fOUT=fopen(".\\RESULT\\OUT.ris","w");	
	
	// ������������� ���������� �������������
	N=3;	//����� ���������� ���������	
	M=1;	//����� �������� ����������	
	DT=0.1;	//��� ��������������
	
	//����� �������������
	double TMODEL=1.0;

	// ���������� ������� ��������� X(N)
	double* X = new double [N]; 
	// ���������� ������� ��������� X(N)
	double* DX = new double [N]; 
	//���������� ������� ����������
	double* U = new double [M]; 

	//������������� ���������� ��������� �������
	X[0]=1.0;
	X[1]=1.0;
	X[2]=0.0;

	//������ ������ �����������: fprintf(fOUT,"U1 U2 ...Um X0 X1 X2 ... Xn");
	fprintf(fOUT,"U X0 X1 X2");	

	// ���� �������������
	do
	{	
		//������� ����������
		CNTRL(M,U,TIME);

		//������ �����������
		fprintf(fOUT,"\n%f ",TIME);		//�����
		for (int i=0;i<M;i++)
			fprintf(fOUT,"%f ",U[i]);	//������ ����������	
		for (int i=0;i<N;i++)
			fprintf(fOUT,"%f ",X[i]);	//������ ���������
		
		//�������������� (1 ���)
		RKS(N,DT,TIME,DX,X,U,FX);

	}while (TIME<TMODEL);
}