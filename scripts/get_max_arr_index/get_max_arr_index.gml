function get_max_arr_index(arr) {

	if (array_length(arr) == 0) {
        return -1; // Devolver -1 si el arreglo está vacío
    }

    // Inicializar variables para el índice y el valor mayor
    var max_index = 0;
    var max_value = arr[0][0];

    // Iterar sobre la lista para encontrar el valor mayor
    for (var i = 1; i < array_length(arr); i++) {
        if (arr[i][0] > max_value) {
            max_value = arr[i][0];
            max_index = i;
        }
    }

    // Devolver el índice del valor mayor
    return max_index;
}