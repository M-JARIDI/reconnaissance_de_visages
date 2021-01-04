

function rate = classification(nb_classes, num_classes, train_component, attributs, nb_bins,nb_images_per_class, radius, nb_voisinages, mapping,path)
    nb_ima_train = 6;
    comp_test = 1;
    counter = 0;
    for i=1:nb_classes * nb_images_per_class
        if(mod(i,2) == 0)
            num_classe_origin = floor((i-1)/nb_images_per_class) + 1;
            num_image =  mod(i-1,12) + 1;
            if(num_image < 10)
                fichier_test = [path int2str(num_classe_origin) '-0' int2str(num_image) '.jpg'];
            else
                fichier_test = [path int2str(num_classe_origin) '-' int2str(num_image) '.jpg'];
            end
            
            given_image = rgb2gray(imread(fichier_test));
            given_image_gray_lbp= lbp(given_image, radius, nb_voisinages, mapping,'h');
            
            [max_distance,returned_image] = ppv_manhattan(given_image_gray_lbp, train_component, attributs, nb_bins);
            
            if(num_classe_origin == num_classes(returned_image))
               counter = counter + 1; 
            end
            if(i < 599) %pour ne pas depasser 300
                comp_test = comp_test + 1;
            end
        end
    end

        rate=((counter/(nb_classes*nb_ima_train) ) * 100 );
end

