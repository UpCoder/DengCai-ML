function idx = spectral(W, k)
%SPECTRUAL spectral clustering
%   Input:
%     W: Adjacency matrix, N-by-N matrix
%     k: number of clusters
%   Output:
%     idx: data point cluster labels, n-by-1 vector.

% YOUR CODE HERE
% [n,m] = size(W);  
% s = sum(W);
% D = full(sparse(1:n,1:n,s));
% E = D^(-1/2)*(D-W)*D^(-1/2);
% [Q,V] = eigs(E,k);                 %选的是前K个最大特征值对应的特征向量
% idx = kmeans(Q,k);
tmp_d = sum(W);
D = diag(tmp_d);
L = D-W;
D_m = diag(1./(tmp_d.^0.5));
L = D_m * L * D_m;

[V, ~] = eig(L);
V = V(:, k);
idx = kmeans(V, k);
end
