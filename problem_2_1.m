% load UPS data

figure;
points_x = [0,-1,-3,1,3];
points_y = [0,2,6,-2,-6];
scatter(points_x, points_y);
saveas(gcf, 'problem-2-points-scatter.png');

X = [0 0; -1 2; -3 6; 1 -2; 3 -6;];
disp(size(X));
coeff = pca(X)