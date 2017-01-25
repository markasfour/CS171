%Mark Asfour
%SID: 861098237
%04/18/2016
%CS 171
%PS 2

function [err, C] = knntest(TrainX,TrainY,TestX,TestY,k,lnorm)
%storage for results
%cols = k values
C = zeros(3);

%Go through each valid element and find their k nearest neighbors
for j = 1:size(TestX)
    if lnorm == 2
        dist = sqrt(sum(bsxfun(@minus, TrainX, TestX(j,:)).^2, 2));
    else
        dist = sum(abs(bsxfun(@minus,TrainX, TestX(j,:))), 2);
    end
    %sort distances from least to greatest
    dist = [dist, TrainY];
    dist = sortrows(dist);
    
    %check correctness for this point
    check_0 = 0;
    check_1 = 0;
    check_2 = 0;
    for x = 1:k
        if dist(x, end) == 0
            check_0 = check_0 + 1;
        elseif dist(x, end) == 1
            check_1 = check_1 + 1;
        elseif dist(x, end) == 2
            check_2 = check_2 + 1;
        end  
    end
    check = [check_0, check_1, check_2];
    [z index] = max(check);
    C(index, TestY(j) + 1) = C(index, TestY(j) + 1) + 1;
end
%set return values
C = C ./ size(TestY,1);
err = 1 - C(1, 1) - C(2, 2) - C(3, 3);
end

