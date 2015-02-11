function simulation(groupfile,enfile,outfile,simulations,passes)

%get two line of txt file and put into arrays
numbers = fopen(groupfile);
numline = fgetl(numbers);
Host = sscanf(numline, '%u');
numline = fgetl(numbers);
Location = sscanf(numline, '%u');

Groups = dlmread(numbers);
efile = fopen(enfile);
eta = fscanf(efile,'eta=%f\n');
gamma = fscanf(efile,'Pt/N=%f\n');
side = fscanf(efile,'side=%f');
fclose(efile);
[G,N] = size(Groups);
Map = side*rand(N,2);
dlmwrite(outfile,numbers,'');
dlmwrite(outfile,enfile,'-append','delimiter','');
s = str2double(simulations);
p = str2double(passes);
for j = 1:s
    for i = 1:N
        if h(i) == 1
            continue;
        end
        r = rand*2*pi;
        oldx = Map(i,1);
        oldy = Map(i,2);
        oldM = Metric(Map,Groups,eta,gamma);
        Map(i,1) = oldx + sin(r)/10;
        Map(i,2) = oldy + cos(r)/10;
        if Map(i,1) < 0
            Map(i,1) = 0;
        end;
        if Map(i,1) > side
            Map(i,1) = side;
        end;
        if Map(i,2) < 0
            Map(i,2) = 0;
        end;
        if Map(i,2) > side
            Map(i,2) = side;
        end;
        if Metric(Map,Groups,eta,gamma) < oldM
            Map(i,1) = oldx;
            Map(i,2) = oldy;
        end;
    end;
    if mod(j,p) == 0
        dlmwrite(outfile,Map,'-append','delimiter',' ');
    end
end
