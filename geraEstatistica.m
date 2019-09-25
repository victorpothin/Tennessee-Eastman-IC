function [phi,t2f,qf,t2,q] = geraEstatistica(M,T,s,a,qLim,t2Lim)
    
    %Estatistica t2
    s2 = s(1:a, 1:a);
    for i=1:length(M)
        t2(i)=M(i,:)*(T*(s2^-1)*T')*M(i,:)';
    end

    %Filtro t2
    t2f = t2(1);
    ewma = 0.125;
    ii = 0;
    for i=1:length(t2)
        t2f(i+1)=ewma*t2(i)+(1-ewma)*t2f(i);
    end
    
    %Estatistica Q
    for i=1:length(M)
        Error = M(i,:)' - T*(M(i,:)*T)'; 
        q(i) = Error'*Error;
    end

    %Filtro Q
    qf = q(1);
    ewma = 0.125;
    for i=1:length(q)
        qf(i+1)=ewma*q(i)+(1-ewma)*qf(i);
    end
    qf = qf(2:end);

    
    for k = 1:size(qf,2)
        phi(k) = (qf(k) / qLim) + (t2f(k) / t2Lim);
    end

end

