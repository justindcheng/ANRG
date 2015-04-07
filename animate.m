%takes in group file and animation data file and output animation
function animate(datafile)
%read groups into a matrix
data = fopen(datafile);
groupfile = fscanf(data,'%s\n',1);
enfile = fscanf(data,'%s\n"',1);
Groups = dlmread(groupfile);
efile = fopen(enfile);
eta = fscanf(efile,'eta=%f\n');
gamma = fscanf(efile,'Pt/N=%f\n');
side = fscanf(efile,'side=%f');
[G,N] = size(Groups);
%positions are stored in Map
Map = zeros(N,2);
Colors = rand(3,G);
Colors = ones(3,G) - Colors.*Colors;
figure;
figure;
time = 0;
while ~(feof(data))
    %read an instance of Map from data file
    for i = 1:N
        Map(i,1) = fscanf(data,'%f ',1);
        Map(i,2) = fscanf(data,'%f\n',1);
    end;
    %plot an instance of map
    %subplot(2,1,1);
    figure(1);
    clf;
    hold on;
    axis([0,side,0,side]);
    for i = 1:N
        plot(Map(i,1),Map(i,2),'b.', 'MarkerSize', 30);
    end;
    for i = 1:G
        for j = 1:N
            for k = 1:N
                if (Groups(i,j) == 1) && (Groups(i,k) == 1) && (i ~= j)
                    %d = Distance(Map(1,j),Map(2,j),Map(1,k),Map(2,k))/side/sqrt(2);
                    %d = sqrt(d);
                    line('XData', [Map(j,1) Map(k,1)], 'YData', [Map(j,2) Map(k,2)], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color',[Colors(1,i),Colors(2,i),Colors(3,i)]);
                end;
            end;
        end;
    end;
    drawnow;
    %plot metric
    figure(2);
    %subplot(2,1,2);
    hold on;
    plot(time,Metric(Map,Groups,eta,gamma),'b.', 'MarkerSize', 5);
    time = time + 1;
    %disp(Metric(Map,Groups,eta,gamma));
    %disp(Map);
    %pause(0.05);
end;
fclose(data);
