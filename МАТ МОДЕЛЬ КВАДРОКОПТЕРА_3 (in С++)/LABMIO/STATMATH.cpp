/*����������*/
#include "stdafx.h"

//��������� ������ ����
double GAUSS()
{
	double ran=0.0;
	for (int i=1;i<=12;i++)
		ran+=(1 - (1-0)*((double)rand()/32768));;        
	ran-=6.0;
	return ran;
}//end GAUSS

//���������� �� � ���
void STATIS(double x[], int n, double &MO, double &SKO, int k, double R[])
{
	//��������� ����������
	double SUM=0.0;
	
//1. ���������� �� 
	//����� ���� ���������� ��
	for (int i = 0; i < n; i++)
		SUM += x[i];
	//�������������� ��������
	MO = SUM / n;

//2. ���������� ���	
	//�������� ���������� ��� ���������� ���
	SUM = 0.0;
	//����� ���� �������������� ��������
	for (int i = 0; i <n; i++)
		SUM += pow(x[i] - MO, 2.0);		
	//���
	SKO = pow(SUM / n, 0.5);
	
//3. ���������� �������������� �������
	SUM=0.0;
	for (int j=0;j<=k;j++)
	{
		for (int i=0;i<n-j;i++)
			SUM+=(x[i]-MO)*(x[i+j]-MO);
		//�������������� ������� �� ��������� k
		R[j]=SUM/(n-j+1);
		//�������� ���������� ��� ������ ����������
		SUM=0.0;
	}	
}//end STATIS

//����������� ������
void FFILTER(double DF[], double F[], double PAR[], double Q)
{
	//������������ ������������ ������� �������
	double k=PAR[0], b0=PAR[1], b1=PAR[2];
	double xi=GAUSS();
	//����������������� ��������� �������
	DF[0]= (k*xi- b0*F[0])/b1;	
}//end FFILTER