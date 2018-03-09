function [ x_ch ] = get_channel_codeword( x_bi, noise_var )
%GET_CHANNEL_CODEWORD 이 함수의 요약 설명 위치
%   자세한 설명 위치

    x_ch = x_bi + randn(size(x_bi)) * noise_var;
end

