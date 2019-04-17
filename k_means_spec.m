function [cluster_assignments] = k_means_spec(data, K, sigma)
    rng(847); % seed for constistent results
    [N, d] = size(data);
    cluster_assignments = zeros(N, 1);
    
    % form A matrix
    matrix_A = zeros(N, N);
    for i=1:N
        for j=1:N
            distance_ij = sqrt(sum((data(i,:) - data(j,:)) .^ 2));
            matrix_A(i, j) = exp(-distance_ij/(2*sigma^2));
            if(i == j)
                matrix_A(i, j) = 0;
            end
        end
    end
    matrix_D = zeros(N, N);
    for i=1:N
        matrix_D(i, i) = sum(matrix_A(i, :));
    end

    % construct the matrix L
    matrix_L = zeros(N, N);
    for i=1:N
        for j=1:N
            matrix_L(i,j) = matrix_A(i,j) / (sqrt(matrix_D(i,i)) * sqrt(matrix_D(j,j)));  
        end
    end

    % form the matrix X
    [eigenvectors, eigenvalues] = eig(matrix_L);
    matrix_X = zeros(N, K);
    size_eigenvectors = size(eigenvectors(1,:));
    size_eigen = size_eigenvectors(1,2);
    matrix_X(:, :) = eigenvectors(:, size_eigen-K+1:size_eigen);
    % form the matrix Y
    matrix_Y = normc(matrix_X);

    disp(size(matrix_Y));
    cluster_assignments = k_means(matrix_Y, K);
end