%Mark Asfour
%SID: 861098237
%5/2/16
%CS 171
%PS3

function w = learnperceptron(X,Y,n,eta,w0,animate)
w = ones(size(X, 2), 1);
if animate == 1
    z = drawline(w0, 0);
    hold on
    for row = 1:size(Y, 1),
        if Y(row, 1) == -1
            p1 = plot(X(row, 2), X(row, 3), 'ro');
        elseif Y(row, 1) == 1
            p2 = plot(X(row, 2), X(row, 3), 'bx');
        end 
    end
    hold off
end

%n sweeps through the entire data set
for i = 1:n
    counter = 0;
    %go through entire data set
    for j = 1:size(X, 1)
        h = X(j, :) * w0';
        if h * Y(j) < 0
            w0 = w0 + (eta * Y(j) * X(j, :));
            counter = 0;
        else
            counter = counter + 1;
        end
        %plot progress
        if animate == 1
            delete(z);
            
            z = drawline(w0(2:3), w0(1));
            drawnow;
            pause(0.1);        
        end
    end
    if counter == size(X, 1)
        
        break;
    end
end
w = w0';
end

