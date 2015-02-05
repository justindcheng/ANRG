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
for j = 1:s
    for i = 1:N
        r = rand*2*pi;
        oldx = Map(i,1);
        oldy = Map(i,2);
        oldM = Metric(Map,Groups,eta,gama);
        Map(1,i) = oldx + sin(r)/j;
        Map(2,i) = oldy + cos(r)/j;
        if Metric(Map,Groups,eta,gamma) < oldM
            Map(i,1) = oldx;
            Map(i,2) = oldy;
        end;
    end;
    if mod(j,p) == 0
        dlmwrite(outfile,Map,'-append','delimiter',' ');
    end
end
