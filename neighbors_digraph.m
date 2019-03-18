function [ N ] = neighbors_digraph( Adj, vertex )
k = 1;
N = [];
for i=1:length(Adj)
    if (Adj(vertex,i)>0)
        N(k) = i;
        k = k + 1;
    end
end   
end

