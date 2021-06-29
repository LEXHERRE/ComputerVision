function [lpim] = generateLaplacianPyramid(img,pyram,levels)
    g = ([1, 4, 6, 4, 1])/16;
    gaussianpyramid = [];
    laplacianpyramid = [];
    for l = (1:levels-1)
        gaussianpyramid = [gaussianpyramid img];
        
        % LP Filter
        filter_0 = convn(img, g);
        img_filter = convn(filter_0, g);

        img_filter_downsample = img_filter(1:2:end, 1:2:end);
        
        upsample_img = zeros(size(img));
        upsample_img(1:2:end, 1:2:end) = img_filter_downsample;
        
        filter_0 = conv2(upsample_img, 2*g,'reflect');
        upsample_img_filter = conv2(filter_0, g,'reflect');
        
        laplacian_step = img - upsample_img_filter;
        laplacianpyramid = [laplacianpyramid laplacian_step];
        
        img = img_filter_downsample;
    end

    laplacianpyramid(end) = gaussianpyramid(end);

    if pyram == 'lap'
        lpim = laplacianpyramid;
    elseif pyram == 'gauss'
        lpim = gaussianpyramid;
    else
        error('Error: Unknown pyramid type');
    end
end