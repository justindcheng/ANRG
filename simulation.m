groups = dlmread('groups.txt');
enfile = fopen('environment.txt');
eta = fscanf(enfile,'eta=%f\n',1);
Ptn = fscanf(enfile,'Pt/N=%f\n',1);
side = fscanf(enfile,'side=%f',1);
fclose(enfile);
eta
Ptn
side

