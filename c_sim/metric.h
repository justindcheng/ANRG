#ifndef METRIC_H
#define METRIC_H
#include <vector> 
using namespace std;

//M is the 2 column matrix 
//G column robots rows row 

class Metric {
	public:
		Metric(vector<int> M, vector<int> G, double eta, double gamma );
		~Metric();

	private:


};

#endif