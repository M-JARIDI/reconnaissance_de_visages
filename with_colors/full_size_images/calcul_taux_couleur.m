

function [taux,num_classe__] = calcul_taux_couleur(num_classe, comp_train, attributs, nb_bins, rayon, nb_voisinages, mapping)
    nb_classe = 50;
    nb_image_par_class = 12;
    chemin = '../../Ressources/Base_original_images/';
    nb_ima_train = 6;
    comp_test = 1;
    compteur = 0;
    num_classe_=zeros(nb_classe*nb_ima_train,1);
    for i=1:nb_classe * nb_image_par_class
        if(mod(i,2) == 0)
            num_classe_origin = floor((i-1)/nb_image_par_class) + 1;
            num_image =  mod(i-1,nb_image_par_class) + 1;
            if(num_image < 10)
                fichier_test = [chemin int2str(num_classe_origin) '-0' int2str(num_image) '.jpg'];
            else
                fichier_test = [chemin int2str(num_classe_origin) '-' int2str(num_image) '.jpg'];
            end
            given_image = rgb2lab(imread(fichier_test));
            lbp_red = lbp(given_image(:,:,1), rayon, nb_voisinages, mapping, 'h');
            lbp_green = lbp(given_image(:,:,2), rayon, nb_voisinages, mapping, 'h');
            lbp_blue = lbp(given_image(:,:,3), rayon, nb_voisinages, mapping, 'h');
            lbp_vector = [lbp_red lbp_green lbp_blue];
            given_image_lbp= lbp_vector;
            [max_distance,returned_image] = ppv_manhattan(given_image_lbp, comp_train, attributs, nb_bins);
            num_classe_(comp_test) =num_classe(returned_image);
            if(num_classe_origin == num_classe(returned_image))
               compteur = compteur + 1;
            end
            if(i < 599) %pour ne pas depasser 300
                comp_test = comp_test + 1;
            end
        end
    end

        taux=((compteur/(nb_classe*nb_ima_train) ) * 100 );
        num_classe__=num_classe_;
end

