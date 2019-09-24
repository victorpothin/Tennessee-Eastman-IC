    
%Fun��o para separar o que � dado de teste e o que � dado de treinamento
function [basePadronizada,desPad,media] = padronizaBase(base,desPadReg,mediaAmostralReg)
   
    desPad = 0;
    media = 0;
    tamanhobase = size(base);
    
    basePadronizada = zeros(tamanhobase(1,1),tamanhobase(1,2));
    
    for y=1:1:tamanhobase(1,2)
        
        %Media do modelo 
        if mediaAmostralReg(1,1) ~=0
            mediaAmostral = mediaAmostralReg(:,y); 
        else
            mediaAmostral = mean(base(:,y));
            media(1,y) = mediaAmostral;
        end
        
        %Desvio Padr�o modelo
        if desPadReg(1,1) ~= 0
            desvioPadrao = desPadReg(:,y);
        else
            desvioPadrao = std(base(:,y));
            desPad(1,y) = desvioPadrao;
        end
        
    
        basePadronizada(:,y) = (base(:,y) - mediaAmostral) / desvioPadrao;
                
    end
         
   
    basePadronizada(isnan(basePadronizada)) = 0;
    
end
