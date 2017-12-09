load('cluster_data', 'X');
% X = X(1:200, :);
% Choose proper parameters
k_in_knn_graph = 150;
threshold = 0.1;
% load w.mat W
W = knn_graph(X, k_in_knn_graph, threshold);
save w.mat W
idx = spectral(W, 2);
cluster_plot(X, idx);

figure;
idx = kmeans(X, 2);
cluster_plot(X, idx);
