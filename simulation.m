function simulation(groupfile, enfile,outfile,simulations,passes)
Groups = dlmread(groupfile);
enfile = fopen(enfile);
eta = fscanf(enfile,'eta=%f\n',1);
gamma = fscanf(enfile,'Pt/N=%f\n',1);
side = fscanf(enfile,'side=%f',1);
fclose(enfile);
[G,N] = size(Groups);
Map = side*rand(N,2);
dlmwrite(outfile,groupfile,'');
s = str2double(simulations);
p = str2double(passes);
for j=1:s
    Map = side*rand(N,2);
    if mod(j,p) == 0
        dlmwrite(outfile,Map,'-append','delimiter',' ');
    end
end
