%Mark Asfour
%SID: 861098237
%6/1/2016
%CS 171
%PS5

function score = scorefn(x)
%gini score
score = 0;
for i = 1:size(x)
    score = score + (x(i) * (1 - x(i)));
end
end

