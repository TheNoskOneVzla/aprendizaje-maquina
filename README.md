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

for make predictions with the linear regression model

first

	require 'aprendizaje_maquina'

load data from a CSV file

	load = AprendizajeMaquina::Cargar.new("file.csv")
	y = load.to_vector(3)    # specify the column that you want to store on a vector
    matrix = load.to_matrix  # this put all the data of the csv file in a matrix
                             # if you don't specify the column or range of columns              
	x = load.to_matrix(0)    # create a matrix with the data in the column 0 of the csv file 
	                         # you can specify range like this load.to_matrix(0..4)
	x_with_ones = x.add_ones # this add a column of ones to the matrix

create an instance of the class RegresionLineal

	regresion_lineal = AprendizajeMaquina::RegresionLineal.new(x_matrix,y_vector)
	regresion_lineal.encontrar_ecuacion    # find the theta values => Vector[114.50684133915638, 0.8310043668122375]
	m = Matrix[[1,95]]
	p regresion_lineal.hacer_prediccion(m) # make predictions 
										   # => Vector[193.45225618631895]

linear regresion with arrays

x = [74,92,63,72,58,78,85,85,73,62,80,72]
y = [168,196,170,175,162,169,190,186,176,170,176,179]

regresion_simple = AprendizajeMaquina::RegresionLineal.new(x,y)
regresion_simple.encontrar_ecuacion
p regresion_simple.ecuacion
p regresion_simple.hacer_prediccion(95)


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TheNoskOneVzla/aprendizaje_maquina.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
