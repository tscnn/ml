function [ output_image ] = deepDOG( img, nonlin, sigma1, k, hsize )
% One iteration/layer of a Deep DOG Network
% img is input image
% nonlin chooses the non linearity
% k, sigma, hsize are explained in dog function

if strcmp(nonlin,'none')
    output_image = dog(img, sigma1, k, hsize);
elseif strcmp(nonlin,'max')
    output_image = max(dog(img, sigma1, k, hsize), 0);
elseif strcmp(nonlin,'square')
    output_image = (dog(img, sigma1, k, hsize)).^2;
end    

end

