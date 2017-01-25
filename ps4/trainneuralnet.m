%Mark Asfour
%SID: 861098237
%5/16/16
%CS 171
%PS4

function [W1, W2] = trainneuralnet(X,Y,nhid,lambda)
nhid
%set up points gridX
gridX = getgridpts(X);
temp = ones(size(gridX, 1), 1);
gridX = [temp, gridX];

%add 1s to X
temp = ones(size(X, 1), 1);
X = [temp, X];
%initialize W1 and W2
W1 = [rand(nhid, size(X, 2)).*2-1];
W2 = [rand(nhid+1, 1).*2-1];
%W1 = ones(nhid, size(X, 2));
%W2 = ones(nhid + 1, 1);

for j = 1:500000
    %set up deltaW
    SumDW1 = zeros(size(W1, 1), size(W1, 2));
    SumDW2 = zeros(size(W2, 1), size(W2, 2));
    eta = 1000 / (25000 + j);
    %run through all the X rows
    for i = 1:size(X, 1)
        [f, z] = forward_prop(X(i, :), W1, W2);  
        delta = f - Y(i, 1);
        d = backward_prop(delta, z, W2);
        [dw1, dw2] = update(eta, d(:, 2:end), delta, z, X(i,:));
        SumDW2 = SumDW2 + dw2';
        SumDW1 = SumDW1 + dw1;
    end
    %regularize
    SumDW1 = SumDW1 + (2 * lambda * W1);
    SumDW2 = SumDW2 + (2 * lambda * W2);
    if max(max(abs(SumDW1))) < .001
        if max(max(abs(SumDW2))) < .001
            1111111111
            W1
            W2
            break;
        end
    end
    W1 = W1 - (eta .* SumDW1);
    W2 = W2 - (eta .* SumDW2);
    %W1 = W1 + (eta * 2 * lambda * SumDW1);
    %W2 = W2 + (eta * 2 * lambda * SumDW2);
    %plot
    if mod(j, 1000) == 0
        j
        SumDW1
        SumDW2
        gridY = zeros(size(gridX, 1), 1);
        for k = 1:size(gridX, 1)
            [gridY(k, :), z_test] = forward_prop(gridX(k, :), W1, W2);
        end
        %size(gridY)
        %gridY = getgridpts(gridY);
        gridY(gridY > 0.5) = 1;
        gridY(gridY <= 0.5) = 0;
        gridX2 = gridX(:, 2:end);
        plotdecision(X(:, 2:end), Y, gridX2, gridY)
        drawnow 
    end
    
end
end

function [f, z] = forward_prop(X, w1, w2)
%calc a
%a1 = bsxfun(@times, w1, X);
%a1 = sum(a1, 2);
a1 = w1 * X(:);
%convert a to z
z = (1 + exp(-a1)).^(-1);
%add 1 to z
temp = ones(1, size(z, 2));
z = [temp; z];
%calc new a
%a2 = bsxfun(@times, w2', z');
%a2 = sum(a2, 2);
a2 = w2' * z;
%convert a to f
f = (1 + exp(-a2)).^(-1);
end

function [d] = backward_prop(delta, z, w)
    d = (z' * (1 - z)) .* w' * delta;
end

function [w1, w2] = update(eta, d, delta, z, X)
    %w2 = -eta * delta * z';
    %w1 = -eta .* (d' * X);
    w2 = delta * z';
    w1 = (d' * X);
end