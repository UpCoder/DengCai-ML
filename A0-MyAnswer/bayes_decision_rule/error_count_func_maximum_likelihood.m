function error_count = error_count_func_maximum_likelihood(arr, label, likelihood, min_value)
    error_count = 0;
    [~, len] = size(arr);
    for i=1: len
        cur_number = arr(i) - min_value + 1;
        if likelihood(1, cur_number) > likelihood(2, cur_number)
            predict = 1;
        else
            predict = 2;
        end
        if predict ~= label
            error_count = error_count + 1;
        end
    end
end
