function [t2Lim,qLim,phiLim] = geraEstatisticaLimiares(dataBase,a,s,t2Lim)
    alfa = 0.99;
    qLim = 0;
    phiLim = 0;
    if(t2Lim==0)
        n = length(dataBase);
        %Limiar de T2
        t2Lim= (a*(n-1)*(n+1)/(n*(n-a)))*finv(alfa,a,n-a);
    else
        
        ds = diag(s);
    
        teta1 = sum(ds(a+1:end));
        teta2 = sum(ds(a+1:end).^2);
        teta3 = sum(ds(a+1:end).^3);

        h0 = 1 - (2*teta1*teta3)/(3*teta2^2);
        Ca=norminv([0 alfa],0,1);
        Ca=Ca(2);
        qLim = teta1*((h0*Ca*sqrt(2*teta2)/teta1) + 1 + (teta2*h0*(h0-1))/(teta1^2))^(1/h0);

        %Limiar Phi
        gphi = ((a/t2Lim^2)+(teta2/qLim^2))/((a/t2Lim)+(teta1/qLim));
        hphi = ((a/t2Lim)+(teta1/qLim))^2/((a/t2Lim^2)+(teta2/qLim^2));

        phiLim = gphi*chi2inv(alfa,hphi);
    
    end
    
end

