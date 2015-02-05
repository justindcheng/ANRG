function [ SINR ] = Metric( M, G, eta, gamma )
%Metric Creator
%   Given a matrix, the input parameters(M,G,eta,gamma)
    [N,R] = size(G);
    SINR = 0;
    for i = 1:N
        for j = 1:R
            for k = 1:R
                if G(i,j) ~= 0 && G(i,k) ~= 0 && j ~= k   
                   SINR = SINR + pow(M(j,1), M(j,2), M(k,1), M(k,2), eta);
                end               
            end
        end
    end





end

