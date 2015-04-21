clear all;

%load expample image 1
image1 = double(rgb2gray(imread('image1.png')));
image1 = image1 / max(max(image1));
i1_none = image1;
i1_max = image1;
i1_square = image1;

%load example image 2
image2 = double(imread('image2.tiff'));
image2 = image2 / max(max(image2));
i2_none = image2;
i2_max = image2;
i2_square = image2;

%parameters for differences of gaussian
sigma1 = 0.25;
k = 1.5;
hsize = [5 5];

subplot(2,4,1);
imshow(image1);

subplot(2,4,5);
imshow(image2);
title('image2');

for t = 1:100
    
    %perform a layer of deepDOG
    i1_none = deepDOG(i1_none, 'none', sigma1, k, hsize);
    i1_max = deepDOG(i1_max, 'max', sigma1, k, hsize);
    i1_square = deepDOG(i1_square, 'square', sigma1, k, hsize);
    i2_none = deepDOG(i2_none, 'none', sigma1, k, hsize);
    i2_max = deepDOG(i2_max, 'max', sigma1, k, hsize);
    i2_square = deepDOG(i2_square, 'square', sigma1, k, hsize);
    
    %plot
    subplot(2,4,1);
    title({['epoche ',int2str(t)],'image1'});
    
    subplot(2,4,2);
    imshow(i1_none);
    title('no nonlinarity');

    subplot(2,4,3);
    imshow(i1_max);
    title('max');
    
    subplot(2,4,4);
    imshow(i1_square);
    title('square');
    
    subplot(2,4,6);
    imshow(i2_none);
    title('no nonlinarity');

    subplot(2,4,7);
    imshow(i2_max);
    title('max');
    
    subplot(2,4,8);
    imshow(i2_square);
    title('square');
    
    %wait for mouse click
    waitforbuttonpress;
    
end