function [cons, Es_avg] = constellation(M, modulation)
modulation = lower(modulation);
switch modulation
    case 'pam'
        cons = (-(M-1):2:(M-1))';
        cons = cons/sqrt(abs(cons'*cons)/M);
        Es_avg = abs(cons'*cons)/M;
    case 'psk'
        s_i = cos(2*pi/M*(0:(M-1)))';
        s_q = sin(2*pi/M*(0:(M-1)))';
        cons = complex(s_i, s_q);
        cons = cons/sqrt(abs(cons'*cons)/M);
        Es_avg = abs(cons'*cons)/M;
    case 'qam'
        M1 = 2^ceil(log2(sqrt(M)));
        M2 = 2^floor(log2(sqrt(M)));
        cons1 = -(M1-1):2:(M1-1);
        cons2 = -(M2-1):2:(M2-1);
        cons = cons1 + 1i*cons2';

        cons = cons(:);
        cons = cons/sqrt(abs(cons'*cons)/M);
        Es_avg = abs(cons'*cons)/M;
end
end

