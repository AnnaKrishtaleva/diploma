function[var, mass_v] = fun(G, src, v_r, index_v_r)
max_kod = max(index_v_r);
kod = 1;
var = [];
mass_v = [];
i = 1;
while(kod <= max_kod)
    [k, m] = find(index_v_r == kod);
    [P,d] = shortestpath(G, src, v_r(m));
    if (d == 1)
        mass_v(i) = v_r(m);
        var(i) = kod;
        i = i + 1;
    end
    kod = kod + 1; 
end
end