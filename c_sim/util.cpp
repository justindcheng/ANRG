#include "util.h"

#include <cmath>

#define SQR(x) ((x)*(x))

dist(Robot r1, Robot r2) {
	return sqrt(SQR(r1.x-r2.x)+SQR(r1.y-r2.y));
}