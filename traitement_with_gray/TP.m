
clear;
close all;
clc;

nb_classe = 50;
nb_image_par_class = 12;
chemin = 'Ressources/BaseBase_original_images/';
nb_ima_train = 6;
% nb_bins_8 = 256;
nb_bins_12=4096;
% nb_bins_12_u2=135;
% nb_bins_12_ri=352;
% nb_bins_12_ri_u2=14;
% nb_bins_16=65536;
attributs = zeros(nb_classe * nb_ima_train, nb_bins_12);
num_classe = zeros(nb_classe * nb_ima_train, 1);
comp_train = 1;
rayon = 2;
nb_voisinages = 12;
mapping=0;% getmapping(nb_voisinages,'riu2');
tic();
for i=1:nb_classe * nb_image_par_class
    if(mod(i,2) ~= 0)
        num_classe(comp_train) = floor((i-1)/nb_image_par_class) + 1;
        num_image = 1 + mod(i-1,12);
        if(num_image < 10)
            fichier_train = [chemin int2str(num_classe(comp_train)) '-0' int2str(num_image) '.jpg'];
        else
            fichier_train = [chemin int2str(num_classe(comp_train)) '-' int2str(num_image) '.jpg'];
        end
        ima_train = imread(fichier_train);
        ima_gray_train = rgb2gray(ima_train);
        attributs(comp_train,:) = lbp(ima_gray_train, rayon, nb_voisinages, mapping, 'h');
        if(i < 599) %pour ne pas depasser 300
            comp_train = comp_train + 1;
        end
    end
end


[taux,classes] = calcul_taux(num_classe, comp_train, attributs,nb_bins_12, rayon, nb_voisinages, mapping);
temps = toc();

disp(taux);
disp (temps);
        
        
        

