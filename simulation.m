function simulation(groupfile,enfile,outfile,simulations,passes)
Groups = dlmread(groupfile);
efile = fopen(enfile);
eta = fscanf(efile,'eta=%f\n');
gamma = fscanf(efile,'Pt/N=%f\n');
side = fscanf(efile,'side=%f');
fclose(efile);
[G,N] = size(Groups);
Map = side*rand(N,2);
dlmwrite(outfile,groupfile,'');
dlmwrite(outfile,enfile,'-append','delimiter','');
s = str2double(simulations);
p = str2double(passes);
for j=1:s
    Map = side*rand(N,2);
    if mod(j,p) == 0
        dlmwrite(outfile,Map,'-append','delimiter',' ');
    end
end
