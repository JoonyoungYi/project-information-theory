
%% input parameters
n = 1000;
r = 0.5;
dv = 3;

%% init
k = n * r;
p = n - k;

%% make matrix H
flag = false;
while ~flag
    try
        H = make_matrix_H(p, n, dv);
        G = make_matrix_G(H);
        flag = valid_G(G, H);
        disp('iter!');
    catch
        disp('error!');
    end
end
