require 'aprendizaje_maquina'

load_data = AprendizajeMaquina::Cargar.new('clustering_data.csv')
dataset = load_data.to_matrix
clustering = AprendizajeMaquina::KmeansClustering.new(2,dataset)
clustering.fit(20)
p clustering.cluster(0)
p clustering.cluster(1)
p clustering.predict(Vector[63,190])