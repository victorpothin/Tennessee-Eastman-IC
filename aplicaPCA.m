function [score,a,s,coeff] = aplicaPCA(dataBase,variance)    
    
    C = cov(dataBase);
    [coeff, s, v] = svd(C);
    a=0;
    latent = diag(s);
    
    for i=1:length(latent)
        if latent(i) < 1 && a==0 
             a = i;
        end
    end 
    
    a = a-1;
    
    coeff = coeff(:,1:a);
    score = dataBase*coeff;

end

