%Mark Asfour
%SID: 861098237
%5/2/16
%CS 171
%PS3

function err = multiclasseval(w, X, Y)
classes = max(Y);

temp = ones(size(X, 1), 1);
X = [temp X];

h = zeros(size(X, 1), classes + 1);
for c = 1:classes + 1
   h(:, c) = X * w(:, c); 
end

counter = 0;
for a = 1:size(Y, 1)
     [m index] = max(h(a, :));
     %[a, index - 1, Y(a, 1)]
     if (index - 1) ~= Y(a, 1)
         counter = counter + 1;
     end
end

err = counter;
end

