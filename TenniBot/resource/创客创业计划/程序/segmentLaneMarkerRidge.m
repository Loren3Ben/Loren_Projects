function birdsEyeBW = segmentLaneMarkerRidge(varargin) %#codegen
    %1.参数解析
    [birdsEyeImage, ROI, T, tau] = parseInputs(varargin{:});
    %2.车道线特征强化
    L = emphasizeLaneFeatures(birdsEyeImage, tau);
    %3.阈值设置与二值化图像
    BW = thresholdLaneFeatureImage(L, ROI, T);
    birdsEyeBW = cleanupBinaryMask(BW, ROI);
end
