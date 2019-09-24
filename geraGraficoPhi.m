function geraGraficoPhi( phi, philim)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    grafico = [];
    
    for i = 1:size(phi,2) 
         grafico(i,:)= [phi(i), philim ];
    end

    figure(1)%figure Q com filtro
    subplot(1,3,1)
    plot(grafico(:,1:end),'DisplayName','grafico(:,7:end)','LineWidth',2)
    xlabel('Time (h)');
    legend('phi','threshold do phi')

end

