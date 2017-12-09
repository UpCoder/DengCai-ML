% mu: 2x1 matrix
% Sigma: 2x2 matrix
% phi: a number

mu0 = [0 0];
Sigma0 = [1 0; 0 1];
mu1 = [1 1];
Sigma1 = [1 0; 0 1];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Line', 1);
display('sub figure1 finish')

% 怎样将中心分布在同一侧？
mu0 = [4 0];
Sigma0 = [2 0; 0 10];
mu1 = [4 5];    
Sigma1 = [2 0; 0 10];    
phi = 0.3; 
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Line (one side)', 2);
display('sub figure2 finish')
% 
mu0 = [0 0];
Sigma0 = [1 0; 0 1];
mu1 = [1 1];
Sigma1 = [2 0; 0 1];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Parabalic', 3);
display('sub figure3 finish')
% 
mu0 = [0 0];
Sigma0 = [1 0; 0 5];
mu1 = [0 0];
Sigma1 = [4 0; 0 1];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Hyperbola', 4);
display('sub figure4 finish')
% 
mu0 = [0 0];
Sigma0 = [4 0; 0 4];
mu1 = [0 0];
Sigma1 = [1 0; 0 4];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Two parallel lines.', 5);
display('sub figure5 finish')
% 
mu0 = [10 10];
Sigma0 = [1 0; 0 1];
mu1 = [10 10];
Sigma1 = [2 0; 0 2];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Circle', 6);
display('sub figure6 finish')

mu0 = [5 5];
Sigma0 = [2 0; 0 2];
mu1 = [5 5];
Sigma1 = [10 0; 0 4];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Ellipsoid', 7);
display('sub figure7 finish')

mu0 = [0 0];
Sigma0 = [1 0; 0 1];
mu1 = [0 0];
Sigma1 = [1 0; 0 1];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'No boundary', 8);
display('sub figure8 finish')
