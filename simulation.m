gpfile = fopen('groups.txt');
M = dlmread('groups.txt');
enfile = fopen('environment.txt');
[eta,Ptn,side] = textscan('enviornment.txt','%f');
dis(eta, Ptn, side);

