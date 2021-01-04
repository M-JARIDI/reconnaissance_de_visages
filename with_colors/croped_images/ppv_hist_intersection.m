




function [max_distance,returned_image] = ppv_hist_intersection(given_image_gray_lbp, comp_train, attributs, nb_bins)
    S = zeros(comp_train,1);
    for i = 1 : comp_train
        S(i) = hist_intersection(given_image_gray_lbp, attributs(i,:), nb_bins);
    end
    [max_distance,returned_image] = max(S);
end



function distance = hist_intersection(vector_1, vector_2, length)
    distance_temp = 0;
    for i=1:length
        distance_temp = distance_temp + min(vector_1(i), vector_2(i));
    end
    distance = distance_temp;
end



