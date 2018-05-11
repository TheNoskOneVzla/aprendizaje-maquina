require 'aprendizaje_maquina'

data = AprendizajeMaquina::Cargar.new("data_lg.csv")
x = data.to_matrix(0..1).add_ones
y = data.to_vector(2)
theta = Vector[0,0,0]
rl = AprendizajeMaquina::ClasificacionLogistica.new(x,y,theta)

rl.train(12,0.01,'SGD')
prediction = rl.predict(Matrix[[1,9,22]])

if prediction == 1
	puts "cansado"
else
	puts "descansado"
end