function get_max_index(lista) {
    // Asegurarse de que la lista no esté vacía
    if (ds_list_size(lista) == 0) {
        return -1; // Devolver -1 si la lista está vacía
    }

    // Inicializar variables para el índice y el valor mayor
    var max_index = 0;
    var max_value = lista[| 0];

    // Iterar sobre la lista para encontrar el valor mayor
    for (var i = 1; i < ds_list_size(lista); i++) {
        if (lista[| i] > max_value) {
            max_value = lista[| i];
            max_index = i;
        }
    }

    // Devolver el índice del valor mayor
    return max_index;
}