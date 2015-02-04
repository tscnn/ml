clear all;
load('image.mat');
image2 = imread('cameraman.tiff');
image2 = double(image2) / max(max(double(image2)));

for t = 1:100
    
    [imgnone, imgmax, imgsquare] = deepDOG(image2, t, 10, 0.5, [25 25]);
    
    subplot(1,3,1);
    imshow(imgnone);
    title('no nonlinarity');

    subplot(1,3,2);
    imshow(imgmax);
    title('max');
    
    subplot(1,3,3);
    imshow(imgsquare);
    title('square');
    
    waitforbuttonpress;
    
end