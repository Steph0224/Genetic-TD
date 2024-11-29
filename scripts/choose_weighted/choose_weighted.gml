function choose_weighted(_probabilidades) {
    var size = ds_list_size(_probabilidades);
    
    // Generar un número aleatorio entre 0 y 1
    var random_value = random(1);
    
    // Acumulador de probabilidad
    var cumulative_prob = 0;
    
    // Seleccionar el índice basado en la probabilidad acumulada
    for (var i = 0; i < size; i++) {
        cumulative_prob += ds_list_find_value(_probabilidades, i);
        if (random_value < cumulative_prob) {
            return i;
        }
    }
}