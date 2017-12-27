module AprendizajeMaquina

	class ClasificacionLogistica

	    def initialize(x,y,theta)
	      @x = x
	      @y = y
	      @theta = theta
	      if y.is_a? Matrix
	        @m = y.row_count
	      elsif y.is_a? Vector
	         @m = y.size
	      else
	        @m = y.length
	      end
	    end
	
	    def train(iterations,alpha = nil,type_of_train)
			case type_of_train
				when 'Grad' then
					# gradiente de descenso
					@cost_history = []
					for i in 0..iterations
						x = @x*@theta
						hx = x.map {|e| sigmoid(e) }
						@theta = @theta - alpha / @m * @x.transpose * (hx - @y)
						costo = 0
						cost.to_a.map{|e| costo = e }
						@cost_history << ["iteracion: #{i}",costo]
					end
					@cost_history
					p "theta values => #{@theta} | cost => #{costo}"
				when 'Newm' then
					# metodo de newton
					@cost_history = []
					for i in 0..iterations
						x = @x*@theta
						hx = x.map {|e| sigmoid(e) }
						uno_menos_hx = hx.map{|e| (1-e) }
						escalar = []
						for u in 0...hx.size
							escalar << hx[u] * uno_menos_hx[u]
						end
						gradiente = (1.0/@m) * @x.transpose * (hx - @y)
						hessian = (1.0/@m) * @x.transpose * sumatoria(escalar) * @x
						inversa = (1.0/hessian.det)*(hessian.adjugate)
						@theta = @theta - inversa * gradiente
						costo = 0
						cost.to_a.map{|e| costo = e }
						@cost_history << ["iteracion: #{i}",costo]
					end
					@cost_history
					p "theta values => #{@theta} | cost => #{costo}"
				when 'SGD' then
					# Stochastic Gradient Descent
					@cost_history = []
					for i in 0..iterations
						x = matrix(@x.to_a.map{|e| e.shuffle })*@theta
						hx = x.map {|e| sigmoid(e) }
						@theta = @theta - alpha / @m * @x.transpose * (hx - @y)
						costo = 0
						cost.to_a.map{|e| costo = e }
						@cost_history << ["iteracion: #{i}",costo]
					end
					@cost_history
					p "theta values => #{@theta} | cost => #{costo}"
				end
			end		
	    end
    
	    def predict(x)
	        hipo = x * @theta 
	        var = 0
	        hipo.map {|x| var = x.is_a?(Integer) ? x.to_i : x.to_f }
			if sigmoid(var) >= 0.5 
	        	1
	        else
	        	0
	        end
	    end
	    
	    private
			
		def sumatoria(array)
			array.inject(0) { |elem1, elem2| elem1 + elem2 }
		end
	    
		def sigmoid(x)
		    1.0 / (1.0 + Math.exp(-x))
		end
			
		def cost
			x = @x*@theta
			hx = x.map {|e| sigmoid(e) }
			log_hx = hx.map{|e| Math.log(e) }
			log_uno_menos_hx = hx.map{|e| Math.log(1-e) }
			costo = -1.0/@m * ( Matrix[@y.to_a] * log_hx + ( Matrix[@y.to_a].map{|i| 1 - i } ) * log_uno_menos_hx )
			costo
		end
						
		def matrix(columns)
	  		Matrix.rows(columns, false)
		end
	end
end