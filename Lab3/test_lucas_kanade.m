image_id = 'synth';
switch image_id
    case 'synth'
        image1 = imread('synth1.pgm');
        image2 = imread('synth2.pgm');
    case 'sphere'
        image1 = rgb2gray(imread('sphere1.ppm'));
        image2 = rgb2gray(imread('sphere2.ppm'));
     otherwise
        error("Image not found");
end 
region_size=15;
lucas_kanade(image1,image2,region_size);
