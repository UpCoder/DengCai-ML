load('ORL_data', 'fea_Train', 'gnd_Train', 'fea_Test', 'gnd_Test');

% YOUR CODE HERE

% 1. Feature preprocessing
% 2. Run PCA
% 3. Visualize eigenface
% 4. Project data on to low dimensional space
% 5. Run KNN in low dimensional space
% 6. Recover face images form low dimensional space, visualize them
show_face(fea_Train);
[egivectors, ~] = pca(fea_Train);
faces_pca = egivectors;
show_face(faces_pca(:, 1:100)');


options = [];
options.Fisherface = 1;
[eigvectors_lda, ~] = LDA(gnd_Train, options, fea_Train);
train_low_dimension_lda = fea_Train*eigvectors_lda;
test_low_dimension_lda = fea_Test*eigvectors_lda;
k=knnclassify(test_low_dimension_lda,train_low_dimension_lda,gnd_Train,1,'euclidean','random');
acc = sum(k == gnd_Test) / (1.0 * length(k));
fprintf('Using LDA reduced dimension methond, accuracy is %f', acc);



low_dimensions_nums = [8, 16, 32, 64, 128];
for i=1:length(low_dimensions_nums)
    low_dimensional_num = low_dimensions_nums(i);
    A = egivectors(:, 1:low_dimensional_num);
    train_low_dimensional_data = fea_Train * A;
    test_low_dimensional_data = fea_Test * A;
    k=knnclassify(test_low_dimensional_data,train_low_dimensional_data,gnd_Train,1,'euclidean','random');
    acc = sum(k == gnd_Test) / (1.0 * length(k));
    fprintf('low dimensional number is %d, accuracy is %f', low_dimensional_num, acc);
end
for i=1:length(low_dimensions_nums)
    low_dimensional_num = low_dimensions_nums(i);
    A = egivectors(:, 1:low_dimensional_num);
    train_low_dimensional_data = fea_Train * A * A';
    show_face_ld(train_low_dimensional_data, low_dimensional_num);
end
