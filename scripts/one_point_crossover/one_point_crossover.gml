function one_point_crossover(parent1, parent2) {
    // Crear arrays para almacenar los hijos
    var child1 = [];
    var child2 = [];

    // Obtener la longitud de los padres
    var len = array_length(parent1);

    // Realizar el cruce en el punto medio (parte entera)
    var crossover_point = floor(len / 2);

    // Llenar child1 con la primera mitad de parent1 y la segunda mitad de parent2
    for (var i = 0; i < crossover_point; i++) {
        child1[i] = parent1[i];
    }
    for (var i = crossover_point; i < len; i++) {
        child1[i] = parent2[i];
    }

    // Llenar child2 con la primera mitad de parent2 y la segunda mitad de parent1
    for (var i = 0; i < crossover_point; i++) {
        child2[i] = parent2[i];
    }
    for (var i = crossover_point; i < len; i++) {
        child2[i] = parent1[i];
    }

    // Crear un array para almacenar ambos hijos
    var result = [child1, child2];

    return result;
}