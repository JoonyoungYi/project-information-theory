function [ H  ] = make_matrix_H( p, n, dv  )
%MAKE_MATRIX_H : make an H matrix.
% REFERENCE : http://arun-10.tripod.com/ldpc/generate.html

    %% STEP 1
    H = zeros(p, n);
    
    %% STEP 2
    for col_l_index=1:n
        while true
            index = randperm(p, dv);
            
            col_candidate = zeros(size(H, 1), 1);
            for i=1:size(index,2)
                col_candidate(index(1, i), 1) = 1;
            end
            
            for col_r_index=1:(col_l_index-1)
                if is_conflict(H, col_candidate, H(:, col_r_index))
                    continue;
                end
            end
            
            H(:, col_l_index) = col_candidate;
            break;
        end
    end
    
    %% STEP 4
    avg_1_per_row = (n*dv)/p;
    assert(avg_1_per_row == floor(avg_1_per_row));

    %% STEP 5
    s = (sum(H.'))';
    while ~is_valid_s(s, avg_1_per_row)
        %disp('changed!');
        sparse_row_index = get_sparse_row_index(s, avg_1_per_row);
        dense_row_index = get_dense_row_index(s, avg_1_per_row);
        
        H = move_dense2sparse(H, dense_row_index, sparse_row_index);
        
        s = (sum(H.'))';
    end
    
    %% Check Conflict
    for col_l_index=1:n
        for col_r_index=(col_l_index+1):n
            if is_conflict(H, col_l_index, col_r_index)
                assert(false);
            end
        end
    end
          
%     %% STEP 6
%     while true
%         i = 0;
%         for col_l_index=1:n
%             for col_r_index=(col_l_index+1):n
%                 if is_conflict(H, col_l_index, col_r_index)
%                     H = handle_conflict(H, col_l_index, col_r_index);
%                 	i = i + 1;
%                 end
%             end
%         end
%         
%         if i == 0
%             break;
%         end
%     end
end

%%
function [ is_valid ] = is_valid_s(s, avg_1_per_row)
    is_valid = true;
    for i=1:size(s, 1)
        if s(i, 1) ~= avg_1_per_row
            is_valid = false;
            break;
        end
    end
end

%%
function [ index ] = get_sparse_row_index(s, avg_1_per_row)
    index = -1;
    
    for i=1:size(s, 1)
        if s(i, 1) < avg_1_per_row
            index = i;
            break;
        end
    end
end

%%
function [ index ] = get_dense_row_index(s, avg_1_per_row)
    index = -1;
    
    for i=1:size(s, 1)
        if s(i, 1) > avg_1_per_row
            index = i;
            break;
        end
    end
end

%%
function [ H ] = move_dense2sparse(H, dense_row_index, sparse_row_index)
    
    for j=1:size(H, 2)
        if H(dense_row_index, j) == 1 && H(sparse_row_index, j) == 0
            H(dense_row_index, j) = 0;
            H(sparse_row_index, j) = 1;
            break;
        end
    end
    
end

%%
function [ conflict ] = is_conflict(H, l, r)
        
    if sum((l+r) == 2*ones(size(H, 1), 1)) > 1
        conflict = true;
    else
        conflict = false;
    end    
end

%%
function [ H ] = handle_conflict(H, index_l, index_r)
        
    for i=1:size(H, 1)
        if H(i,index_l) == 1 && H(i, index_r) == 1
            if rand() < 0.5
                index = i;
                while H(index, index_l) == 1
                    index = floor(rand()*size(H, 1)) + 1;
                end
                H(i, index_l) = 0;
                H(index, index_l) =1;
            else
                index = i;
                while H(index, index_r) == 1
                    index = floor(rand()*size(H, 1)) + 1;
                end
                H(i, index_r) = 0;
                H(index, index_r) =1;
            end
        end
    end
end

