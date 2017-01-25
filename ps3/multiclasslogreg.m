%Mark Asfour
%SID: 861098237
%5/2/16
%CS 171
%PS3

function w = multiclasslogreg(X, Y)
classes = max(Y);
Y0 = Y;
for c = 1:classes
    Y0 = [Y0, Y];
end
%Set up Ys
for i = 1:size(Y, 1)
    for c = 0:classes
        if Y0(i, c + 1) == c
           Y0(i, c + 1) = 1;
        else
           Y0(i, c + 1) = -1;
        end
    end
end

temp = ones(size(X, 1), 1);
X = [temp X];
w = zeros(size(X, 2), classes + 1);

for c = 1:(classes + 1)
    w(:, c) = learnlogreg(X, Y0(:, c), 0.01);
end

end

