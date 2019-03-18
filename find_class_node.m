function[num_node] = find_class_node(E, N, v1, v2)
for i= 1:N
    edges = E(i).edge;
    if(edges(1, 1) == v1 && edges(1, 2) == v2 ||...
        edges(1, 1) == v2 && edges(1, 2) == v1)
        num_node = E(i).class_edge;
        break;
    end
end
end
