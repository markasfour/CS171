%Mark Asfour
%SID: 861098237
%5/16/16
%CS 171
%PS4

function [ answer ] = runq1()
%load data
trainX = load('spamtrainX.data');
trainY = load('spamtrainY.data');
testX = load('spamtestX.data');
%different C values to test
C = logspace(-2, 3);
%init ans
answer = zeros(size(testX, 1), 1);

%split data for cross validation
%last 25% of data is used as validation
valX = trainX((size(trainX, 1) * .75) + 1:end, :);
valY = trainY((size(trainY, 1) * .75) + 1:end, :);
%use remaining as training
cvTrainX = trainX(1:(size(trainX, 1) * .75), :);
cvTrainY = trainY(1:(size(trainY, 1) * .75), :);
%error rates for each C value tested
err = zeros(1, size(C, 2));
%test different C values
for i = 1:size(C, 2)
    [w, b] = learnsvm(cvTrainX, cvTrainY, C(1, i));
    for j = 1:size(valX, 1)
       if valY(j, 1) * ((w' * valX(j,:)') + b) < 0
            err(1, i) = err(1, i) + 1;
        end
    end
end
err
[temp, index] = min(err);
Cpick = C(1, index)
[w, b] = learnsvm(cvTrainX, cvTrainY, Cpick);

%Generate preditions
for i = 1:size(testX, 1)
    if (w' * testX(i,:)') + b >= 0
        answer(i) = answer(i) + 1;
    else
        answer(i) = answer(i) - 1;
    end
end

end

