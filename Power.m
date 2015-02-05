function p = Power(x1, y1, x2, y2, eta)
p = 1/((1+Distance(x1,y1,x2,y2)^2)^eta);
