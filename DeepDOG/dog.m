function [ dimg ] = dog( img, sigma1, k, hsize )
% Differences of gaussians
% img is input image
% sigma1 is standard deviation of Gauss filter
% k is standard deviation rate between the Gauss filters
% hsize is the size of the Gauss filter
% based on http://stackoverflow.com/questions/20057146/is-there-any-difference-of-gaussians-function-in-matlab

sigma2 = sigma1 * k;

h1 = fspecial('gaussian', hsize, sigma1);
h2 = fspecial('gaussian', hsize, sigma2);

gauss1 = imfilter(img,h1,'replicate');
gauss2 = imfilter(img,h2,'replicate');

dimg = gauss1 - gauss2;

% normalization
dimg = dimg / max(max(dimg));

end
