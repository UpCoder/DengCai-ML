% You can use this skeleton or write your own.
% You are __STRONGLY__ suggest to run this script section-by-section using Ctrl+Enter.
% See http://www.mathworks.cn/cn/help/matlab/matlab_prog/run-sections-of-programs.html for more details.

%% Part1: Preceptron
% nRep = 1000; % number of replicates
% nTrain = 100; % number of training data
% nTest = 1000; % number of testing data
% iter_sum = 0;
% training_error_rate = 0.0;
% testing_error_rate = 0.0;
% for i = 1:nRep
%     [X, y, w_f] = mkdata(nTrain);
%     [w_g, iter] = perceptron(X, y);
%     % Compute training, testing error
%     % first compute training error rate
%     X_augmented = [ones(1, nTrain); X];
%     predict_y = w_g' * X_augmented;
%     error_count = 0.0;
%     for index=1:nTrain
%         if predict_y(1, index) * y(1, index) <0
%             error_count = error_count + 1.0;
%         end
%     end
%     training_error_rate = training_error_rate + error_count / nTrain;
%     
%     % second compute testing error
%     dim = 2;
%     X_test = rand(dim, nTest)*(range(2)-range(1)) + range(1);
%     X_test = [ones(1, nTest); X_test];
%     true_y = w_f' * X_test;
%     predict_y = w_g' * X_test;
%     error_count = 0.0;
%     for index=1:nTrain
%         if predict_y(1, index) * true_y(1, index) <0
%             error_count = error_count + 1.0;
%         end
%     end
%     testing_error_rate = testing_error_rate + error_count / nTest;
%     % Sum up number of iterations
%     iter_sum = iter_sum + iter;
% end
% display(sprintf('The average training error rate is %f while the size of training dataset is %d', training_error_rate / nRep, nTrain));
% display(sprintf('The average training error rate is %f while the size of testing dataset is %d', testing_error_rate / nRep, nTest));
% display(sprintf('The average number of iter is %d while the size of training dataset is %d', iter_sum / nRep, nTrain));
% plotdata(X, y, w_f, w_g, 'Pecertron');

%% Part2: Preceptron: Non-linearly separable case
% nTrain = 100; % number of training data
% [X, y, w_f] = mkdata(nTrain, 'noisy');
% [w_g, iter] = perceptron(X, y);
% plotdata(X, y, w_f, w_g, 'Pecertron');

%% Part3: Linear Regression
% nRep = 1000; % number of replicates
% nTrain = 100; % number of training data
% nTest = 1000; % number of testing data
% training_error_rate = 0.0;
% testing_error_rate = 0.0;
% for i = 1:nRep
%     [X, y, w_f] = mkdata(nTrain);
%     w_g = linear_regression(X, y);
%     % Compute training, testing error
%     % first compute training error
%     predict_y = w_g' * [ones(1, nTrain); X];
%     predict_y(predict_y < 0) = -1;
%     predict_y(predict_y > 0) = 1;
%     error_count = sum(predict_y ~= y);
%     training_error_rate = training_error_rate + error_count / nTrain;
%     
%     % second compute testing error
%     X_test = rand(dim, nTest)*(range(2)-range(1)) + range(1);
%     X_test = [ones(1, nTest); X_test];
%     true_y = w_f' * X_test;
%     predict_y = w_g' * X_test;
%     true_y(true_y < 0) = -1;
%     true_y(true_y > 0) = 1;
%     predict_y(predict_y < 0) = -1;
%     predict_y(predict_y > 0) = 1;
%     error_count = sum(predict_y ~= true_y);
%     testing_error_rate = testing_error_rate + error_count / nTest;
% end
% fprintf('E_train is %f, E_test is %f.\n', training_error_rate / nRep, testing_error_rate / nRep);
% plotdata(X, y, w_f, w_g, 'Linear Regression');

%% Part4: Linear Regression: noisy
% nRep = 1000; % number of replicates
% nTrain = 100; % number of training data
% nTest = 100; % number of testing data
% training_error_rate = 0.0;
% testing_error_rate = 0.0;
% for i = 1:nRep
%     [X, y, w_f] = mkdata(nTrain, 'noisy');
%     w_g = linear_regression(X, y);
%     % Compute training, testing error
%     % first compute training error
%     predict_y = w_g' * [ones(1, nTrain); X];
%     predict_y(predict_y < 0) = -1;
%     predict_y(predict_y > 0) = 1;
%     error_count = sum(predict_y ~= y);
%     training_error_rate = training_error_rate + error_count / nTrain;
%     
%     % second compute testing error
%     [X_test, ~, ~] = mkdata(nTest, 'noisy');
%     X_test = [ones(1, nTest); X_test];
%     true_y = w_f' * X_test;
%     predict_y = w_g' * X_test;
%     true_y(true_y < 0) = -1;
%     true_y(true_y > 0) = 1;
%     predict_y(predict_y < 0) = -1;
%     predict_y(predict_y > 0) = 1;
%     error_count = sum(predict_y ~= true_y);
%     testing_error_rate = testing_error_rate + error_count / nTest;
% end
% fprintf('E_train is %f, E_test is %f.\n', training_error_rate / nRep, testing_error_rate / nRep);
% plotdata(X, y, w_f, w_g, 'Linear Regression: noisy');

