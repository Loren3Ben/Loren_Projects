clc;clear;

%%%2.1摄像头参数初始化
%内参
focalLength    = [309.4362, 344.2161]; % [fx, fy] in pixel units 309.4362, 344.2161
principalPoint = [318.9034, 257.5352]; % [cx, cy] optical center in pixel coordinates 318.9034, 257.5352
imageSize      = [480, 640];           % [nrows, mcols]
camIntrinsics = cameraIntrinsics(focalLength, principalPoint, imageSize);
% 外参
height = 2.1798;    % mounting height in meters from the ground
pitch  = 14;        % pitch of the camera in degrees
% 构造
sensor = monoCamera(camIntrinsics, height, 'Pitch', pitch);

%%%2.2导入视频帧
% 导入视频
videoName = 'C:\Users\Loren_Ben\Desktop\&\网球车\3.mp4';
videoReader = VideoReader(videoName);
% 读取感兴趣的视频帧
timeStamp = 0.06667;                   % time from the beginning of the video
videoReader.CurrentTime = timeStamp;   % point to the chosen frame
frame = readFrame(videoReader); % read frame at timeStamp seconds
imshow(frame) % display frame

%%%2.3创建鸟瞰图（birdsEyeView）
% 在车辆坐标系下定义转换成BirdsEyeView的区域，前方3-30米，左右各6米，配置鸟瞰图大小属性
distAheadOfSensor = 30; % in meters, as previously specified in monoCamera height input
spaceToOneSide    = 6;  % all other distance quantities are also in meters
bottomOffset      = 3;
outView   = [bottomOffset, distAheadOfSensor, -spaceToOneSide, spaceToOneSide]; % [xmin, xmax, ymin, ymax]
imageSize = [NaN,250]; % output image width in pixels; height is chosen automatically to preserve units per pixel ratio
birdsEyeConfig = birdsEyeView(sensor, outView, imageSize);
% 转换为鸟瞰图
birdsEyeImage = transformImage(birdsEyeConfig, frame);
figure
imshow(birdsEyeImage)

%%%2.4车道线位置
% 转换为灰度图
birdsEyeImage = rgb2gray(birdsEyeImage);
figure(1)
imshow(birdsEyeImage)

% 检测车道线
laneSensitivity = 0.25;
birdsEyeViewBW = segmentLaneMarkerRidge(birdsEyeImage, birdsEyeConfig, approxLaneMarkerWidthVehicle,'ROI', vehicleROI, 'Sensitivity', laneSensitivity);
figure(2)
imshow(birdsEyeViewBW)

%%%2.5车道线建模
% 将像素坐标系下车道线点转化到车辆坐标系
[imageX, imageY] = find(birdsEyeViewBW);
xyBoundaryPoints = imageToVehicle(birdsEyeConfig, [imageY, imageX]);

% 拟合出最多两条车道线的二次曲线
maxLanes = 2; % look for maximum of two lane markers
boundaryWidth = 3*approxLaneMarkerWidthVehicle; % expand boundary width
[boundaries, boundaryPoints] = findParabolicLaneBoundaries(xyBoundaryPoints,boundaryWidth, 'MaxNumBoundaries', maxLanes, 'validateBoundaryFcn', @validateBoundaryFcn);




