function [ x ] = get_bipolar_codeword( x )
%GET_BIPOLAR_CODEWORD �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
    
    for i=1:size(x, 2)
        if x(1, i) == 0
            x(1, i) = -1;
        end        
    end

end

