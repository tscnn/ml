function [ S ] = adaClassify( X, H, Alpha )

N = size(X,1);
S = zeros(N,1);
T = size(H,1);

for i=1:N
    
    sum = 0;
    
    for t=1:T
        
        threshold = H(t,1);
        dimension = uint8(H(t,2));
        direction = H(t,3);
        
        s = (direction * X(i,dimension)) >= (threshold * direction);
        s = s * 2 - 1;
        
        sum = sum + Alpha(t) * s;
        
    end
    
    if sum == 0
        S(i) = 1;
    else
        S(i) = sign(sum);
    end
    
end

end

