function [ dimg ] = dog( img, k, sigma1, hsize )
% based on http://stackoverflow.com/questions/20057146/is-there-any-difference-of-gaussians-function-in-matlab

if nargin < 4
    hsize = [3 3];
end

if nargin < 3
    sigma1 = 0.5;
end

if nargin < 2
    k = 10;
end

sigma2 = sigma1 * k;

h1 = fspecial('gaussian', hsize, sigma1);
h2 = fspecial('gaussian', hsize, sigma2);

gauss1 = imfilter(img,h1,'replicate');
gauss2 = imfilter(img,h2,'replicate');

dimg = gauss1 - gauss2;

% normalization
dimg = dimg / max(max(dimg));

end
