%Mark Asfour
%SID: 861098237
%04/18/2016
%CS 171
%PS 2

function [err] = regerr(w, X, Y)
    temp = ones(size(X, 1), 1);
    X = cat(2, temp, X);
    X = bsxfun(@times, X, w');
    err = sum((Y - sum(X, 2)) .^ 2);
end

