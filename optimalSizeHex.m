function optimalSizeHex(l, u)
    syms s
<<<<<<< HEAD
    f(s) = log((l * (1/((1 + s)^u) ) )/( l * ( (2/ (1 + (s*(3^(1/2) ) ) )^u  ) + (1/ ((1 + 2 *s)^u)) + ((1/((1 + s)^u)) ) + 1) ) + 1  ) * 8;
=======
    f(s) = log((l * (1/((1 + s)^u) ) )/( l * ( (2/ (1 + (s*(3^(1/2) ) ) )^u  ) + (1/ ((1 + 2 *s)^u)) + ((1/((1 + s)^u)) ) + 1) ) + 1  ) * 12;
>>>>>>> 4d4a2d6b9ad3bb8f6bbab322148a43668b3c61d3
    
    df = diff(f);
    eqn = df == 0;
    solx = solve(eqn, s);
    disp(solx);
    
    

end

