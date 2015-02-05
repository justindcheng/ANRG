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
Map = zeros(2,N);
figure;
while ~(feof(data))
    %read an instance of Map from data file
    for i = 1:N
        Map(1,i) = fscanf(data,'%f ',1);
        Map(2,i) = fscanf(data,'%f\n',1);
    end;
    %plot an instance of map
    clf;
    hold on;
    axis([0,side,0,side]);
    for i = 1:N
        plot(Map(1,i),Map(2,i),'b.');
    end;
    for i = 1:G
        for j = 1:N
            for k = 1:N
                if (Groups(i,j) == 1) && (Groups(i,k) == 1) && (i ~= j)
                    d = Distance(Map(1,j),Map(2,j),Map(1,k),Map(2,k))/side/sqrt(2);
                    d = sqrt(d);
                    line('XData', [Map(1,j) Map(1,k)], 'YData', [Map(2,j) Map(2,k)], 'LineStyle', '-', ...
    'LineWidth', 1, 'Color',[d,d,d]);
                end;
            end;
        end;
    end;
    drawnow;
    %disp(Map);
    pause(0.1);
end;
fclose(data);
