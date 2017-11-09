require 'aprendizaje_maquina/regresion_lineal'
require 'aprendizaje_maquina/cargar'
require 'aprendizaje_maquina/matrixx'
require 'test/unit'

class TestRegresionLineal < Test::Unit::TestCase
	def setup
		x = [74,92,63,72,58,78,85,85,73,62,80,72]
		y = [168,196,170,175,162,169,190,186,176,170,176,179]
		@regresion_simple = AprendizajeMaquina::RegresionLineal.new(x,y)
		cargar = AprendizajeMaquina::Cargar.new("file.csv")
		x = cargar.to_matrix(0).add_ones
		y = cargar.to_vector(1)
		@regresion = AprendizajeMaquina::RegresionLineal.new(x,y)
		@vector_ecuacion = Vector[114.50684133915638, 0.8310043668122375]
		data = AprendizajeMaquina::Cargar.new("file1.csv")
		x = data.to_matrix(0..1)
		y = data.to_vector(2)
		x_ones = x.add_ones
		@regresion_multiple = AprendizajeMaquina::RegresionLineal.new(x_ones,y)
		@vector_ecuacion_multi = Vector[65191.666666666686, 4133.333333333372, 758.3333333334886]
		@regresion_simple.encontrar_ecuacion
		@regresion.encontrar_ecuacion
		@regresion_multiple.encontrar_ecuacion
	end
	
	def test_encontrar_ecuacion
		assert_raise(ArgumentError){AprendizajeMaquina::RegresionLineal.new("hola",7).encontrar_ecuacion}
		assert_equal("Y = 0.831X+114.5068",@regresion_simple.encontrar_ecuacion)
		assert_equal(@vector_ecuacion,@regresion.encontrar_ecuacion)
		assert_equal(@vector_ecuacion_multi,@regresion_multiple.encontrar_ecuacion)
	end

	def test_hacer_prediccion
		assert_equal(193.4522561863173,@regresion_simple.hacer_prediccion(95))
		assert_equal(Vector[193.45225618631895],@regresion.hacer_prediccion(Matrix[[1,95]]))
		assert_equal(Vector[79866.66666666727],@regresion_multiple.hacer_prediccion(Matrix[[1,3,3]]))
		assert_raise(ArgumentError){@regresion_multiple.hacer_prediccion("cadena")}
	end

	def test_private_methods
		x=[5,2]
		y=[1,5]
		assert_equal([5,10],AprendizajeMaquina::RegresionLineal.new(x,y).send(:multiplicar,x,y))
		assert_equal([25,4],AprendizajeMaquina::RegresionLineal.new(x,y).send(:al_cuadrado,x))
		assert_equal(7,AprendizajeMaquina::RegresionLineal.new(x,y).send(:sumatoria,x))
		assert_equal(3,AprendizajeMaquina::RegresionLineal.new(x,y).send(:media,y))
	end
end