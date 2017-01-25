%Mark Asfour
%SID: 861098237
%04/18/2016
%CS 171
%PS 2

function [w, lambda, besterr] = cvridge(X, Y, nfold, lambdas)
errors = zeros(size(lambdas, 2), nfold);
rows = size(X, 1);
fold = rows / nfold;
%iterate through different lambdas
for i = 1:size(lambdas,2)
    lambda = lambdas(i);
    fold_err = [];
    %n fold cross validation
    %incrementing j by the size of each fold
    for j = 1:fold:(rows-fold  + 1)
        %split data into validation and training
        train_X = [];
        train_Y = [];
        %default case for training data. j = 1 is special case
        if j > 1
            train_X = X(1:(j-1), :);
            train_Y = Y(1:(j-1), :);
        end
        val_X = X(j:(j+fold-1),:);
        val_Y = Y(j:(j+fold-1),:);
        train_X = [train_X; X(j+fold:end, :)];
        train_Y = [train_Y; Y(j+fold:end, :)];
        
        %calculate w
        %append bias to the training data
        tempX = cat(2, ones(size(train_X, 1), 1), train_X);
        A = tempX' * tempX;
        c = tempX' * train_Y;
        identity = eye(size(A, 1));
        identity(1, 1) = 0;
        w = inv(A + (lambda * identity)) * c;
        
        %calculate the error for this fold
        fold_err = [fold_err; regerr(w, val_X, val_Y)/size(val_X, 1)];
    end
    %w_fold
    errors(i,:) = fold_err(:, 1);
end
%combine and average errors for each lambda
errors = sum(errors, 2);
errors = errors ./ nfold;
%plot
semilogx(lambdas, errors, 'bo-')
%return values
[besterr, index] = min(errors);
lambda = lambdas(index);
%calculate new w using found lambda
tempX = cat(2, ones(size(X, 1), 1), X);
A = tempX' * tempX;
c = tempX' * Y;
identity = eye(size(A, 1));
identity(1, 1) = 0;
w = inv(A + (lambda * identity)) * c;
end

