function classificaKNN(baseTreinamento,baseValidacao)

    [trainedClassifier, validationAccuracy] = trainClassifierKNN(baseTreinamento);

    yfit = trainedClassifier.predictFcn(baseValidacao);

    baseClassificada = [baseValidacao yfit];

    y = trainedClassifier.ClassificationKNN.Y;

    C = confusionmat(y,yfit);

    figure(3);
    confusionchart(C);
    title('KNN');
    
end

