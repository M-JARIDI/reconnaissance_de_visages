
close all;
clear;
clc;

nb_classes = 50;
nb_images_per_class = 8;
path = '../../Ressources/Base_croped_images/';
nb_ima_train = 4;
nb_bins = 4096*3;
attributs = zeros(nb_classes * nb_ima_train, nb_bins);
num_classes = zeros(nb_classes * nb_ima_train, 1);
train_compenent = 1;
radius = 2;
nb_voisinages = 12;
mapping = 0;
tic();
% phase de la reconnaissance
for i=1:nb_classes * nb_images_per_class
    if(mod(i,2) ~= 0)
        num_classes(train_compenent) = floor((i-1)/nb_images_per_class) + 1;
        num_image = 1 + mod(i-1,nb_images_per_class);
        if(num_image < 10)
            fichier_train = [path int2str(num_classes(train_compenent)) '-0' int2str(num_image) '.jpg'];
        else
            fichier_train = [path int2str(num_classes(train_compenent)) '-' int2str(num_image) '.jpg'];
        end
        ima_train = imread(fichier_train);
        lbp_red = lbp(ima_train(:,:,1), radius, nb_voisinages, mapping, 'h');
        lbp_green = lbp(ima_train(:,:,2), radius, nb_voisinages, mapping, 'h');
        lbp_blue = lbp(ima_train(:,:,3), radius, nb_voisinages, mapping, 'h');
        lbp_vector = [lbp_red lbp_green lbp_blue];
        attributs(train_compenent,:) = lbp_vector;
        if(i < 399) %pour ne pas depasser 300
            train_compenent = train_compenent + 1;
        end
    end
end

% phase de la classification et déscision
[taux,classes] = classification(num_classes, train_compenent, attributs,nb_bins, radius, nb_voisinages, mapping);
temps = toc();

disp(taux);
disp (temps);
        
        