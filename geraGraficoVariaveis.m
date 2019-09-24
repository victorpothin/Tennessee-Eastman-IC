function geraGraficoVariaveis(dataBase)

    sensores = dataBase;
    
    figure(2);
    for i=1:34
       plot(normalize(sensores(:,i),'range',[i-1 i])); hold on;  
    end
    
    title('Medidas dos Sensores'); xlabel('Amostras'); ylabel('Nº do sensor'); hold off;
    
    %{
    legend('1-Feed concentration','2-Feed flowrate','3-Feed temperature','4-Reactor level','5-Product A concentration',...
        '6-Product B concentration','7-Reactor temperature','8-Coolant flowrate','9-Product flowrate','10-Coolant inlet temperature',...
        '11-Coolant inlet pressure','12-Level controller output','13-Coolant controller output','14-Coolant setpoint','Location','northeastoutside');
    %}
end



