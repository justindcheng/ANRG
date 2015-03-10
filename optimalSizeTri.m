function optimalSizeTri(l, u)
    syms s
    f(s) = (l/( (1 + s)^u ) )/( (l/ ( (1+s)^u ) ) + 1   );
    df = diff(f);
    eqn = df == 0;
    solx = solve(eqn, s);
    disp(double(solx));
    
    

end

