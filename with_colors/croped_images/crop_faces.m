close all;
clear;
clc;
    nb_classes = 50;
    nb_images_per_class = 12;
    path = '../../Ressources/Base_original_images/';
    new_path = '../../Ressources/Base_croped_images/';
    j=1;
    for i=1:nb_classes * nb_images_per_class
            num_classe_origin = floor((i-1)/nb_images_per_class) + 1;
            num_image =  mod(i-1,12) + 1;
            
            if(num_image == 1 || num_image == 2 || num_image == 9 || num_image == 10 )
                continue;
            end
            if(num_image < 10)
                fichier_test = [path int2str(num_classe_origin) '-0' int2str(num_image) '.jpg'];
            else
                fichier_test = [path int2str(num_classe_origin) '-' int2str(num_image) '.jpg'];
            end
            given_image = imread(fichier_test);
            faceDetector = vision.CascadeObjectDetector;
            bboxes = step(faceDetector, given_image);
            if(size(bboxes,1) == 1)  
                croped_image = imcrop(given_image, bboxes);
            else
                croped_image = imcrop(given_image, bboxes(2,:));
            end
            chemin_croped_image = [new_path int2str(num_classe_origin) '-0' int2str(j) '.jpg'];
            imwrite(croped_image, chemin_croped_image);
            
            if(num_image == 12)
                j = 1;
            else
                j = j + 1;
            end
            disp('end cropping');
   end