clear all;
load('data.mat');

T = 500;

for t = 1:T
    [H,Alpha,error] = adaTrain(X,L,t);
    Ltrain = adaClassify(X,H,Alpha);
    train_error = sum(Ltrain ~= L) / size(L,1)

    plot(X(Ltrain==1,1),X(Ltrain==1,2),'ro'); hold on;
    plot(X(Ltrain==-1,1),X(Ltrain==-1,2),'bo');
    title(['trained, number of weak learners: ' int2str(t) ', error: ' num2str(error) ', train error: ' num2str(train_error)]);
    
    waitforbuttonpress;
end