%% Part5: Linear Regression: poly_fit
% load('poly_train', 'X', 'y');
% load('poly_test', 'X_test', 'y_test');
% w = linear_regression(X, y);
% % Compute training, testing error
% size_train = size(X);
% predict_y = w' * [ones(1, size_train(2)); X];
% predict_y(predict_y < 0) = -1;
% predict_y(predict_y > 0) = 1;
% error_count = sum(y~=predict_y);
% E_train = (1.0 * error_count) / size_train(2);
% 
% size_test = size(X_test);
% predict_y = w' * [ones(1, size_test(2)); X_test];
% predict_y(predict_y < 0) = -1;
% predict_y(predict_y > 0) = 1;
% error_count = sum(y_test ~= predict_y);
% E_test = (1.0 * error_count) / size_test(2);
% fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
% 
% % poly_fit with transform
% X_t = [X; X(1, :).* X(2, :); X(1, :).* X(1, :); X(2, :).* X(2, :)]; % CHANGE THIS LINE TO DO TRANSFORMATION
% X_test_t = [X_test; X_test(1, :).* X_test(2, :); X_test(1, :).* X_test(1, :); X_test(2, :).* X_test(2, :)]; % CHANGE THIS LINE TO DO TRANSFORMATION
% w = linear_regression(X_t, y);
% % Compute training, testing error
% size_train = size(X);
% predict_y = w' * [ones(1, size_train(2)); X_t];
% predict_y(predict_y < 0) = -1;
% predict_y(predict_y > 0) = 1;
% error_count = sum(y~=predict_y);
% E_train = (1.0 * error_count) / size_train(2);
% 
% size_test = size(X_test);
% predict_y = w' * [ones(1, size_test(2)); X_test_t];
% predict_y(predict_y < 0) = -1;
% predict_y(predict_y > 0) = 1;
% error_count = sum(y_test ~= predict_y);
% E_test = (1.0 * error_count) / size_test(2);
% fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
%% Part6: Logistic Regression
% nRep = 100; % number of replicates
% nTrain = 100; % number of training data
% nTest = 1000;  % number of testing dtaa
% E_train = 0.0;
% E_test = 0.0;
% for i = 1:nRep
%     [X, y, w_f] = mkdata(nTrain);
%     w_g = logistic(X, y);
%     % Compute training, testing error
%     
%     predict_y = w_g' * [ones(1, nTrain); X];
%     predict_y(predict_y < 0.5) = -1;
%     predict_y(predict_y > 0.5) = 1;
%     error_count = sum(predict_y ~= y);
%     E_train = E_train + error_count / nTrain;
%     
%     [X_test, ~, ~] = mkdata(nTest);
%     true_y = w_f' * [ones(1, nTest); X_test];
%     predict_y = w_g' * [ones(1, nTest); X_test];
%     predict_y(predict_y < 0.5) = -1;
%     predict_y(predict_y > 0.5) = 1;
%     true_y(true_y < 0.5) = -1;
%     true_y(true_y > 0.5) = 1;
%     error_count = sum(predict_y ~= true_y);
%     E_test = E_test + error_count / nTest;
% end
% 
% fprintf('E_train is %f, E_test is %f.\n', E_train / nRep, E_test / nRep);
% plotdata(X, y, w_f, w_g, 'Logistic Regression');

%% Part7: Logistic Regression: noisy
% nRep = 100; % number of replicates
% nTrain = 100; % number of training data
% nTest = 10000; % number of training data
% E_train = 0.0;
% E_test = 0.0;
% for i = 1:nRep
%     [X, y, w_f] = mkdata(nTrain, 'noisy');
%     w_g = logistic(X, y);
%     % Compute training, testing error
%     
%     predict_y = w_g' * [ones(1, nTrain); X];
%     predict_y(predict_y < 0.5) = -1;
%     predict_y(predict_y > 0.5) = 1;
%     error_count = sum(predict_y ~= y);
%     E_train = E_train + error_count / nTrain;
%     
%     [X_test, ~, ~] = mkdata(nTest);
%     true_y = w_f' * [ones(1, nTest); X_test];
%     predict_y = w_g' * [ones(1, nTest); X_test];
%     predict_y(predict_y < 0.5) = -1;
%     predict_y(predict_y > 0.5) = 1;
%     true_y(true_y < 0.5) = -1;
%     true_y(true_y > 0.5) = 1;
%     error_count = sum(predict_y ~= true_y);
%     E_test = E_test + error_count / nTest;
% end
% 
% fprintf('E_train is %f, E_test is %f.\n', E_train / nRep, E_test / nRep);
% plotdata(X, y, w_f, w_g, 'Logistic Regression: noisy');

%% Part8: SVM
nRep = 100; % number of replicates
nTrain = 100; % number of training data
nTest = 1000; % number of training data
E_train = 0.0;
E_test = 0.0;
average_sv = 0.0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    [w_g, num_sc] = svm(X, y);
    % Compute training, testing error
    
    predict_y = w_g' * [ones(1, nTrain); X];
    predict_y(predict_y < 0) = -1;
    predict_y(predict_y > 0) = 1;
    error_count = sum(predict_y ~= y);
    E_train = E_train + error_count / nTrain;
    
    [X_test, ~, ~] = mkdata(nTest);
    true_y = sign(w_f' * [ones(1, nTest); X_test]);
    predict_y = w_g' * [ones(1, nTest); X_test];
    predict_y(predict_y < 0) = -1;
    predict_y(predict_y > 0) = 1;
    error_count = sum(predict_y ~= true_y);
    E_test = E_test + error_count / nTest;
    % Sum up number of support vectors
    average_sv = average_sv + num_sc;
end

fprintf('E_train is %f, E_test is %f.\n', E_train / nRep, E_test / nRep);
fprintf('The average number of support vectors id %d \n', average_sv / nRep);
plotdata(X, y, w_f, w_g, 'SVM');
