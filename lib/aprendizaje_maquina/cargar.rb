require 'csv'   
require 'matrix'
module AprendizajeMaquina

	class Cargar
		
		def initialize(path_file)
			@path_file = path_file
			@csv_data = CSV.read(@path_file)
			#@csv_data = CSV.read(File.join(Dir.pwd,@path_file))
			@largo_colum = @csv_data[0].length
		end
			
		def to_matrix(columnas = nil)
			if columnas == nil
				array = @csv_data.map{|e| e.map{|o| o.to_i } }
				matrix = Matrix.rows(array,copy=true)
				matrix
			elsif columnas.is_a?(Range)
				if columnas.last >= @largo_colum
					raise ArgumentError, "Number of columns don't exist"
				else
					array = @csv_data.map{|e| e[columnas].map{|i| i.to_i} }
					matrix = Matrix.rows(array,copy=true)
					matrix
				end
			elsif columnas.is_a?(Integer)
				array = @csv_data.map { |e| e[columnas].to_i }
				matrix = Matrix[array].transpose
				matrix
			else
				raise ArgumentError, "Must be nil, range or integer"
			end
		end

		def to_vector(columna)
			if columna >= @largo_colum
				raise ArgumentError, "Column don't exist"
			else
				array = @csv_data.map { |e| e[columna].to_i }
				vector = Vector.elements(array,copy=true)
				vector
			end
		end
	end
end