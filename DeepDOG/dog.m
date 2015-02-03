function [ dog ] = dog( img, k, sigma, hsize )

if nargin < 4
    hsize = [3 3];
end

if nargin < 3
    sigma = 0.5;
end

if nargin < 2
    k = 10;
end

sigma2 = sigma * k;

h1 = fspecial('gaussian', hsize, sigma);
h2 = fspecial('gaussian', hsize, sigma2);

gauss1 = imfilter(img,h1,'replicate');
gauss2 = imfilter(img,h2,'replicate');

dog = gauss1 - gauss2;

end
