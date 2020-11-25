

function [taux,num_classe__] = calcul_taux(num_classe, comp_train, attributs, nb_bins, rayon, nb_voisinages, mapping)
    nb_classe = 50;
    nb_image_par_class = 12;
    chemin = 'Ressources/Base/';
    nb_ima_train = 6;
    comp_test = 1;
    compteur = 0;
    num_classe_=zeros(nb_classe*nb_ima_train,1);
    for i=1:nb_classe * nb_image_par_class
        if(mod(i,2) == 0)
            num_classe_origin = floor((i-1)/nb_image_par_class) + 1;
            num_image =  mod(i-1,12) + 1;
            if(num_image < 10)
                fichier_test = [chemin int2str(num_classe_origin) '-0' int2str(num_image) '.jpg'];
            else
                fichier_test = [chemin int2str(num_classe_origin) '-' int2str(num_image) '.jpg'];
            end
            given_image = rgb2gray(imread(fichier_test));
            given_image_gray_lbp= lbp(given_image, rayon, nb_voisinages, mapping,'h');
            [max_distance,returned_image] = ppv_manhattan(given_image_gray_lbp, comp_train, attributs, nb_bins);
            num_classe_(comp_test) =num_classe(returned_image);
            if(num_classe_origin == num_classe(returned_image))
               compteur = compteur + 1; 
%             else
%                 disp([ 'cause prob : ' fichier_train ]);
            end
            if(i < 599) %pour ne pas depasser 300
                comp_test = comp_test + 1;
            end
        end
    end

        taux=((compteur/(nb_classe*nb_ima_train) ) * 100 );
        num_classe__=num_classe_;
end

