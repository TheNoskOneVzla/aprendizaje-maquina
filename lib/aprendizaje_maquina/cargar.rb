require 'csv'   
require 'matrix'
module AprendizajeMaquina

	class Cargar
		
		def initialize(path_file)
			@path_file = path_file
			@csv_data = CSV.read(@path_file)
			@largo_colum = @csv_data[0].length
		end
			
		def to_matrix(columnas = nil)
			if columnas == nil
				array = @csv_data.map{|e| e.map{|o| o.include?(".") ? o.to_f : o.to_i } }
				matrix = Matrix.rows(array,copy=true)
				matrix
			elsif columnas.is_a?(Range)
				if columnas.last >= @largo_colum
					raise ArgumentError, "Number of columns don't exist"
				else
					array = @csv_data.map{|e| e[columnas].map{|i| i.include?(".") ? i.to_f : i.to_i} }
					matrix = Matrix.rows(array,copy=true)
					matrix
				end
			elsif columnas.is_a?(Integer)
				if columnas >= @largo_colum
					raise ArgumentError, "Number of columns don't exist"
				else
					array = @csv_data.map { |e| e[columnas].include?(".") ? e[columnas].to_f : e[columnas].to_i }
					matrix = Matrix[array].transpose
					matrix
				end
			else
				raise ArgumentError, "Must be nil, range or integer"
			end
		end

		def to_vector(columna)
			if columna >= @largo_colum
				raise ArgumentError, "Column don't exist"
			else
				array = @csv_data.map { |e| e[columna].include?(".") ? e[columna].to_f : e[columna].to_i }
				vector = Vector.elements(array,copy=true)
				vector
			end
		end
	end
end