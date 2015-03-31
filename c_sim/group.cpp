#include "group.h"

Group::Group() {
	_nrob = 0;
	_ngrp = 0;
	_adj = NULL;
	mat = NULL;
}

group::Group(int nrob) {
	_nrob = nrob;
	_ngrp = 0;
	adj = new std::vector<int>[_nrob];
	
}

Group::Group(const Gropu& g) {
	_nrob = g._nrob;
	_ngrp = g._ngrp;
	_adj = new std::vector<int>[_nrob];
	for (unsigned int i = 0; i < _nrob; i++) {
		_adj[i] = g._adj[i];
	}
}

Group::~Group() {
	if (adj != NULL) {
		delete [] adj;
	}
	_nrob = 0;
	_ngrp = 0;
	_adj = NULL;
}

std::vector<int> Group::neighbors(int rob) {
	return _adj[rob];
}
