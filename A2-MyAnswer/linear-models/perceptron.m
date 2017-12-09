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
%% ������������
X = [ones(1, size_x(2)); X]; % �����൱�ڼ���bias�������ֵ��ͨ��wѧϰ�õ���
w = ones(size_x(1)+1, 1);
%% �����淶��
% iter = 1;
% learning_rate = 1.0;
% online_flag = false; % �ж���online train ����batch train
% while true
%     error_record=[];
%     predicts = w' * X;
%     for i=1:size_x(2)
%         % ����ÿһ��sample��˵�����������ǲ�������ѧϰ�ķ���
%         if w' * X(:, i) * y(1, i) <= 0
%             % ע�����������Ĺ淶��֮��Ĳ�����������Ҫ����y(1, i)����w������ȷ�ķ��򿿽�
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
%% �淶����������ֻ��Ҫ��0�ȶԾ�OK
X(:, y==-1) = -X(:, y==-1);
iter = 1;
learning_rate = 1.0;
online_flag = true; % �ж���online train ����batch train
while true
    error_record=[];
    predicts = w' * X;
    for i=1:size_x(2)
        % ����ÿһ��sample��˵�����������ǲ�������ѧϰ�ķ���
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
