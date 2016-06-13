import numpy as np

class Network(object):

	def __init__(self, sizes):
		self.num_layers = len(sizes)
		self.sizes = sizes
		self.biases = [np.random.randn(y, 1) for y in sizes[1:]]
		self.weights = [np.random.randn(y,x) for x,y in zip(sizes[:-1], sizes[1:])]

	 def feedforward(self, input):
        # Returns the output of the network
        for b, w in zip(self.biases, self.weights):
            a = sigmoid(np.dot(w, input)+b)
        return input

## Misc functions
def sigmoid(z):
	return 1.0/(1.0+np.exp(-z))

def main():
	net = Network([2, 3, 1])

main()