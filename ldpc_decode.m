function [ x_decoded ] = ldpc_decode( H, x )
%DECODE 이 함수의 요약 설명 위치
%   자세한 설명 위치
    
    %% init
    max_iter = 50;

    %%
    U = zeros(size(H));
    D = zeros(size(H));
    x_decoded = [];
    
    %%
    for k=1:(size(H, 2)):1000
        A0 = x(1, k:(k+size(H, 2) -1));

        %%
        for iter=1:max_iter

            %%
            for i=1:size(H, 1)
                for j=1:size(H, 2)
                    if H(i, j) == 1
                        U(i, j) = A0(1, j);
                        for k=1:size(H, 1)
                            if i ~= k && H(k, j) == 1
                                U(i, j) = U(i, j) + D(k, j);
                            end
                        end
                    end
                end
            end

            %%
            for i=1:size(H, 1)
                for j=1:size(H, 2)
                    if H(i, j) == 1
                        temp = [];
                        for k=1:size(H, 2)
                            if j ~= k && H(i, k) == 1
                                temp = [ temp; U(i, k)];
                            end
                        end
                        D(i,j) = (-1)^(size(temp, 1) + 1) * min(abs(temp)) * ((prod(temp) > 0) * 2 - 1);

                    end
                end
            end

            %%
            A = zeros(1, size(H, 2));
            for j=1:size(H, 2)
                A(1, j) = A0(1, j);
                for i=1:size(H, 1)
                    A(1, j) = A(1, j) + D(i, j);
                end
            end
            d = A > 0;
            d = d * eye(size(d, 1));

            %%
            s = mod(d * H', 2);
            %fprintf('\nITER %d\t\t: \n', iter);
            %fprintf('Updated LLR\t: %s\n', mat2str(A));
            %fprintf('Hard Decision\t: %s\n', mat2str(d));
            %fprintf('syndrome\t: %s\n', mat2str(s));

            if sum(s') == 0
                break;
            end

        end

        x_decoded = [ x_decoded d ];
    end
end

