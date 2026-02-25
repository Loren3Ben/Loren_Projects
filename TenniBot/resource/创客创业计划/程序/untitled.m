clc;clear all;
img = imread('C:\Users\Loren_Ben\Desktop\&\网球车\2.jpg');
img_gray = rgb2gray(img); 

n=graythresh(img);
BW = imbinarize(img_gray, n);

[M,N]=size(BW);
M1=ones(3,3);
BW1=(conv2(BW,M1)>1);




figure(1)
imshow(img_gray);
figure(2)
imhist(img_gray)
figure(3)
imshow(BW)
%BW2 = edge(BW1,'sobel');
%imshow(BW2);


%BW3 = edge(BW1,'canny');
%imshow(BW3);

