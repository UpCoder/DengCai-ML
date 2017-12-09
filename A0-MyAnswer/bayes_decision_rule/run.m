% You can use this skeleton or write your own.
% You are __STRONGLY__ suggest to run this script section-by-section using Ctrl+Enter.
% See http://www.mathworks.cn/cn/help/matlab/matlab_prog/run-sections-of-programs.html for more details.

%%load data
load('data');
all_x = cat(2, x1_train, x1_test, x2_train, x2_test);
range = [min(all_x), max(all_x)];
train_x = get_x_distribution(x1_train, x2_train, range);
test_x = get_x_distribution(x1_test, x2_test, range);

%% Part1 likelihood: 
l = likelihood(train_x);

bar(range(1):range(2), l');
xlabel('x');
ylabel('P(x|\omega)');
axis([range(1) - 1, range(2) + 1, 0, 0.5]);

%TODO
%compute the number of all the misclassified x using maximum likelihood decision rule
error_count = 0;
% for i=range(1): range(2)
%     cur_number = i - range(1) + 1;
%     if l(1,cur_number) > l(2, cur_number)
%         error_count = error_count + test_x(2, cur_number);
%     else
%         error_count = error_count + test_x(1, cur_number);
%     end
% end
error_count = error_count + error_count_func_maximum_likelihood(x1_test, 1, l, range(1));
error_count = error_count + error_count_func_maximum_likelihood(x2_test, 2, l, range(1));

display(error_count)
%% Part2 posterior:
p = posterior(train_x);

bar(range(1):range(2), p');
xlabel('x');
ylabel('P(\omega|x)');
axis([range(1) - 1, range(2) + 1, 0, 1.2]);

%TODO
%compute the number of all the misclassified x using optimal bayes decision rule
error_count = 0;
% for i=range(1): range(2)
%     cur_number = i - range(1) + 1;
%     if p(1,cur_number) > p(2, cur_number)
%         error_count = error_count + test_x(2, cur_number);
%     else
%         error_count = error_count + test_x(1, cur_number);
%     end
% end
error_count = error_count + error_count_func_optimal_bayes(x1_test - range(1) + 1, p, l, 1);
error_count = error_count + error_count_func_optimal_bayes(x2_test - range(1) + 1, p, l, 2);
display(error_count)

%% Part3 risk:
risk = [0, 1; 2, 0];
%TODO
%get the minimal risk using optimal bayes decision rule and risk weights
R = 0.0;
[~, len] = size(p);
for x=1: len
    cur_number = x;
    min_value = 99999;
    for i=1: 2
        r_value = 0.0;
        for j=1:2
            r_value = r_value + risk(i, j) * p(j, cur_number);
        end
        min_value = min(r_value, min_value);
    end
    R = R + min_value;
end
R