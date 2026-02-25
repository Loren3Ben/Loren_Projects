clc;clear;

%1摄像头参数初始化
%内参
focalLength    = [309.4362, 344.2161]; % [fx,fy] 以像素为单位 309.4362, 344.2161
principalPoint = [318.9034, 257.5352]; % [cx,cy] 像素坐标中的光学中心 318.9034, 257.5352
imageSize      = [540, 960];           % [nrows, mcols] 480, 640
camIntrinsics = cameraIntrinsics(focalLength, principalPoint, imageSize);
% 外参
height = 1.7;    % 距地面安装高度（以米为单位）2.1798
pitch  = 18;        % 相机的俯仰度（以度为单位）12
approxLaneMarkerWidthVehicle = 0.25;
% 构造
sensor = monoCamera(camIntrinsics, height, 'Pitch', pitch);

%2导入图片
frame = imread('C:\Users\Loren_Ben\Desktop\&\网球车\1.jpg');
figure(1)
imshow(frame) % display frame

%3创建鸟瞰图（birdsEyeView）
% 在车辆坐标系下定义转换成BirdsEyeView的区域，前方3-30米，左右各6米，配置鸟瞰图大小属性
distAheadOfSensor = 10; % 以米为单位，如之前在单摄像头高度输入中指定的那样
spaceToOneSide    = 8;  % 所有其他距离量也以米为单位
bottomOffset      = 3;
outView   = [bottomOffset, distAheadOfSensor, -spaceToOneSide, spaceToOneSide]; % [xmin, xmax, ymin, ymax]
imageSize = [NaN,250]; % 输出图像宽度（以像素为单位）;自动选择高度以保留单位每像素比率
birdsEyeConfig = birdsEyeView(sensor, outView, imageSize);
% 转换为鸟瞰图
birdsEyeImage = transformImage(birdsEyeConfig, frame);
figure(2)
imshow(birdsEyeImage)

%4车道线位置
% 转换为灰度图
birdsEyeImage = rgb2gray(birdsEyeImage);    
figure(3)
imshow(birdsEyeImage)
% 检测车道线
laneSensitivity = 0.25;
birdsEyeViewBW = segmentLaneMarkerRidge(birdsEyeImage, birdsEyeConfig, approxLaneMarkerWidthVehicle,'ROI', vehicleROI, 'Sensitivity', laneSensitivity);

figure(4)
imshow(birdsEyeViewBW)


%5车道线建模
% 将像素坐标系下车道线点转化到车辆坐标系
[imageX, imageY] = find(birdsEyeViewBW);
xyBoundaryPoints = imageToVehicle(birdsEyeConfig, [imageY, imageX]);

% 拟合出最多两条车道线的二次曲线
maxLanes = 2; % look for maximum of two lane markers
boundaryWidth = 3*approxLaneMarkerWidthVehicle; % expand boundary width
[boundaries, boundaryPoints] = findParabolicLaneBoundaries(xyBoundaryPoints,boundaryWidth, 'MaxNumBoundaries', maxLanes, 'validateBoundaryFcn', @validateBoundaryFcn);




