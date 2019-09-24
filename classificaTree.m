function classificaTree(baseTreinamento,baseValidacao)

    [trainedClassifier, validationAccuracy] = trainClassifierTree(baseTreinamento);

    yfit = trainedClassifier.predictFcn(baseValidacao);

    baseClassificada = [baseValidacao yfit];

    y = trainedClassifier.ClassificationTree.Y;

    C = confusionmat(y,yfit);
    
    figure(4);
    confusionchart(C);
    title('Tree');

end

