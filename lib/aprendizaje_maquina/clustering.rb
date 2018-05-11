module AprendizajeMaquina
	class KmeansClustering
		def initialize(num_of_cluster_centroids,dataset_matrix)
			@num_of_cluster_centroids = num_of_cluster_centroids
			@dataset_matrix = dataset_matrix
			@num_columns = @dataset_matrix.column_count
			@num_rows = @dataset_matrix.row_count
			@cluster_centroids = init_cluster_centroids
		end

		def fit(iterations)
			clustering(iterations)
		end

		def cluster(num)
			get("@cluster_#{num}")
		end

		def predict(vector)	
			array = []			
			@cluster_centroids.each do |cluster|
			  array << (vector-cluster).r
			end
			cluster = array.index(array.min)
			cluster
		end

		private

		def array_to_vector(array)
			vector = Vector.elements(array, copy = true)
			vector
		end

		def media(array)
			if array.empty?
		    	array#raise ArgumentError.new("array is empty")
		    else
		    	1.0/array.length * array.inject { |mem, var| mem + var }
		  	end
		end

		def init_cluster_centroids
			cluster_centroids = Array.new(@num_of_cluster_centroids) { 
				min_max_rand = []
				for i in 0...@num_columns
					min_max_rand << rand(@dataset_matrix.column(i).min..@dataset_matrix.column(i).max)
				end
				array_to_vector(min_max_rand) 
			}
			cluster_centroids
		end

		def set(instance_variable_name,instance_variable_value)
			instance_variable_set(instance_variable_name,instance_variable_value)
		end

		def get(instance_variable_name)
			instance_variable_get(instance_variable_name)
		end
		
		def clustering(iterations)
			iterations.times do
				array2 = []
				for i in 0...@num_rows
					array = []
					@cluster_centroids.each do |cluster|
						array << (@dataset_matrix.row(i)-cluster).r
					end
					array2 << array
				end

				hash = {}
				for i in 0...@num_rows
					hash[@dataset_matrix.row(i)] = array2[i].index(array2[i].min)
				end

				@cluster_centroids.each_index do |index|
					set("@cluster_#{index}", Array.new)
				end

				@cluster_centroids.each_index do |index|
					hash.each do |key,value|
						if value == index
							get("@cluster_#{index}") << key
						end
					end
				end

				@cluster_centroids.each_index do |index|
					@cluster_centroids[index] = media(get("@cluster_#{index}"))
				end
			end
		end
	end
end