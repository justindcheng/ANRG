#ifndef UTIL_H
#define UTIL_H
#include "robot.h"
#include <vector>

double Distance(Robot r1, Robot r2);

double Power(Robot r1, Robot r2, double eta);

double SINR(double signal, std::vector<double> interf, double gamma);

#endif