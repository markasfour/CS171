%Mark Asfour
%SID: 861098237
%6/1/2016
%CS 171
%PS5

function [Y, dt] = runq1()
A = load('banktrain.data');
trainX = A(:, 1:end-1);
trainY = A(:, end);
A = load ('banktestX.data');
testX = A;
ftype = [0, 12, 4, 8, 3, 3, 3, 2, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0];

%cv train = 75% of data
cvTrainX = trainX(1: .75 * size(trainX), :);
cvTrainY = trainY(1: .75 * size(trainY), :);
%validation = 25% of data
valX = trainX(.75 * size(trainX):end, :);
valY = trainY(.75 * size(trainY):end, :);

dt = learndt(cvTrainX, cvTrainY, ftype, @scorefn);
dt = prunedt(dt, valX, valY);
drawdt(dt)
Y = predictdt(dt, testX);
end

