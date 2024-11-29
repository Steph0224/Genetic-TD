n_inputs = 8
n_outputs = 6
//n_hidden = 0

//No training
w = create_random_matrix(n_outputs, n_inputs)
b = create_random_matrix(n_outputs, 1)

// poblacion de 15
//[ [ 0.06,1,-0.63,0.87,-0.55,-0.16,0.97,-0.07 ],[ 0.44,-0.28,-0.62,0.63,-1,0.64,-0.26,-1 ],[ -0.76,-0.55,-0.79,1,0.32,-0.70,-1,-0.68 ],[ -0.62,-0.96,-0.03,-0.96,-0.04,-0.86,0.12,-0.93 ],[ -0.62,-1,-0.42,-0.14,-1,-0.53,-1,-0.56 ],[ -0.43,-0.53,0.85,-0.41,-0.86,1,0.06,-0.80 ] ]
//[ [ -1 ],[ -0.50 ],[ 0.42 ],[ -0.40 ],[ -0.51 ],[ 0.23 ] ]

function evaluate(_x, _w = w, _b = b){
	return _matrix_sum(_matrix_multiply(w, _x), b)
}
