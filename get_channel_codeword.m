function [ x_ch ] = get_channel_codeword( x_bi, noise_var )
%GET_CHANNEL_CODEWORD �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

    x_ch = x_bi + randn(size(x_bi)) * noise_var;
end

