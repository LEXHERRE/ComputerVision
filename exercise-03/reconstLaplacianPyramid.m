function [img] = reconstLaplacianPyramid(lpyramid)
    g = ([1, 4, 6, 4, 1])/16;
    pyramid_len = length(lpyramid);
    
    im = lpyramid[pyramid_len-1];

    for l = (pyramid_len-1:-1: 0)
        new_image = np.zeros(lpyramid[l-1].shape);

        new_image(1:2:end, 1:2:end) = img;
        
        filter_0 = conv2(new_image, 2*g,'reflect');
        new_image_filter = conv2(filter_0, g,'reflect');
        
        img = new_image_filter + lpyramid(l-1); 
    end
end