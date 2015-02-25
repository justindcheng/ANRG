function optimalSizeSq(l, u)
    syms s
    f(s) = (l * (1/((1 + s)^u) ) )/( l * (1/((1 + s *( 2^(1/2)))^u) ) + 1  );
    df = diff(f);
    eqn = df == 0;
    solx = solve(eqn, s);
    disp(double(solx));
    
    

end

