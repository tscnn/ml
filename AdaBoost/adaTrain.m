function [ H, Alpha, min_error ] = adaTrain( X, L, T )

N = size(L,1); % number of samples
D = ones(N,1) / N; % weights for samples
H = zeros(T,3); % weak threshold classifiers
Alpha = zeros(T,1);

Xmin = min(min(X));
Xmax = max(max(X));

Sopt = zeros(N,1);

min_error = 0;

for t = 1:T

    min_error = realmax;
    
    % iterate parameter space
    for threshold = linspace(Xmin,Xmax,100)
        
        for dimension = [1,2]
            
            for direction = [-1,1]
           
                S = (X(:,dimension) * direction) >= (threshold * direction);
                S = S * 2 - 1;
           
                error = sum(D .* (S ~= L));
           
                if error < min_error
                    min_error = error;
                    Sopt = S;
                    H(t,:) = [threshold, dimension, direction];
                end
           
            end
            
        end
        
    end
    
    % calculate new weights
    Alpha(t) = log((1-min_error)/min_error) / 2;
    D = D .* exp(-Alpha(t) * L .* Sopt);
    
    % normalize to sum
    D = D / sum(D);
    
end

end