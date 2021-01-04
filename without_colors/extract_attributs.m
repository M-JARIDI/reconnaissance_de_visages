function attributs = extract_attributs(src_img, rayon, nb_voisinages, mapping, mode)
    
    ima_train = imread(src_img);
    ima_gray_train = rgb2gray(ima_train);
    attributs = lbp(ima_gray_train, rayon, nb_voisinages, mapping, mode);

end