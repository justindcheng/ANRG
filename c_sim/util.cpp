#include "util.h"

#include <cmath>

#define SQR(x) ((x)*(x))

double Distance(Robot r1, Robot r2) {
	return sqrt(SQR(r1.x-r2.x)+SQR(r1.y-r2.y));
}

double Power(Robot r1, Robot r2, double eta) {
	return 1/pow(1+Distance(r1, r2), eta);
}

double SINR(double signal, std::vector<double> interf, double gamma) {
	double sum = 0;
	for (unsigned int i = 0; i < interf.size(); i++) {
		sum += interf[i];
	}
	return (gamma*signal)/(1+sum*gamma);
}