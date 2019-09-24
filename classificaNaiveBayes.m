function  classificaNaiveBayes(baseTreinamento,baseValidacao)

    [trainedClassifier, validationAccuracy] = trainClassifierNaiveBayes(baseTreinamento);

    yfit = trainedClassifier.predictFcn(baseValidacao);

    baseClassificada = [baseValidacao yfit];

    y = trainedClassifier.ClassificationNaiveBayes.Y;

    C = confusionmat(y,yfit);

    figure(5);
    confusionchart(C);
    title('NaiveBayes');

end

