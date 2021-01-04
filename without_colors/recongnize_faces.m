

function [num_classes, attributs, train_component1] = recongnize_faces(nb_bins, nb_classes, nb_image_train, nb_images_per_class, radius, nb_voisinages, mapping,mode, path)
    attributs = zeros(nb_classes * nb_image_train, nb_bins);
    num_classes = zeros(nb_classes * nb_image_train, 1);
    train_component = 1;
    for i=1:nb_classes * nb_images_per_class
        if(mod(i,2) ~= 0)
            num_classes(train_component) = floor((i-1)/nb_images_per_class) + 1;
            num_image = 1 + mod(i-1,12);
            if(num_image < 10)
                fichier_train = [path int2str(num_classes(train_component)) '-0' int2str(num_image) '.jpg'];
            else
                fichier_train = [path int2str(num_classes(train_component)) '-' int2str(num_image) '.jpg'];
            end

            attributs(train_component,:) = extract_attributs(fichier_train, radius, nb_voisinages, mapping, mode);

            if(i < 599) %pour ne pas depasser 300
                train_component = train_component + 1;
            end
        end
    end
train_component1=train_component;
end