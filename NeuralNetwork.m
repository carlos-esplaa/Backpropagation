classdef NeuralNetwork
    properties
        layers
    end
    
    methods
        function obj = NeuralNetwork()
            obj.layers = {};
        end
        
        function obj = set(obj, layer)
            obj.layers{end+1} = layer;

        end
        
        function result = feedforward(obj, X, n)
            if nargin < 3 ||  isempty(n)
                n = length(obj.layers);
            end

            for i = 1:n
                X = obj.layers{i}.A(X);
            end

            result = X;
        end
        
        function obj = backpropagation(obj, X, y, lr)
            A = obj.feedforward(X);
            A = reshape(A, numel(A), 1);
            y = reshape(y, numel(y), 1);

            % Calculamos el error de la última capa
            error = A - y;

            A_prev = obj.feedforward(X, numel(obj.layers)-1);
            A_prev = reshape(A_prev, numel(A_prev), 1);

            % actualizamos los pesos de la última capa
            dW = error * A_prev';
            obj.layers{end}.weights = obj.layers{end}.weights - lr * dW;
            obj.layers{end}.bias = obj.layers{end}.bias - lr * error;

            % Calculamos el error de la capa anterior
            A_prev_2 = obj.feedforward(X, numel(obj.layers)-2);
            A_prev_2 = reshape(A_prev_2, numel(A_prev_2), 1);

            derivate = obj.layers{end-1}.activation_derivate(obj.layers{end-1}.z(A_prev_2));
            dz2 = derivate .* (obj.layers{end}.weights)' * error;
            obj.layers{end-1}.bias = obj.layers{end-1}.bias - lr .* dz2;

            dz2 = dz2 * A_prev_2';
            obj.layers{end-1}.weights = obj.layers{end-1}.weights - lr .* dz2;
        end
    end
end
