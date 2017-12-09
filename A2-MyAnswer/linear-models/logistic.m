function w = logistic(X, y)
%LR Logistic Regression.
%
%   INPUT:  X:   training sample features, P-by-N matrix.
%           y:   training sample labels, 1-by-N row vector.
%
%   OUTPUT: w    : learned parameters, (P+1)-by-1 column vector.
%

% YOUR CODE HERE
size_x = size(X);
size_y = size(y);
max_circle = 200;
w = ones(size_x(1) + 1, 1);
X = [ones(1, size_x(2)); X];
circle_number = 0;
learning_rate = 0.01;
y(y==-1) = 0; % 注意这里我们需要将-1转化为0，因为sigmoid函数取值是0~1，而不是-1~1
while circle_number < max_circle
    circle_number = circle_number + 1;
    prob_arr = h(w' * X);
    variance = cal_variance(y, prob_arr, X);
    w = w + learning_rate * variance;
end
end
function variance = cal_variance(y, predict, X)
    variance = (y - predict) * X';
    variance = variance';
end
function prob = h(x)
    prob = 1.0 ./ (1 + exp(-x));
end
