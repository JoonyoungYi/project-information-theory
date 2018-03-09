
result = [];

for SNR=1:0.2:4

    %%
    cnt = 0;
    tot = 0;

    %%
    for iter=1:50000 

        %
        x = generate_codeword(G);
        x_bi = get_bipolar_codeword(x);
        x_ch = get_channel_codeword(x_bi, 1/SNR);
        x_decoded = ldpc_decode(H, x_ch);

        %
        if sum(x ~= x_decoded) == 0
            fprintf('ITER : %04d -> SUCCESS!\n', iter);
        else
            cnt = cnt + 1;
            fprintf('ITER : %04d -> FAIL....\n', iter);
        end
        tot = tot + 1;

        if cnt == 50
            break;
        end

    end

    %%
    WER = cnt / tot;
    fprintf('WER : %f \n', WER);
    cur_result = [ SNR ; WER ] ;
    result = [ result  cur_result ];
    
    %%
    if WER < 0.001
        break;
    end

end

