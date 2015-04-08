#include "metric.h"
#include <fstream>
#include <sstream>
#include <string>
#include <cmath>
#include "metric.h"
#include <cstdio>
#include "robot.h"
#include <vector>
#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {

char* groups= argv[1];
char* enfile = argv[2];
char* ofile = argv[3];
int s = atoi(argv[4]);
int p = atoi(argv[5]);
const double delta = 0.1;
const double constant = 0.01;

//get two line of txt file and put into arrays
fstream groupfile;
groupfile.open(groups);

fstream efile;
efile.open(enfile);

fstream outfile;
outfile.open(ofile);

vector<int> Group;
vector<vector<int> > Groups;
string line;

int N;
while(getline(groupfile,line)) {
	stringstream ss(line);
	int number;
	while(ss >> number) {
		Group.push_back(number);
	}
	Groups.push_back(Group);
	N = Group.size();
}


float eta;
float gamma;
float side;
FILE* fp = std::fopen(enfile, "r");
fscanf(fp,"eta=%f\n", &eta);
fscanf(fp,"Pt/N=%f\n",&gamma);
fscanf(fp, "side=%f", &side);
efile.close();


vector<Robot> Map(3);
//starting point(3,3)
for(double a = 0; a < side; a+=0.5) {
	for(double b = 0; b < side; b+=0.5) {
		for(double c = 0; c < side; c+=0.5) {
			if(a <= b && b <= c) {
				double theta = acos((b-a*a-c*c)/2*a*c);

				Map[0].x = 3;
				Map[0].y = 3;
				Map[1].x = 3+a;
				Map[1].y = 3;
				Map[2].x = 3+cos(theta)*c;
				Map[2].y = 3+sin(theta)*c;
			}
		}
	}
}

outfile << groupfile << endl;
outfile << enfile << endl;

for (int j = 0; j < s; j++) {
    for (int i = 0; i < N; i++) {
        //getting current value and comparing SINR to all 4 sides
        double oldx = Map[i].x;
        double oldy = Map[i].y;
        vector<Robot> OldMap(3);
        for(int i = 0; i < 3; i++) {
        	OldMap[i] = Map[i];
        }
        Metric metric(Map,Groups,eta,gamma);
        double OldM = metric.sum;
        Map[i].x = oldx + delta/2;
        Metric metric1(Map,Groups,eta,gamma);
        double xpos = metric1.sum;
        Map = OldMap;
        Map[i].x = oldx - delta/2;
        Metric metric2(Map,Groups,eta,gamma);
        double xneg = metric2.sum;
        Map = OldMap;
        Map[i].y = oldy + delta/2;
        Metric metric3(Map,Groups,eta,gamma);
        double ypos = metric3.sum;
        Map = OldMap;
        Map[i].y = oldy - delta/2;
        Metric metric4(Map,Groups,eta,gamma);
        double yneg = metric4.sum;
        Map = OldMap;
        Map[i].x = (oldx + constant * ((xpos - xneg)/delta));
        Map[i].y = (oldy + constant * ((ypos - yneg)/delta));
       	Metric metric5(Map,Groups,eta,gamma);
       	double newM = metric5.sum;
        if(OldM >= newM)
            Map = OldMap;
    }
  }
    /*if (j % p == 0) {
    	for(int i = 0; i < 3; i++) {
    		outfile << Map[i].x << " " << Map[i].y << endl;
    	}
    }*/


return 0;
}
