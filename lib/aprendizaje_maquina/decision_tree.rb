module AprendizajeMaquina
	class DecisionTree
		def initialize(dataset)
			@dataset = dataset
		end

		def display_tree
			node_root = build_tree(@dataset)
			colection = [node_root]
			branches = []
			tree = "root --> #{node_root[1][0]}:#{node_root[1][1]}?\n"
			for node in 0...node_root[2].length
				branches << build_tree(node_root[2][node])
				colection << branches
				1000.times do 
					subbranches = []
					true_or_false = lambda { |node| node == 0 ? true : false }
					branches.each do |branch|
						if branch.is_a?(Array)
							tree << "#{true_or_false.call(node)} --> "+"#{branch[1][0]}:#{branch[1][1]}?\n"
							for node in 0...branch[2].length
								if build_tree(branch[2][node]).is_a? Hash
									tree << "#{true_or_false.call(node)} --> "+"#{build_tree(branch[2][node])}\n"
								else
									subbranches << build_tree(branch[2][node])
								end
							end
						elsif branch.is_a?(Hash)
							tree << "#{true_or_false.call(node)} --> "+"#{branch}\n"
						end
					end
					branches = subbranches
					colection << branches
					if colection.last.empty?
						colection.pop
						break
					end
				end
			end
			return tree
		end

		def predict(observation)
			node_root = build_tree(@dataset)
			until node_root.is_a?(Hash)
				if observation[node_root[1][0]].is_a?(Integer) or observation[node_root[1][0]].is_a?(Float)
					if observation[node_root[1][0]] >= node_root[1][1]
						branch = build_tree(node_root[2][0])
					else 
						branch = build_tree(node_root[2][1])
					end
				else
					if observation[node_root[1][0]] == node_root[1][1]
						branch = build_tree(node_root[2][0])
					else 
						branch = build_tree(node_root[2][1])
					end
				end
				node_root = branch
			end
			return node_root
		end

		private
		
		def split_dataset(dataset, column, value)
			if value.is_a? Integer or value.is_a? Float
				split_function = lambda { |row| row[column] >= value }
			else
				split_function	=	lambda { |row| row[column] == value }
			end
			set1 = []
			set2 = []
			for row in dataset
				if split_function.call(row)
					set1 << row
				else
					set2 << row
				end
			end
			return set1,set2
		end

		def count_classes(dataset)
			hash_count = {}
			dataset.each do |row|
				if hash_count.include?(row[-1])
					hash_count[row[-1]] += 1
				else
					hash_count[row[-1]] = 1
				end
			end
			return hash_count
		end 

		def entropy(dataset)
			classes_count = count_classes(dataset)
			ent = 0.0
			classes_count.each_value do |value|
				prob = value.to_f / dataset.length 
		 		ent -= prob * Math.log2(prob)
		 	end
		 	return ent
		end

		def build_tree(dataset)
			best_info_gain = 0.0
			column_and_value_attribute = nil
			best_sets = nil
			for column_attribute in 0...dataset[0].length-1 # elimina la etiqueta
				for row in dataset
					value_attribute = row[column_attribute]
					node_true, node_false = split_dataset(dataset,column_attribute,value_attribute)
					information_gain = entropy(dataset) - (node_true.length.to_f/dataset.length) * entropy(node_true) -
																						    (node_false.length.to_f/dataset.length) * entropy(node_false)
					if information_gain > best_info_gain # pick the highest information_gain
						best_info_gain = information_gain
						column_and_value_attribute = column_attribute, value_attribute
						best_sets = node_true, node_false
					end
				end
			end
			if best_info_gain > 0
					return best_info_gain, column_and_value_attribute, best_sets
			else
				return count_classes(dataset)
			end
		end
	end
end