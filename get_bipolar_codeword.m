function [ x ] = get_bipolar_codeword( x )
%GET_BIPOLAR_CODEWORD 이 함수의 요약 설명 위치
%   자세한 설명 위치
    
    for i=1:size(x, 2)
        if x(1, i) == 0
            x(1, i) = -1;
        end        
    end

end

