function runridge(filename,ntrain,ntest,nfold,lambdas)

D = load(filename,'-ascii');
%normally this data would be scrambled like
% D = D(randperm(size(D,1)),:)
% But that's already been done in the data file
Train = D(1:ntrain,:);
Test = D(ntrain+1:(ntrain+ntest),:);

scaling = findznormscale(Train(:,1:end-1));
Train(:,1:end-1) = applyscaling(Train(:,1:end-1),scaling);
% don't split into validation, because cvridge does n-fold cross-validation

[w,lambda] = cvridge(Train(:,1:end-1),Train(:,end),nfold,lambdas);

disp(['chosen: w= [' num2str(w') '] (using lambda=' num2str(lambda) ')']);

Test(:,1:end-1) = applyscaling(Test(:,1:end-1),scaling);

err = regerr(w,Test(:,1:end-1),Test(:,end))/size(Test,1);

disp(['testing error = ' num2str(err)]);
