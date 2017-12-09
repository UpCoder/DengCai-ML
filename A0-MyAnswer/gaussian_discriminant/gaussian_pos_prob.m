function p = gaussian_pos_prob(X, Mu, Sigma, Phi)
%GAUSSIAN_POS_PROB Posterior probability of GDA.
%   p = GAUSSIAN_POS_PROB(X, Mu, Sigma) compute the posterior probability
%   of given N data points X using Gaussian Discriminant Analysis where the
%   K gaussian distributions are specified by Mu, Sigma and Phi.
%
%   Inputs:
%       'X'     - M-by-N matrix, N data points of dimension M.
%       'Mu'    - M-by-K matrix, mean of K Gaussian distributions.
%       'Sigma' - M-by-M-by-K matrix (yes, a 3D matrix), variance matrix of
%                   K Gaussian distributions.
%       'Phi'   - 1-by-K matrix, prior of K Gaussian distributions.
%
%   Outputs:
%       'p'     - N-by-K matrix, posterior probability of N data points
%                   with in K Gaussian distributions.
N = size(X, 2);
K = length(Phi);
P = zeros(N, K);
p = zeros(N, K);
% Your code HERE
for i=1:N
    x = X(:, i);
    for j=1:K
        % 注意这里的Mu是以一维数组的形式传递进来的，所以不能通过Mu(:, j)的方式获取值
        start_index = (j-1)*K+1;
        end_index = j*K;
        u = Mu(start_index:end_index)';
        % u = Mu(:, j)
        covariance = Sigma(:, :, j);
        P(i, j) = (1.0 / (2.0 * pi * sqrt(det(covariance)))) * exp(-0.5 * (x-u)' * inv(covariance) * (x - u));
    end
end
for i=1:N
    px = 0.0;
    for j=1:K
        px = px + Phi(j) * P(i, j);
    end
    % px
    for j=1:K
        p(i, j) = Phi(j) * P(i, j) / px;
    end
end