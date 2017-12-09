load('TDT2_data', 'fea', 'gnd');

% YOUR CODE HERE
options = [];
options.NeighborMode = 'KNN';
options.k = 200;
options.WeightMode = 'HeatKernel';
options.t = 10;
gnd(gnd==4)=1;
gnd(gnd==9)=2;
gnd(gnd==13)=3;
gnd(gnd==21)=4;
gnd(gnd==26)=5;
W = constructW(fea,options);
idx = spectral(W, 5);
newL2 = bestMap(gnd, idx);
acc = sum(newL2 == idx) / (1.0 * length(newL2));
mutual_information = MutualInfo(gnd, idx);
fprintf('acc is %f, mutual information is %f\n', acc, mutual_information);