/*README

To compile 
g++ simulation_grad.cpp metric.cpp util.cpp -o simulation_grad

To run
./simulation_grad group_3_3_triangle.txt environment.txt test.txt "simulations" "passes"


*/


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

//arguments for input files
char* groups= argv[1];
char* enfile = argv[2];
char* ofile = argv[3];
int s = atoi(argv[4]);
int p = atoi(argv[5]);
const double delta = 0.1;
const double constant = 0.01;

//put arguments into files
fstream groupfile;
groupfile.open(groups);

fstream efile;
efile.open(enfile);

fstream outfile;
outfile.open(ofile, std::ofstream::out | std::ofstream::trunc);

//Create matrix of groups
vector<int> Group;
vector<vector<int> > Groups;
string line;

//Read Matrix of Groups
int N = 0;
while(getline(groupfile,line)) {
	stringstream ss(line);
	int number;
	while(ss >> number) {
		Group.push_back(number);
	}
	Groups.push_back(Group);
    N = Group.size();
    Group.clear();
	
}

//Read Environment
float eta = 0;
float gamma = 0;
float side = 0;
efile >> eta >> gamma >> side;
efile.close();


//Create a Map of Robots
vector<Robot> Map(3);
//starting point(3,3)
double a_max = 0;
double b_max = 0;
double c_max = 0;
outfile << groups << endl;
outfile << enfile << endl;
//Iterate through every possibl combo triangle
for(double a = 0; a < side; a+=0.5) {
	for(double b = 0; b < side; b+=0.5) {
		for(double c = 0; c < side; c+=0.5) {
            //reset max
            double a_max = 0;
            double b_max = 0;
            double c_max = 0;
            //run simulation only if triangle is solved
			if(a <= b && b <= c) {
                //caluculate inital positions of Map using math
				double theta = acos((b-a*a-c*c)/2*a*c);

				Map[0].x = 3;
				Map[0].y = 3;
				Map[1].x = 3+a;
				Map[1].y = 3;
				Map[2].x = 3+cos(theta)*c;
				Map[2].y = 3+sin(theta)*c;
			     
                double OldM;
                double newM;
                //Run through simulation "s" times and for N Robots
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
                        OldM = metric.sum;
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
                       	newM = metric5.sum;
                        //if New Metric is worse continue with old Metric
                        if(OldM >= newM) {
                            Map = OldMap;
                        }
                    }
                    //After all Robots are Set in new Position, if the newer Map had a better metric record the sides
                        if(newM > OldM) {
                            a_max = Map[1].x-Map[0].x;
                            b_max = pow(pow(Map[2].x-Map[1].x,2)+pow(Map[2].y-Map[1].y,2),0.5);
                            c_max = pow(pow(Map[2].x-Map[0].x,2)+pow(Map[2].y-Map[0].y,2),0.5);
                        }
                         
                    /*if (j % p == 0) {
                        for(int i = 0; i < 3; i++) {
                            outfile << Map[i].x << " " << Map[i].y << endl;
                        }
                    }*/
                }
                //print out sides once every 'S' simulations are done
                if(a <= b && b <= c)
                    outfile << a_max << " " << b_max << " " << c_max << endl;
            }
        }
    }
}


    


return 0;
}
