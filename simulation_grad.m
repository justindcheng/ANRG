function simulation_grad(groupfile,enfile,outfile,simulations,passes)

delta = 0.1;
constant = 0.01;

%get two line of txt file and put into arrays
numbers1 = fopen(groupfile);
numline = fgetl(numbers1);
Host = sscanf(numline, '%u');
numline = fgetl(numbers1);
Location = sscanf(numline, '%u');

Groups = dlmread(groupfile, ' ', 2, 0);
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
        if Host(i) == 1
            continue;
        end
        %getting current value and comparing SINR to all 4 sides
        oldx = Map(i,1);
        oldy = Map(i,2);
        OldMap = Map;
        oldM = Metric(Map,Groups,eta,gamma);
        %disp('OldM');
        %disp(oldM);
        Map(i,1) = oldx + delta/2;
        xpos = Metric(Map,Groups,eta,gamma);
        %disp('xpos');
        %disp(xpos);
        Map = OldMap;
        Map(i,1) = oldx - delta/2;
        xneg = Metric(Map,Groups,eta,gamma);
        %disp('xneg');
        %disp(xneg);
        Map = OldMap;
        Map(i,2) = oldy + delta/2;
        ypos = Metric(Map,Groups,eta,gamma);
        %disp('ypos');
        %disp(ypos);
        Map = OldMap;
        Map(i,2) = oldy - delta/2;
        yneg = Metric(Map,Groups,eta,gamma);
        %disp('yneg');
        %disp(yneg);
        Map = OldMap;
        Map(i,1) = (oldx + constant * ((xpos - xneg)/delta));
        Map(i,2) = (oldy + constant * ((ypos - yneg)/delta));
        newM = Metric(Map,Groups,eta,gamma);
        %disp('newM');
        %disp(newM);
        if(oldM >= newM)
            Map = OldMap;
        end;
    end;
    if mod(j,p) == 0
        dlmwrite(outfile,Map,'-append','delimiter',' ');
        %disp(oldM);
    end
end
disp(Metric(Map,Groups,eta,gamma));
