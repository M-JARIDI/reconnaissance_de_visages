

function [taux,num_classe__] = classification(num_classes, train_component, attributs, nb_bins, radius, nb_voisinages, mapping)
    nb_classes = 50;
    nb_images_per_class = 8;
    path = '../../Ressources/Base_croped_images/';
    nb_ima_train = 4;
    comp_test = 1;
    counter = 0;
    num_classe_=zeros(nb_classes*nb_ima_train,1);
    for i=1:nb_classes * nb_images_per_class
        if(mod(i,2) == 0)
            num_classe_origin = floor((i-1)/nb_images_per_class) + 1;
            num_image =  mod(i-1,nb_images_per_class) + 1;
            if(num_image < 10)
                fichier_test = [path int2str(num_classe_origin) '-0' int2str(num_image) '.jpg'];
            else
                fichier_test = [path int2str(num_classe_origin) '-' int2str(num_image) '.jpg'];
            end
            given_image = imread(fichier_test);
            lbp_red = lbp(given_image(:,:,1), radius, nb_voisinages, mapping, 'h');
            lbp_green = lbp(given_image(:,:,2), radius, nb_voisinages, mapping, 'h');
            lbp_blue = lbp(given_image(:,:,3), radius, nb_voisinages, mapping, 'h');
            lbp_vector = [lbp_red lbp_green lbp_blue];
            given_image_lbp= lbp_vector;
            [max_distance,returned_image] = ppv_manhattan(given_image_lbp, train_component, attributs, nb_bins);
            num_classe_(comp_test) =num_classes(returned_image);
            if(num_classe_origin == num_classes(returned_image))
               counter = counter + 1;
            end
            if(i < 599) %pour ne pas depasser 300
                comp_test = comp_test + 1;
            end
        end
    end

        taux=((counter/(nb_classes*nb_ima_train) ) * 100 );
        num_classe__=num_classe_;
end