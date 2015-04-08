#ifndef METRIC_H
#define METRIC_H
#include <vector> 
#include "robot.h"
using namespace std;

//M is the 2 column matrix 
//G column robots rows row 

class Metric {
	public:
		Metric(vector<Robot > M, vector<vector<int> > G, double eta, double gamma );
		~Metric();
		double sum; 
	private:


};

#endif