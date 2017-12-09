function [w, iter] = perceptron(X, y)
%PERCEPTRON Perceptron Learning Algorithm.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%
%   OUTPUT: w:    learned perceptron parameters, (P+1)-by-1 column vector.
%           iter: number of iterations
%

% YOUR CODE HERE
size_x = size(X);
size_y = size(y);
%% 增广特征向量
X = [ones(1, size_x(2)); X]; % 这里相当于加了bias，具体的值是通过w学习得到的
w = ones(size_x(1)+1, 1);
%% 不做规范化
% iter = 1;
% learning_rate = 1.0;
% online_flag = false; % 判断是online train 还是batch train
% while true
%     error_record=[];
%     predicts = w' * X;
%     for i=1:size_x(2)
%         % 对于每一个sample来说，在这里我们采用在线学习的方法
%         if w' * X(:, i) * y(1, i) <= 0
%             % 注意相比于下面的规范化之后的操作，这里需要乘以y(1, i)，让w想着正确的方向靠近
%             error_record = [X(:, i) * y(1, i), error_record];
%             if online_flag
%                 w = w + learning_rate * X(:, i) * y(1, i);
%                 iter = iter + 1;
%             end
%         end
%     end
%     if isempty(error_record)
%         break
%     end
%     if ~online_flag
%         w = w + learning_rate * sum(error_record, 2);
%         iter = iter + 1;
%     end
% end
%% 规范化，让我们只需要和0比对就OK
X(:, y==-1) = -X(:, y==-1);
iter = 1;
learning_rate = 1.0;
online_flag = true; % 判断是online train 还是batch train
while true
    error_record=[];
    predicts = w' * X;
    for i=1:size_x(2)
        % 对于每一个sample来说，在这里我们采用在线学习的方法
        if w' * X(:, i) <= 0
            error_record = [X(:, i), error_record];
            if online_flag
                w = w + learning_rate * X(:, i);
                iter = iter + 1;
            end
        end
    end
    if isempty(error_record)
        break
    end
    if ~online_flag
        w = w + learning_rate * sum(error_record, 2);
        iter = iter + 1;
    end
end
end
