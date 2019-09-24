function [t2f,T2lim,Qf,Qlim,t2,Q, phi, philim] = t2NQNphi(dataTrain,dataTeste, variance)
%Fun��o para calcular a estatistica t2 com seu limiar e a 
%estatistica Q com seu limiar
%T2 , Q, T2lim , Qlim

    %A aplica��o do PCA � dado para covarian�a da base de treinameto e
    %decomposi��o da mesma pelo metodo SVD
    CovarianceMatrix = cov(dataTrain);
    [u, s, v] = svd(CovarianceMatrix);

    ds = diag(s);
    ds = ds/sum(ds);

    a = 0;
    for i=1:length(ds)
        Acumm(i) = sum(ds(1:i));
        if Acumm(i)>=(variance/100) && a==0 
            a = i;
        end
    end

    clear ds

    %Ap�s aplicar o PCA � utlizado apenas os primeiros componentes
    %princiapais que somados possui >=90% de varian�a
    T = u(:,1:a);
  
    n = length(dataTrain);
    alfa = 0.99;
    
    %Limiar de T2
    T2lim = (a*(n-1)*(n+1)/(n*(n-a)))*finv(alfa,a,n-a);

    ds = diag(s);
    
    teta1 = sum(ds(a+1:end));
    teta2 = sum(ds(a+1:end).^2);
    teta3 = sum(ds(a+1:end).^3);

    h0 = 1 - (2*teta1*teta3)/(3*teta2^2);
    Ca=norminv([0 alfa],0,1);
    Ca=Ca(2);
    Qlim = teta1*((h0*Ca*sqrt(2*teta2)/teta1) + 1 + (teta2*h0*(h0-1))/(teta1^2))^(1/h0);

    %Sele��o das estatisticas t2, Q e PHI para apontamento da falha
    [~,~,~,t2,~] = pca(dataTeste);
    t2 = t2';
    t2f = t2(1);
    ewma = 0.4;
    ii = 0;
    
    for i=1:length(t2)
    t2f(i+1)=ewma*t2(i)+(1-ewma)*t2f(i);
        if t2f(i)>=T2lim && ii==0
            ii = i;
        end
    end

    for i=1:length(dataTeste)
        Error = dataTeste(i,:)' - T*(dataTeste(i,:)*T)'; 
        Q(i) = Error'*Error;
        CONT_FalhaQ(i,:) = Error.^2;
    end

    Qf = Q(1);
    ewma = 0.3;
    
    for i=1:length(Q)
        Qf(i+1)=ewma*Q(i)+(1-ewma)*Qf(i);
    end
    
    Qf = Qf(2:end);


    for k = 1:size(Qf,2)
        phi(k) = (Qf(k) / Qlim) + (t2f(k) / T2lim);
    end

    gphi = ((a/T2lim^2)+(teta2/Qlim^2))/((a/T2lim)+(teta1/Qlim));
    hphi = ((a/T2lim)+(teta1/Qlim))^2/((a/T2lim^2)+(teta2/Qlim^2));
    philim = gphi*chi2inv(alfa,hphi)+0.20;
    
end