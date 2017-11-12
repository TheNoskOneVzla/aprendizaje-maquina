module AprendizajeMaquina

	class RegresionLineal
		alias_method :train, :find_ecuation
		alias_method :predict, :make_prediction
		attr_reader :m,:b, :ecuacion, :theta
		attr_accessor :x,:y

		def initialize(x,y)
			@x = x
			@y = y
			@trained = false
			if @x.is_a?(Array)
				@n = @x.length
			elsif @x.is_a?(Matrix)
				@n = @x.column_count
			end
		end

		def find_ecuation
			if @x.is_a?(Array) && @y.is_a?(Array)
				@trained = true
				@m = ((@n*sumatoria(multiplicar(@x,@y))) - (sumatoria(@x)*sumatoria(@y))).to_f / ((@n*sumatoria(al_cuadrado(@x))) - (sumatoria(@x)**2)).to_f
				@b = media(@y) - (@m * media(@x))
				@ecuacion = "Y = #{@m.round(4)}X+#{@b.round(4)}" 
				@ecuacion
			elsif @x.is_a?(Matrix) && @y.is_a?(Vector)
				@trained = true
				inversa = (1.to_f/(@x.transpose*@x).det)*((@x.transpose*@x).adjugate)
				@theta = inversa * (@x.transpose * @y)
				@theta
			else
				raise ArgumentError
			end
		end

		def make_prediction(x_a_predecir)
			if @trained == true
				if x_a_predecir.is_a?(Numeric)
					prediccion = (@m * x_a_predecir) + @b
					prediccion
				elsif x_a_predecir.is_a?(Matrix)
					prediccion = x_a_predecir * @theta
					prediccion
				else
					raise ArgumentError, "Must be a number or matrix 1xN"
				end
			else
				return "There is not a equation to make predictions (first, run encontrar_ecuacion method)"
			end
		end

		def self.deprecate(old_method, new_method)
			define_method(old_method) do |*args, &block|
				warn "Warning: #{old_method}() is deprecated. Use #{new_method}()."
				send(new_method, *args, &block)
			end
		end

		deprecate :encontrar_ecuacion, :find_ecuation
		deprecate :hacer_prediccion, :make_prediction
		
		private

		def multiplicar(array_1,array_2) 
			iter = @n - 1
			xy = []
			for i in 0..iter
				xy << array_1[i]*array_2[i]
			end
			xy
		end

		def al_cuadrado(array)
			iter = @n - 1
			x_2 = []
			for i in 0..iter
				x_2 << array[i]**2
			end
			x_2
		end

		def sumatoria(array)
			array.inject(0) { |elem1, elem2| elem1 + elem2 }
		end

		def media(array)
			sumatoria(array).to_f / array.length
		end
	end
end