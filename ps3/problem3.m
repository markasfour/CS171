%Mark Asfour
%SID: 861098237
%5/2/16
%CS 171
%PS3

function problem3()
    A = load('phishing.dat');
    
    lambdas = [.01, .1, 1, 10, 100, 1000];
    errors = zeros(2, size(lambdas, 2));
    
    X = A(:, 1:30);
    temp = ones(size(X, 1), 1);
    Xlinear = [temp, X];
    Y = A(:, 31);
    
    determined = zeros(size(Y, 1), 1);
    
    for l = 1:size(lambdas, 2);
        wlinear = learnlogreg(Xlinear, Y, lambdas(1, l));
        determined = Xlinear * wlinear;
        counter = 0;
        for a = 1:size(Y, 1)
            if determined(a, 1) * Y(a, 1) < 0
                counter = counter + 1;
            end
        end
        errors(1, l) = counter / size(Y, 1);
    end
    
    tempX = X;
    Xquad = X;
    for i = 1:size(X, 2)
        temp2 = bsxfun(@times, tempX(:, i), tempX(:, i:end));
        Xquad = [Xquad temp2];
    end
    Xquad = [temp, Xquad];
    for l = 1:size(lambdas, 2);
        wquad = learnlogreg(Xquad, Y, lambdas(1, l));
        determined = Xquad * wquad;
        counter = 0;
        for a = 1:size(Y, 1)
            if determined(a, 1) * Y(a, 1) < 0
                counter = counter + 1;
            end
        end
        errors(2, l) = counter / size(Y, 1);
    end
    success = ones(size(errors)) - errors;
    [mlinear, i1] = max(success(1, :));
    [mquad, i2] = max(success(2, :));
    m = [mlinear mquad];
    [mans, ians] = max(m);
    if ians == 1
        degree = 'linear';
        ians = i1;
    else
        degree = 'quadratic';
        ians = i2;
    end
    lans = lambdas(1, ians);
    answer = ['Selected model order is: ', degree, ...
              ' with regularization strenght = ', num2str(lans)];
    disp(answer);
end

