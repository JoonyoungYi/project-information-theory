function [ isvalid ] = valid_G( G, H )
%VALID_G 이 함수의 요약 설명 위치
%   자세한 설명 위치
    isvalid = true;
    for i=1:size(G, 1)
        if G(i, i) ~= 1
            isvalid = false;
            return;
        end
    end
    
    if sum(sum(mod(G*H', 2))) ~= 0
        isvalid = false;
    end


end

