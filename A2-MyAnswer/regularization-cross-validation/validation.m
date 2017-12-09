%% Ridge Regression
load('digit_train', 'X', 'y');
load('digit_test', 'X_test', 'y_test');
% Do feature normalization
all_x = [X X_test];
all_x = zscore(all_x);
X = all_x(:, 1:size(X, 2));
X_test = all_x(:, size(X, 2) + 1: size(all_x, 2));

% Do LOOCV
lambdas = [1e-3, 1e-2, 1e-1, 0, 1, 1e1, 1e2, 1e3];
lambda = 0;
% E_Min = inf;
% for i = 1:length(lambdas)
%     E_val = 0;
%     for j = 1:size(X, 2)
%         X_ = [X(:, 1:j-1) X(:, j+1:size(X, 2))]; 
%         y_ = [y(:, 1:j-1) y(:, j+1:size(y, 2))]; % take point j out of X
%         w = ridge(X_, y_, lambdas(i));
%         predict = int32(w' * [1; X(:, j)]);
%         if predict < 0
%             predict = -1;
%         else
%             predict = 1;
%         end
%         E_val = E_val + (predict ~= y(j));
%     end
%     % Update lambda according validation error
%     if E_Min > E_val
%         lambda = lambdas(i);
%         E_Min = E_val;
%     end
%     fprintf('cur lambdas is %f, E_val is %d,sum of w is %f \n', lambdas(i), E_val, sum(w(2:size(w, 1)) .* w(2: size(w, 1))));
% end
% fprintf('chosen lambda is %f\n', lambda);
% % Compute training error
% for i = 1:length(lambdas)
%     w = ridge(X, y, lambdas(i));
%     predict_y = w' * [ones(1, size(X, 2)); X];
%     predict_y(predict_y < 0) = -1;
%     predict_y(predict_y > 0) = 1;
%     error_count = sum(predict_y ~= y);
%     train_error_rate = error_count / size(X, 2);
%     
%     predict_y = w' * [ones(1, size(X_test, 2)); X_test];
%     predict_y(predict_y < 0) = -1;
%     predict_y(predict_y > 0) = 1;
%     error_count = sum(predict_y ~= y_test);
%     test_error_rate = error_count / size(X_test, 2);
%     
%     fprintf('lambda: %f, training error rate is %f, testing error rate is %f\n', lambdas(i), train_error_rate, test_error_rate);
% end
%% Logistic
E_Min = inf;
lambda = 0.0;
for i = 1:length(lambdas)
    E_val = 0;
    for j = 1:size(X, 2)
        X_ = [X(:, 1:j-1) X(:, j+1:size(X, 2))]; 
        y_ = [y(:, 1:j-1) y(:, j+1:size(y, 2))]; % take point j out of X
        w = logistic_r(X_, y_, lambdas(i));
        predict = int32(w' * [1; X(:, j)]);
        if predict < 0
            predict = -1;
        else
            predict = 1;
        end
        E_val = E_val + (predict ~= y(j));
    end
    % Update lambda according validation error
    if E_Min > E_val
        lambda = lambdas(i);
        E_Min = E_val;
    end
    fprintf('cur lambdas is %f, E_val is %d,sum of w is %f \n', lambdas(i), E_val, sum(w(2:size(w, 1)) .* w(2: size(w, 1))));
end
fprintf('chosen lambda is %f\n', lambda);
for i = 1:length(lambdas)
    w = logistic_r(X, y, lambdas(i));
    predict_y = w' * [ones(1, size(X, 2)); X];
    predict_y(predict_y < 0) = -1;
    predict_y(predict_y > 0) = 1;
    error_count = sum(predict_y ~= y);
    train_error_rate = error_count / size(X, 2);
    
    predict_y = w' * [ones(1, size(X_test, 2)); X_test];
    predict_y(predict_y < 0) = -1;
    predict_y(predict_y > 0) = 1;
    error_count = sum(predict_y ~= y_test);
    test_error_rate = error_count / size(X_test, 2);
    
    fprintf('lambda: %f, training error rate is %f, testing error rate is %f\n', lambdas(i), train_error_rate, test_error_rate);
end
%% SVM with slack variable
