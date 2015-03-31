#ifndef GROUP_H
#define GROUP_H

#include <vector>

class Group {
	public:
		Group();
		Group(int nrob);
		Group(const Group& g);
		~Group();

		std::vector<int> neighbors(int rob);

	private:
		int _nrob;
		int _ngrp;
		std::vector<int>* _adj;
		int** mat;
};

#endif