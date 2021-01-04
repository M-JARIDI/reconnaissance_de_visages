
clear;
close all;
clc;
nb_classes = 50;
nb_images_per_class = 12;
path = '../Ressources/Base_original_images/';
nb_image_train = 6;
nb_bins=4096;
radius = 2;
nb_voisinages = 12;
mode = 'h';
mapping=0;
tic();
% phase de la reconnaissance
[num_classes, attributs, train_component] = recongnize_faces(nb_bins, nb_classes, nb_image_train, nb_images_per_class, radius, nb_voisinages, mapping,mode, path);

%phase de la classification et décision
taux = classification(nb_classes, num_classes, train_component, attributs, nb_bins, nb_images_per_class, radius, nb_voisinages, mapping,path);
temps = toc();

disp(taux);
disp (temps);
        
        
        

