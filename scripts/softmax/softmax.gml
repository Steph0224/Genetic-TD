function softmax(_lista) {
    var size = ds_list_size(_lista);

    // Crear una lista para almacenar los exponentes y las probabilidades
    var exp_list = ds_list_create();
    var prob_list = ds_list_create();
    
    // Calcular el exponente de cada elemento y la suma de los exponentes
    var sum_exp = 0;
    for (var i = 0; i < size; i++) {
        var value = ds_list_find_value(_lista, i);
        var exp_value = exp(value);
        ds_list_add(exp_list, exp_value);
        sum_exp += exp_value;
    }

    // Calcular las probabilidades normalizadas
    for (var i = 0; i < size; i++) {
        var exp_value = ds_list_find_value(exp_list, i);
        var prob = exp_value / sum_exp;
        ds_list_add(prob_list, prob);
    }

    // Destruir la lista temporal de exponentes
    ds_list_destroy(exp_list);

    return prob_list;
}