require 'aprendizaje_maquina'

data = AprendizajeMaquina::Cargar.new("train.csv")
x = data.to_matrix(0)
y = data.to_vector(1)
x = x.add_ones

regression = AprendizajeMaquina::RegresionLineal.new(x,y)
regression.find_ecuation
prediction = regression.predict(Matrix[[1,95]])
puts prediction 