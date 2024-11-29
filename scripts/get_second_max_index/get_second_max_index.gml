function get_second_max_index(_lista) {
    var max1 = -1000; // Inicia con un número muy pequeño
    var max2 = -1000; // Inicia con un número muy pequeño
    var index1 = -1;
    var index2 = -1;

    // Encuentra el mayor número y su índice
    var lista_length = ds_list_size(_lista);
    for (var i = 0; i < lista_length; i++) {
        var current_value = ds_list_find_value(_lista, i);
        if (current_value > max1) {
            max2 = max1;   // Actualiza el segundo mayor
            index2 = index1;
            max1 = current_value;
            index1 = i;
        } else if (current_value > max2) {
            max2 = current_value;
            index2 = i;
        }
    }

    return index2;
}