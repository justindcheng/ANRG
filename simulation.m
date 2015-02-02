Groups = dlmread('groups.txt');
enfile = fopen('environment.txt');
eta = fscanf(enfile,'eta=%f\n',1);
gamma = fscanf(enfile,'Pt/N=%f\n',1);
side = fscanf(enfile,'side=%f',1);
fclose(enfile);
[G,N] = size(Groups);
Map = side*rand(N,2);
Groups
Map
