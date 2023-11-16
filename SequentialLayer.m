
classdef SequentialLayer
    properties
        units
        weights
        bias
        activation
        activation_derivate
    end
    
    methods
        function obj = SequentialLayer(input, output, activation, activation_derivate)
            obj.units = output;
            obj.weights = randn(output, input);
            obj.bias = randn(output, 1);
            obj.activation = activation;
            obj.activation_derivate = activation_derivate;
        end
        
        function result = z(obj, A_prev)
            result = obj.weights * A_prev + obj.bias;
        end
        
        function result = A(obj, A_prev)
            result = obj.activation(obj.z(A_prev));
        end
    end
end
