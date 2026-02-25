function L = emphasizeLaneFeatures(I, tau)
    Ipad = padarray(I, [0 double(tau)+1], 'replicate');
    Ileft  = single(Ipad(:,1:end-2*(tau+1)));
    Iright = single(Ipad(:,1+2*(tau+1):end));
    L = 2*single(I) - (Ileft+Iright) - (abs(Ileft - Iright));
    L = imnormalize(L);
end
