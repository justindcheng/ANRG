function optimalSizeHex(l, u)
    syms s
    f(s) = (l * (1/((1 + s)^u) ) )/( l * ( (2/ (1 + (s*(3^(1/2) ) ) )^u  ) + (1/ ((1 + 2 *s)^u)) ) + 1  );
    df = diff(f);
    eqn = df == 0;
    solx = solve(eqn, s);
    disp(solx);
    
    

end

