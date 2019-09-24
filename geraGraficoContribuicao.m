%Geração do gráfico de contrinuição
function [contrigraph] = geraGraficoContribuicao(dataTrain,dataTeste,philim,fault)

    %criação da matriz logica
    matrizlogica = [];

    for i= 1:41
       for j= 1:41
           if i == j
                matrizlogica(i,j) = 1;     
           end       
       end       
    end

    faultBin = dataTrain';

    M = philim^(1/2);

    dataContri = dataTeste(fault-15:fault+15, : );

    contrigraph = [];

    for j = 1:41
        for i = 1:30
            contrigraph(j,i) = (dataContri(i , :)*(matrizlogica(:, j))*M)^2;
        end
    end

end

