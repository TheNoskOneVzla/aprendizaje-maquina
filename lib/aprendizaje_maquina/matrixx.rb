class Matrix
	def add_ones
		matrix = self.to_a.map{|i| i.insert(0,1)}
		matrix = Matrix.rows(matrix,copy=true)
		matrix
	end

	def normalize
		array = []
		self.column_count.times do |i|
			array << self.column(i).normalize
		end
		matrix_normal = Matrix.rows(array,copy=true).transpose
		matrix_normal
	end	
end