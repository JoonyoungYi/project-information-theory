function [ x ] = generate_codeword( G )
%GENERATE_CODEWORDE �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

    x = [];
    
    while size(x, 2) < 1000
    
        %% init message word
        m = zeros(1, size(G, 1));
        for i=1:size(G, 1)
            if rand() < 0.5
                m(1, i) = 0;
            else
                m(1, i) = 1;
            end
        end

        %%
        x = [ x mod(m * G, 2) ];
            
    end
        
end

