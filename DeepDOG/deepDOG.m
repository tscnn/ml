function [ imgnone, imgmax, imgsquare ] = deepDOG( img, epochs )

imgnone = img;
imgmax = img;
imgsquare = img;

for layer = 1:epochs
    
    imgnone = dog(imgnone);
    
    imgmax = max(dog(imgmax),0);
    
    imgsquare = (dog(imgsquare)).^2;
    
end

end

