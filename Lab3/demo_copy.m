% First Harris Corner Detector Demo: The person_toy image.
imagePath1 = "person_toy/00000001.jpg";
blur_level1 = 3;
threshold1 = 143;
rotate1 = 0;
strength1 = 3;
harris_corner_detector(imagePath1, blur_level1, threshold1, rotate1, strength1);
rotate1 = 90;
threshold1 = 1;
harris_corner_detector(imagePath1, blur_level1, threshold1, rotate1, strength1);

imagePath2 = "pingpong/0000.jpeg";
blur_level2 = 1.7;
threshold2 = 10;
rotate2 = 0;
strength2 = 1;
harris_corner_detector(imagePath2, blur_level2, threshold2, rotate2, strength2);

