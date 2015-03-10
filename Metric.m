function Sum = Metric( M, G, eta, gamma )
%Metric Creator
%   Given a matrix, the input parameters(M,G,eta,gamma)
    [N,R] = size(G);
    Sum = 0;
    for i = 1:N
        for j = 1:R
            for k = 1:R
                if G(i,j) ~= 0 && G(i,k) ~= 0 && j ~= k   
                   s = Power(M(j,1), M(j,2), M(k,1), M(k,2), eta);
                   x = zeros(1:R);
                   for a = 1:R
                       if j ~= a && k ~= a
                          x(a) = Power(M(j,1), M(j,2), M(a,1), M(1,2),eta);
                       end
                   end
                   Sum = Sum + log(1+ SINR(s, x, gamma));
                   Sum = Sum(1);
                end               
            end
        end
    end




end

