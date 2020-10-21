function[K_initial_positions] = generateInitialAssignments(Matrix, K)

[nr, nc] = size(Matrix);
% nr = number of signals
% nc = number of parameters of each signal

Matrix_min = min(min(Matrix));
Matrix_max = max(max(Matrix));

N = nc; 
M = K; % number of clusters

K_initial_positions = Matrix_min + (Matrix_max - Matrix_min)*rand(M,N);
