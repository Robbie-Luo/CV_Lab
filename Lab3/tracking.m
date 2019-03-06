function tracking(folderName, extension, outputName, blur_level, threshold, rotate, strength, region_size, ofConstant)
    imageNames = dir(folderName);
    outputVideo = VideoWriter(outputName);
    outputVideo.FrameRate = 15;
    open(outputVideo)
    n = 0;
    for ii = 1:length(imageNames)
        fname = imageNames(ii).name;
        ext = strfind(fname, extension);
        if ~isempty(ext)
            n = n + 1;
            thisImage = imread(strcat(folderName, fname));
            if ii == length(imageNames)
                imshow(thisImage);
                break
            end
            nextImage = imread(strcat(folderName, imageNames(ii+1).name));
            if mod(n-1,5) == 0
              corners = harris_corner_detector(thisImage, blur_level, threshold, rotate, strength);
            end
            [X,Y,U,V] = lucas_kanade(thisImage,nextImage,region_size,corners)
            X = X + ofConstant * U;
            Y = Y + ofConstant * V;
            plot(X, Y, 'bo')
            drawnow;
            frame = getframe;
            hold off
            writeVideo(outputVideo,frame);
        end
    end
    close(outputVideo)
end
