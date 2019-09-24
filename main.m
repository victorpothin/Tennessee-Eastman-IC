%Arquivo contento a base histórica
clear all
clc

load('matlab.mat');

%taxa de variança 90% aplicar no PCA% 
variance = 90;

%------------------------- FASE DE PROJETO------------------------------

%Segunda região setpoint 22.89
[regiao,desPadReg,mediaReg] = padronizaBase(simoutFalha7(1:4000,:),0,0);

%Visualizaçao da variaveis de entrada
geraGraficoVariaveis(regiao);

%Aplica PCA para base treinamento do algoritmo
[regiao,NComponentes,~,~] = aplicaPCA(regiao,variance);

%Gera Estatisticas limiares T² 
[t2Lim,~,~] = geraEstatisticaLimiares(regiao,NComponentes,0,0);

% -------------------- FASE DE MONITORAMENTO------------------------

[dataTeste,~,~] = padronizaBase(simoutFalha7,desPadReg,mediaReg);

%Visualizaçao da variaveis de entrada
geraGraficoVariaveis(dataTeste);

%Aplica PCA para a base que será validada
[~,NComponentes,s,coeff] = aplicaPCA(dataTeste,variance);

%Gera Estatisticas limiares Q e Phi
[~,qLim,phiLim] = geraEstatisticaLimiares(0,NComponentes,s,t2Lim);

%Gera Estatistica T²,Q e Phi com filtro para  detecção de falha
[phi,t2f,qf,t2,q] = geraEstatistica(dataTeste,coeff,s,NComponentes,qLim,t2Lim);

%Gera Grafico com o valor de Phi
geraGraficoPhi(phi,phiLim);

%Gera Grafico com o valor de T2
geraGraficoT2(t2f,t2Lim);

%Gera Grafico com o valor de Q
geraGraficoQ(qf, qLim);

%chama a função fault_cont para verificiar qual é o momento da falha
[fault] = fault_cont(phi, phiLim, dataTeste);

%Gera o grafico de contribuição
if (fault>15)
    [contrigraph] = geraGraficoContribuicao(regiao,dataTeste,phiLim,fault);
end



