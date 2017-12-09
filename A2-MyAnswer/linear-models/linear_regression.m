function w = linear_regression(X, y)
%LINEAR_REGRESSION Linear Regression.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%
%   OUTPUT: w:    learned perceptron parameters, (P+1)-by-1 column vector.
%

% YOUR CODE HERE
size_x = size(X);
X = [ones(1, size_x(2)); X]; % 增广特征向量
w = inv(X * X') * X * y';
end
