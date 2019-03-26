function[class_iso_edges, num_class_result] = edges_map_digraph(list_edges, maxi_matrix, maxi_kov_vertex, I)
class_iso_edges = struct('edge', [], 'class_edge', 0);
n = length(list_edges);
H = nextperm(n,n);
vertex = 1:n;
len_rev = factorial(n) - 1;
itog_sigma(1, :) = vertex;
p = 2;
for i = 1:len_rev
    sigma = H();
    j = 2;
    while (j <= n)
        num_vertex = vertex(j);
        num_sigma = sigma(j);
        a1 = list_edges(num_vertex, :);
        b1 = list_edges(num_sigma, :);
        flag = 1;
        for k = 1:j-1
            a2 = list_edges(vertex(k), :);
            b2 = list_edges(sigma(k), :);
            num1 = intersect(a1, a2);
            num2 = intersect(b1, b2);
            e1 = (I(a1) ==  I(b1));
            e2 = (I(a2) ==  I(b2));
            % в ориентир графе проверяем на совпадение перестановки вида
            % в проверке на смежность имеем место, где стоит вершина в
            % одной мперестановке и другой. Это необходимо учитывать, чтобы
            % оставалось верное направление в орграфе
            if (e1 & e2)
                if(a1(1) == a2(2) &&  b1(1) == b2(2))
                    flag = 0;
                elseif (a1(2) == a2(1) &&  b1(2) == b2(1))
                    flag = 0;
                elseif (a1(1) == a2(1) &&  b1(1) == b2(1))
                    flag = 0;
                elseif(a1(2) == a2(2) &&  b1(2) == b2(2))
                    flag = 0;   
                elseif (isempty(num1) && isempty(num2))
                    flag = 0;
                else
                    flag = 1;
                    break;
                end
            else
                flag = 1;
                break;
            end
        end
        if(flag == 1)
            break;
        end
        j = j + 1;
    end
    if (flag == 0)
        itog_sigma(p, :) = sigma;
        p = p + 1;
    end
end

itog_sigma;

test_mass = ones(1, n);
class_edge_mass = zeros(1, n);
m = size(itog_sigma);
class_num = 0;
if(m(1) == 1)
    for i = 1:n
        class_num = class_num + 1;
        class_edge_mass(i) = class_num;
    end
else
    for i = 1:n
        if(class_edge_mass(i) == 0)
            class_num = class_num + 1;
            class_edge_mass(i) = class_num;
        end
        for j = 2:m(1)
            t = itog_sigma(j, i);
            if(class_edge_mass(t) == 0)
                class_edge_mass(t) = class_num;
            end
        end
        if (class_edge_mass & test_mass)
            break
        end
    end
end



class_edge_mass

size_matrix = length(maxi_matrix);

num_class_result = zeros(1, n);
num_class = 1;
maxi_kov_vertex;
for i= 1:size_matrix
    %в неорграфе j = i:size_matrix. Здесь рассматриваем так, потому что
    %нужен весь граф, симметричности не будет
    for j = 1:size_matrix 
        if(maxi_matrix(i, j) ~= 0)
            v1 = maxi_kov_vertex(i);
            v2 = maxi_kov_vertex(j);
            [row, col] = find(list_edges(:, 1:end)==v1 & list_edges(:, 2:end)== v2);
            if (length(row) == 0)
                [row, col] = find(list_edges(:, 1:end)==v2 & list_edges(:, 2:end)== v1);
            end
            if(num_class_result(row) == 0)
                temp_class = class_edge_mass(row);
                for k = 1:length(temp_class)
                    [r, c] = find(class_edge_mass == temp_class(k));
                    num_class_result(c) = num_class;
                end
                num_class = num_class + 1;
            end
        end
    end
    num_class_result;
    if (num_class_result & test_mass)
        break
    end
end

num_class_result;

for i = 1:n
    class_iso_edges(i).edge = list_edges(i, :);
    class_iso_edges(i).class_edge = num_class_result(i);
end


end