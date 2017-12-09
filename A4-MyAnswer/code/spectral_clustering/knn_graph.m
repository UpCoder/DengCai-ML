function W = knn_graph(X, k, threshold)
%KNN_GRAPH Construct W using KNN graph
%   Input: X - data point features, n-by-p maxtirx.
%          k - number of nn.
%          threshold - distance threshold.
%
%   Output:W - adjacency matrix, n-by-n matrix.

% YOUR CODE HERE

d = pdist(X) ;
d2 = squareform(d);
d3 = d2.^2;
W(:,:) = exp(-d3(:,:)/(2*threshold^2));


% n = size(X, 1);
% p = size(X, 2);
% W = zeros(n,n);
% for i=1:n
%     if mod(i, 1000) == 0
%         sprintf('%d\n', i)
%     end;
%     W(i,i) = 0;
%     for j=i+1:n
%         distance = calculate_distance(X(i, :), X(j, :), threshold);
%         W(i, j) = distance;
%         W(j, i) = W(i, j);
%     end
%     row = W(i, :);
%     [num, indexs] = sort(row);
%     row(indexs(1:length(row)-k)) = 0;
%     W(i, :) = row;
% end
end
function distance=calculate_distance(x1, x2, threshold)
    distance = ((x1(1) - x2(1)) ^ 2 + (x1(2) - x2(2)) ^ 2) ^ 0.5;
    distance = exp(-distance/(2*threshold^2));
end
