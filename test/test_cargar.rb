require 'aprendizaje_maquina/cargar'
require 'test/unit'

class TestCargar < Test::Unit::TestCase

	def setup
		@cargar = AprendizajeMaquina::Cargar.new("file.csv")
		@matrix_when_nil = Matrix[[74, 168], [92, 196], [63, 170], [72, 175], [58, 162], [78, 169], [85, 190], [85, 186], [73, 176], [62, 170], [80, 176], [72, 179]]
		@cargar1 = AprendizajeMaquina::Cargar.new("file1.csv")
		@matrix_when_range = Matrix[[3, 2], [2, 1], [4, 3], [2, 1], [3, 2], [2, 2], [5, 3], [4, 2]]
		@matrix_when_integer = Matrix[[74], [92], [63], [72], [58], [78], [85], [85], [73], [62], [80], [72]]
		@csv_data = [["74", "168"], ["92", "196"], ["63", "170"], ["72", "175"], ["58", "162"], ["78", "169"], ["85", "190"], ["85", "186"], ["73", "176"], ["62", "170"], ["80", "176"], ["72", "179"]]
		@vector = Vector[168, 196, 170, 175, 162, 169, 190, 186, 176, 170, 176, 179]
	end

	def test_initialize
		assert_equal(@csv_data,@cargar.instance_variable_get('@csv_data'))
		assert_equal(2,@cargar.instance_variable_get('@largo_colum'))
	end

	def test_to_matrix
		assert_equal(@matrix_when_nil,@cargar.to_matrix, "cuando el argumento es nil retorna todos los datos del archivo")
		assert_raise(ArgumentError) { @cargar.to_matrix(0..2)}
		assert_equal(@matrix_when_range,@cargar1.to_matrix(0..1))
		assert_equal(@matrix_when_integer,@cargar.to_matrix(0))
		assert_raise(ArgumentError){ @cargar.to_matrix("hola")}
		assert_raise(ArgumentError){ @cargar.to_matrix([0,1,4])}
	end

	def test_to_vector
		assert_raise(ArgumentError){@cargar.to_vector(2)}
		assert_equal(@vector,@cargar.to_vector(1))
	end
end 