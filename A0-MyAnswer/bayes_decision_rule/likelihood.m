function l = likelihood(x)
%LIKELIHOOD Different Class Feature Liklihood 
%
%   INPUT:  x, features of different class, C-By-N vector
%           C is the number of classes, N is the number of different feature
%
%   OUTPUT: l,  likelihood of each feature(from smallest feature to biggest feature) given by each class, C-By-N matrix
%

% N is 19  the dimentation of features is 19, it's the number of show
% C is 2 two classes
[C, N] = size(x);
l = zeros(C, N);
%TODO
row_sums = sum(x, 2);
for i=1:C
    for j=1:N
        l(i, j) = (1.0 * x(i, j)) / (1.0 * row_sums(i));
    end
end
end
