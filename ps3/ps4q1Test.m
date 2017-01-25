%Mark Asfour
%SID: 861098237
%5/2/16
%CS 171
%PS3

function ps4q1Test(fname)
    A = load(fname);
    X = A(:, 1:2);
    temp = ones(size(X, 1), 1);
    X = [temp, X];
    Y = A(:, 3);
    %w0 = [1 -1 1];
    %learnperceptron(X, Y, 50, .5, w0, 1)
    w0 = [1 1 1];
    learnperceptron(X, Y, 1000, 0.1, w0, 1)
    %w0 = [100 100 100];
    %learnperceptron(X, Y, 100, 1, w0, 1)
end

