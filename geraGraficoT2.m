function geraGraficoT2( phi, philim)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    grafico = [];
    
    for i = 1:size(phi,2) 
         grafico(i,:)= [phi(i), philim ];
    end

%     figure(3)%figure Q com filtro
    subplot(1,3,2)
    plot(grafico(:,1:end),'DisplayName','grafico(:,7:end)','LineWidth',2)
    xlabel('Time (h)');
    legend('T�','threshold do T�')

end

