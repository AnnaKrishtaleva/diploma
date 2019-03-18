function[min_v1, flag1, min_ind1, min_v2, flag2, min_ind2] = min_find(vertex, v_v, Matrix_adj, I)
flag1 = 0; flag2 = 0;
min_ind1 = 0; min_ind2 = 0;
min_v1 = 0; min_v2 = 0;
while(1)
    q = 1;
    around_v = []; index_v = [];
    for j = 1:length(v_v)
        if(Matrix_adj(vertex, v_v(j)) ~= 0)
            around_v(q) = v_v(j);
            index_v(q) = I(v_v(j));
            q = q + 1;
        end
    end
    l = length(around_v);
    if (l == 0)
        min_v1 = 0;
        flag1 = 0;
        break;
    else
        min_ind1 = min(index_v);
        [k, m] = find(index_v == min_ind1);
        min_v1 = around_v(m(1));
        flag1 = 1;
    end
    q = 1;
    around_v = []; index_v = [];
    for j = 1:length(v_v)
        if(Matrix_adj(vertex, v_v(j)) ~= 0 && v_v(j) ~= min_v1)
            around_v(q) = v_v(j);
            index_v(q) = I(v_v(j));
            q = q + 1;
        end
    end
    l = length(around_v);
    if(l == 0)
        min_v2 = 0;
        flag2 = 0;
        break;
    else
        min_ind2 = min(index_v);
        [k, m] = find(index_v == min_ind2);
        min_v2 = around_v(m(1));
        flag2 = 2;
    end
    break;
end
    