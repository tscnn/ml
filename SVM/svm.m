function [w,b] = svm(X,Y,sx,sy)
% X is the data
% Y are the class labels
% sx is one support vector
% sy is its class

L = size(X,1); %number of data points
K = double(zeros(L,L));

for i=1:L
    for j=1:L
        K(i,j) = Y(i) * Y(j) * X(i,:) * (X(j,:))';
    end
end

%calculating classline with qudratic programming
H = K;
f = -ones(L,1);
A = [];
b = [];
Aeq = Y';
beq = 0;
lb = zeros(L,1);
ub = [];
x0 = [];
opts = optimset('Algorithm','interior-point-convex');

alpha = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,opts);

w = [0;0];
for i=1:L
	w = w + Y(i) * alpha(i) * X(i,:)';
end

b = w' * sx' - sy;
