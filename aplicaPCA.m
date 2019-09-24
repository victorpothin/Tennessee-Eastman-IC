function [score,a,s,coeff] = aplicaPCA(dataBase,variance)    
    
    C = cov(dataBase);
    [coeff, s, v] = svd(C);
    a=0;
    latent = diag(s);
    
    latent = latent/sum(latent);
    for i=1:length(latent)
        Acumm(i) = sum(latent(1:i));
        if Acumm(i)>=(variance/100) && a==0 
             a = i;
        end
    end 
    
    a=6;
   
    coeff = coeff(:,1:a);
    score = dataBase*coeff;

end

