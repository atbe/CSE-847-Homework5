function [cluster_assignments] = k_means(data, K)
    rng(847); % seed for constistent results
    [n, d] = size(data);
    cluster_assignments = zeros(n, 1);
    
    % choose random centroids
    centroids = rand(K,d);
%     disp(size(centroids));
    old_centroids = rand(K,d) * 10;
%     disp(centroids);
%     disp(old_centroids);
%     disp(norm(centroids - old_centroids));
    
    % termiate when centroids do not change
    while norm(centroids - old_centroids) > 0.001
        for i=1:n
            point = data(i,:);
%             disp(point);
            distances = sqrt(sum(bsxfun(@minus, point, centroids).^2,2));
%             disp(distances);

            % choose closest cluster
            cluster_assignments(i) = find(distances==min(distances));
%             disp(cluster_assignments(i));
        end
        
        old_centroids = centroids;
        for i=1:K
            centroid_points = zeros(0,d);
            % get all the points for this cluster i
            for j=1:n
                point = data(j,:);
                if cluster_assignments(j) == i
%                     disp(fprintf('Point below belongs to cluster %d', i));
%                     disp(point);
                    centroid_points = [centroid_points ; point];
                end
            end
            centroids(i,:) = mean(centroid_points, 1);
        end
        
%         disp("Finished iteration, here are the centroids before and after");
%         disp(old_centroids);
%         disp(centroids);
    end
end