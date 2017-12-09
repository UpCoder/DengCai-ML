function error_count = error_count_func_optimal_bayes(arr, probability, likelihood, label)
    [~, len] = size(arr);
    error_count = 0;
    for i=1: len
        cur_number = arr(i);
        if probability(1, cur_number) > probability(2, cur_number)
            predict = 1;
        end
        if probability(1, cur_number) < probability(2, cur_number)
            predict = 2;
        end
        if probability(1, cur_number) == probability(2, cur_number)
            if likelihood(1, cur_number) > likelihood(2, cur_number)
                predict = 1;
            else
                predict = 2;
            end
        end
        if predict ~= label
            error_count = error_count + 1;
        end 
    end
end