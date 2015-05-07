%load the example data
load('data1.mat');

%execute the support vector machine
[w,b] = svm(X,Y,X(16,:),Y(16));

%visualize the data and the calculated classline
plot(X(Y==1,1), X(Y==1,2), 'ro');
hold on;
plot(X(Y==-1,1), X(Y==-1,2), 'bx');
plotClassLine(gcf,w,b,'k-');