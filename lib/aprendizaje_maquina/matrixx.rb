class Matrix
	def add_ones
		matrix = self.to_a.map{|i| i.insert(0,1)}
		matrix = Matrix.rows(matrix,copy=true)
		matrix
	end
end