function optimalSizeSq(l, u)
    syms s
    f(s) = log((l * (1/((1 + s)^u) ) )/( l * (  (1/((1 + s *( 2^(1/2)))^u)) + (1/((1 + s)^u)) ) + 1  ) + 1) * 8;
    df = diff(f);
    eqn = df == 0;
    solx = solve(eqn, s);
    solx = double(solx);
    disp(solx);
    num = solx.s;
    disp(num);
    

end

