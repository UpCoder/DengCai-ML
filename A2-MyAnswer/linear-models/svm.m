function [w, num] = svm(X, y)
%SVM Support vector machine.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%
%   OUTPUT: w:    learned perceptron parameters, (P+1)-by-1 column vector.
%           num:  number of support vectors
%

% YOUR CODE HERE

size_x = size(X);
X = [ones(1, size_x(2));X];
H = eye(size(X, 1));
f = zeros(size(X, 1), 1);
new_y = [];
for i=1:size(X, 1)
    new_y = [new_y; y];
end
size(new_y);
A = - X' .* new_y';
b = -ones(size(X, 2), 1);
[w, ~, ~, ~, lambda] = quadprog(H, f,A, b);
num=sum(lambda.ineqlin > 1);

end
