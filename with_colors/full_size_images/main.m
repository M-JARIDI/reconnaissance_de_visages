

close all;
clear;
clc;

nb_classe = 50;
nb_image_par_class = 12;
chemin = '../../Ressources/Base_original_images/';
nb_ima_train = 6;
nb_bins_12=4096*3;
attributs = zeros(nb_classe * nb_ima_train, nb_bins_12);
num_classe = zeros(nb_classe * nb_ima_train, 1);
comp_train = 1;
rayon = 2;
nb_voisinages = 12;
mapping=0;
tic();
for i=1:nb_classe * nb_image_par_class
    if(mod(i,2) ~= 0)
        num_classe(comp_train) = floor((i-1)/nb_image_par_class) + 1;
        num_image = 1 + mod(i-1,nb_image_par_class);
        if(num_image < 10)
            fichier_train = [chemin int2str(num_classe(comp_train)) '-0' int2str(num_image) '.jpg'];
        else
            fichier_train = [chemin int2str(num_classe(comp_train)) '-' int2str(num_image) '.jpg'];
        end
        ima_train = rgb2lab(imread(fichier_train));
        lbp_red = lbp(ima_train(:,:,1), rayon, nb_voisinages, mapping, 'h');
        lbp_green = lbp(ima_train(:,:,2), rayon, nb_voisinages, mapping, 'h');
        lbp_blue = lbp(ima_train(:,:,3), rayon, nb_voisinages, mapping, 'h');
        lbp_vector = [lbp_red lbp_green lbp_blue];
        attributs(comp_train,:) = lbp_vector;
        if(i < 599) %pour ne pas depasser 300
            comp_train = comp_train + 1;
        end
    end
end


[taux,classes] = calcul_taux_couleur(num_classe, comp_train, attributs,nb_bins_12, rayon, nb_voisinages, mapping);
temps = toc();

disp(taux);
disp (temps);
        
        