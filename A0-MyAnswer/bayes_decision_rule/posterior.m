function p = posterior(x)
%POSTERIOR Two Class Posterior Using Bayes Formula
%
%   INPUT:  x, features of different class, C-By-N vector
%           C is the number of classes, N is the number of different feature
%
%   OUTPUT: p,  posterior of each class given by each feature, C-By-N matrix
%

[C, N] = size(x);
l = likelihood(x);
%TODO

% 总的样本数
total = sum(sum(x));
% 每一类的样本数
total_category = sum(x, 2);
% 每一类的概率
p_w = total_category / total;
p = zeros(C, N);
for i=1: C
    for j=1: N
        cur_p = p_w(i) * l(i, j);
        cur_p = cur_p / (l(1, j) * p_w(1) + l(2, j) * p_w(2));
        p(i, j) = cur_p;
    end
end
end
