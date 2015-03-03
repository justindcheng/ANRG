function optimalSize(l, u)
    syms s
    f(s) = log(( l * ( 1/ ( (1 + s)^u ) ) )/( l * ( (2/(1 + (2 * s^2 - 2 * s^2 * cosd(135))^(1/2) )^u ) + (2/ (1 + s + (2*s)/(2^(1/2)) )^u ) + (1/(1+( (s + 10/(2^(1/2)))^2 + s^2  )  )^u   )  +  (1/((1 + s)^u)) ) + 1)  + 1  ) * 8;
    
    df = diff(f);
    eqn = df == 0;
    solx = solve(eqn, s);
    disp(solx);
    
    

end

