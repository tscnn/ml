function [ imgnone, imgmax, imgsquare ] = deepDOG( img, epochs, k, sigma, hsize )

imgnone = img;
imgmax = img;
imgsquare = img;

for layer = 1:epochs
    imgnone = dog(imgnone, k, sigma, hsize);
    imgmax = max(dog(imgmax, k, sigma, hsize),0);
    imgsquare = (dog(imgsquare, k, sigma, hsize)).^2;
end

end

