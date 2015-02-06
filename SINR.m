function ret = SINR(Sij, Sim, gamma)
ret = gamma*Sij/(1+gamma*sum(Sim));
