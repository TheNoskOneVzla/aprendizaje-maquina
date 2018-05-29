# AprendizajeMaquina

Aprendizaje maquina is a gem that help us to write ruby machine learning algorithms. 

## Installation

Add this line to your application's Gemfile:

gem 'aprendizaje_maquina'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aprendizaje_maquina

## Usage

## linear regression model 

first

	require 'aprendizaje_maquina'

load data from a CSV file

	load = AprendizajeMaquina::Cargar.new("file.csv")

	# specify the column that you want to store on a vector
	y = load.to_vector(3)

	# if you don't specify the column or range of columns
	# this put all the data of the csv file in a matrix
	matrix = load.to_matrix

	# create a matrix with the data in the column 0 of the csv file       
	x = load.to_matrix(0)    # you can specify range like this load.to_matrix(0..4)

	x_with_ones = x.add_ones # this add a column of ones to the matrix

to normalize data
	
	x.normalize

create an instance of the class RegresionLineal

	regresion_lineal = AprendizajeMaquina::RegresionLineal.new(x_matrix,y_vector)
	regresion_lineal.find_ecuation           # (or use the alias :train) return a Vector

	m = Matrix[[1,95]]
	puts regresion_lineal.make_prediction(m) # (or use the alias :predict) to make predictions 
					                                 # => Vector[193.45225618631895]

linear regresion with arrays

	x = [74,92,63,72,58,78,85,85,73,62,80,72]
	y = [168,196,170,175,162,169,190,186,176,170,176,179]

	regresion_simple = AprendizajeMaquina::RegresionLineal.new(x,y)
	regresion_simple.train
	p regresion_simple.ecuacion
	p regresion_simple.predict(95)

## Logistic Classification

	data = AprendizajeMaquina::Cargar.new("data.csv")
    
    x = data.to_matrix(0..1).add_ones
    y = data.to_vector(2)
    initial_theta = Vector[0,0,0]
    
    cl = AprendizajeMaquina::ClasificacionLogistica.new(x,y,initial_theta)

training

the method ClasificacionLogistica#train receives 3 inputs, the first is the numbers of iterations, the second is the alpha value(step size), last one is type of training method ('SGD' for Stochastic Gradient Descents, 'Grad' for Batch Gradiendt Descent and 'Newm' for Newton's method)

	example 1:
	cl.train(12,0.01,'SGD')
	example 2:
	cl.train(10,'NewM') # Newton's method dont use alpha
	example 3:
	cl.train(400,0.001,'Grad')

predictions

	if cl.predict(Matrix[[1,24,0]]) == 1
	  p "CANSADO"
	else
	  p "DESCANSADO"
	end

make predictions for multiclass(one vs all)

	initial_theta_for_each_class = [ 
	  Vector[-38.98494868465186, 3.133704064187691,-1.0058753929521247],
		Vector[40.93814883472139,-3.2195737672278586, -0.8080682715294277],
	  Vector[-7.220460,0.256681,1.141166]
	]

	predicted_val = []

	initial_theta_for_each_class.each do |e|
	  multiclass = AprendizajeMaquina::ClasificacionLogistica.new(x,y,e)
	  predicted_val << multiclass.predict(Matrix[[1,13.5,1.83]])
	end	

	if predicted_val[0] == 1 
	  puts "Vino Tinto"
	elsif predicted_val[1] == 1
	  puts "Vino Rosado"
	elsif predicted_val[2] == 1
	  puts "Vino Blanco"
	else
	  puts predicted_val
	end

## Clustering

	load_data = AprendizajeMaquina::Cargar.new('clustering_data.csv')
	dataset = load_data.to_matrix

	# initialize with 2 cluster centroids
	clustering = AprendizajeMaquina::KmeansClustering.new(2,dataset)

	# fit the model with 20 iterations
	clustering.fit(20)

	# watch the values in their respective cluster
	p clustering.cluster(0)
	p clustering.cluster(1)

	# Predict the closest cluster
	p clustering.predict(Vector[63,190])

## Decision tree 

	tree = AprendizajeMaquina::DecisionTree.new(dataset)

	print tree.display_tree 

	puts tree.predict(datatest)


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
