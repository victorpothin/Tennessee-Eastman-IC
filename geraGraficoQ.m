function geraGraficoT2( phi, philim)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    grafico = [];
    
    for i = 1:size(phi,2) 
         grafico(i,:)= [phi(i), philim ];
    end

    %figure(5)%figure Q com filtro
    subplot(1,3,3)
    plot(grafico(:,1:end),'DisplayName','grafico(:,7:end)','LineWidth',2)
    xlabel('Time (h)');
    legend('Q','threshold do Q')

end

