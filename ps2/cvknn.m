%Mark Asfour
%SID: 861098237
%04/18/2016
%CS 171
%PS 2

function [k, lnorm] = cvknn(TrainX, TrainY, ValidX, ValidY, maxk)
%storage for results
%cols = k values
correctness_EUC = zeros (1, maxk);
correctness_MAN = zeros (1, maxk);

%iterate through different k values
for i = 1:2:maxk
    avg_EUC = 0;
    avg_MAN = 0;
    %Go through each valid element and find their k nearest neighbors
    for j = 1:size(ValidX)
        dist_EUC = sqrt(sum(bsxfun(@minus, TrainX, ValidX(j,:)).^2, 2));
        dist_MAN = sum(abs(bsxfun(@minus,TrainX, ValidX(j,:))), 2);
        %sort distances from least to greatest
        dist_EUC = [dist_EUC, TrainY];
        dist_EUC = sortrows(dist_EUC);
        dist_MAN = [dist_MAN, TrainY];
        dist_MAN = sortrows(dist_MAN); 
        
        %check correctness for this point
        check_EUC = 0;
        check_MAN = 0;
        for x = 1:i
            %if euclidean nn class matches validation data
            if dist_EUC(x, end) == ValidY(j)
                check_EUC = check_EUC + 1;
            end
            %if manhattan nn class matches validation data
            if dist_MAN(x, end) == ValidY(j)
                check_MAN = check_MAN + 1;
            end
        end 
        %check_EUC = check_EUC / i;
        if check_EUC < i/2
            avg_EUC = avg_EUC + 1;
        end
        %check_MAN = check_MAN / i;
        if check_MAN < i/2
            avg_MAN = avg_MAN + 1;
        end
    end
    avg_EUC = avg_EUC / size(ValidX, 1);
    avg_MAN = avg_MAN / size(ValidX, 1);
    correctness_EUC(1, i) = avg_EUC;
    correctness_MAN(1, i) = avg_MAN;
end

%set return values
k1 = min(correctness_EUC(1:2:maxk));
k1 = min(k1);
k2 = min(correctness_MAN(1:2:maxk));
k2 = min(k2);
k = 0;
if k1 <= k2
    for p = 1:2:maxk
    	if k1 == correctness_EUC(p)
            k = p;
            break;
        end
    end
    lnorm = 2;
else
    for p = 1:2:maxk
    	if k2 == correctness_MAN(p)
            k = p;
            break;
        end
    end
    lnorm = 1;
end
%plot
hold on;
correctness_EUC = correctness_EUC;
correctness_MAN = correctness_MAN;
plot((1:2:maxk), correctness_MAN(1:2:maxk), 'bo-');
plot((1:2:maxk), correctness_EUC(1:2:maxk), 'go-');
xlabel('k')
ylabel('error rate')
legend('Manhattan', 'Euclidean', 'Location', 'southeast')
hold off;
end

