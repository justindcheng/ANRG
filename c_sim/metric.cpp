#include "metric.h"
#include "util.h"
#include "robot.h"
#include <cmath>
#include <vector> 
using namespace std;

Metric::Metric(vector<Robot> M, vector<Robot> G, double eta, double gamma ){
	int N = (int)G.size();
	int R = (int)(G[0].size());

	double sum = 0; 
	for (int i = 0; i < N; i++){
		for (int j = 0; j< R; j++){
			for (int k = 0; k < R; k++){
				if (G[i][j] != 0 && G[i][k] != 0 && j != k  ){
					double s = Power(M[j] , M[k]  , eta);
					vector<double> x; 
					for (int l = 0; l < R; l++ ){
						x.push_back(0);
					}
					for (int m = 0; m < R; m++){
						if (j != m && k != m){
							x[m] = Power(M[j], M[m], eta );
						}
					}
					sum = sum + log(1 + SINR(s, x, gamma) );
				}
			}
		}
	}
};