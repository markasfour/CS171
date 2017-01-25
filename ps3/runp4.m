function runp4

Iris = load('iris.dat','-ascii');
X = Iris(:,1:end-1);
Y = Iris(:,end);

TrainX = X(1:100,:);
TrainY = Y(1:100,:);

TestX = X(101:150,:);
TestY = Y(101:150,:);

% training... write multiclasslogreg
W = multiclasslogreg(TrainX,TrainY);

% testing... write multiclasseval
err = multiclasseval(W,TestX,TestY)
