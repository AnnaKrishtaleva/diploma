function[] = lin_notation(I_n, I_e, G, Adj, f)
if (f == 0)
    Nn = sum(sum(Adj))/2;
else
    Nn = sum(sum(Adj));
end
Matrix_adj = Adj;
fid = fopen('notation.txt', 'w'); 
if fid == -1 
    error('File is not opened'); 
end 
I1 = I_n;
v_e = zeros(1, length(I_n)); %множество исключенных вершин
v_r = zeros(1, length(I_n)); %множество временно замененных вершин
index_v_r = zeros(1, length(I_n));
%скобки для записи в нотацию
var1 = '[';
var2 = ']';
var3 = '->';
var4 = '(';
var5 = ')';
var6 = '<-';
var7 = ' V ';
%шаг первый:
%выбираем вершину первого индекса и записываем ее в нотацию, добавляя
%открывающуюся скобку
index = 1;
fprintf(fid, '%d', index);
fprintf(fid, '%s', var1);
% fprintf(fid,'%s', var3);
%помещаем вершину в v_r и присваиваем ей спец код
[k, m] = find(I_n == index);
adj_v1 = m(1);
v_r(1, 1) = m(1);
vertex = m(1);
index_v_r(1, 1) = 1;
kk = 2;
test_v_e = ones(1, length(I_n));
while (1)
     if (test_v_e & v_e)
         break;
     end
    temp_vertex = 0;
    %находим окружение вершины
%     v_v = [];
    if (f == 1)
        v_v = neighbors_digraph(Matrix_adj, vertex);
    else
        v_v = neighbors(G, vertex);
    end
    [min_v1, flag1, min_ind1, min_v2, flag2, min_ind2] = min_find(vertex, v_v, Matrix_adj, I_n);
    if (flag2 == 0 && flag1 == 0)
        temp_vertex = 0;
    elseif (flag1 ~= 0 && flag2 == 0 && Matrix_adj(vertex, min_v1) ~= 0)
        temp_vertex = min_v1;
        ind = I_n(min_v1);
        I1(min_v1) = 0;
    elseif (flag2 ~= 0 && flag1 ~= 0)
        if(min_v1 ~= min_v2)
        %нашли вершину с наименьшим индексом
%         temp_vertex = min(min_v1, min_v2);
            if (min_ind1 < min_ind2 && Matrix_adj(vertex, min_v1) ~= 0)
                temp_vertex = min_v1;
                ind = I_n(min_v1);
                I1(min_v1) = 0;
            
            elseif (min_ind2 < min_ind1 && Matrix_adj(vertex, min_v2) ~= 0)
                temp_vertex = min_v2;
                ind = I_n(min_v2);
                I1(min_v2) = 0;
            
            else
                %индекс совпали -> ищем минимальный индекс ребра
                v1 = min_v1; v2 = min_v2;
                edges = I_e.edge;
                if (f == 0)
                    N = sum(sum(Adj))/2;
                else
                    N = sum(sum(Adj));
                end
                num_node1 = 0; num_node2 = 0;
                for i= 1:N
                    edges = I_e(i).edge;
                    if (num_node1 ~= 0 && num_node2 ~= 0)
                        break;
                    end
                    if(edges(1, 1) == vertex && edges(1, 2) == v1 ||...
                        edges(1, 1) == v1 && edges(1, 2) == vertex)
                        num_node1 = I_e(i).class_edge;
                    end
                    if(edges(1, 1) == vertex && edges(1, 2) == v2 ||...
                        edges(1, 1) == v2 && edges(1, 2) == vertex)
                        num_node2 = I_e(i).class_edge;
                    end
                end
                if (num_node1 ~= num_node2)
                    %приоритет отдается вершине с меньшим индексом ребра
                        if (num_node1 < num_node2 && Matrix_adj(vertex, v1) ~= 0)
                            temp_vertex = v1;
                            ind = I_n(v1);
                            I1(v1) = 0;
                        end
                        if (num_node2 < num_node1 && Matrix_adj(vertex, v2) ~= 0 )
                            temp_vertex = v2;
                            ind = I_n(v2);
                            I1(v2) = 0;
                        end
                    else
                    %если индексы ребер совпали
                    max_kod = max(index_v_r);
                    kod = 1;
                    d1 = 0; d2 = 0;
                    while (kod < max_kod)
                        %смотрим кратчайшие растояния до вершин с идексами 1, 2,
                        %m-1
                        [P1,d1] = shortestpath(G, vertex, v1);
                        [P2,d2] = shortestpath(G, vertex, v2);
                        if (d1 == d2)
                            kod = kod + 1;
                        else
                            break;
                        end
                    end
                    if (d1 < d2 || kod == max_kod && Matrix_adj(vertex, v1) ~= 0)
                        %kod == max_kod - условие отвечает за то, что если мы не
                        %различили вершины, берем любую - первую
                        temp_vertex = v1;
                        ind = I_n(v1);
                        I1(v1) = 0;
                    elseif (Matrix_adj(vertex, v2) ~= 0)
                        temp_vertex = v2;
                        ind = I_n(v2);
                        I1(v2) = 0;
                    end
                end
            end
        end
    end

    if (temp_vertex ~= 0)
        v_r(kk) = temp_vertex;
        index_v_r(kk) = kk;
        kk = kk + 1;
        adj_v2 = temp_vertex;
        Matrix_adj(adj_v1, adj_v2) = Matrix_adj(adj_v1, adj_v2) - 1;
        if (f == 0)
            Matrix_adj(adj_v2, adj_v1) = Matrix_adj(adj_v2, adj_v1) - 1;
        end
        class_node = find_class_node(I_e, Nn, adj_v1, adj_v2);
        fprintf(fid, '%s', var4);
        fprintf(fid, '%d', class_node);
        fprintf(fid, '%s', var5);
        fprintf(fid, '%s', var3);
        fprintf(fid, '%d', ind);
        fprintf(fid, '%s', var1);
        type('notation.txt');

        adj_v1 = temp_vertex;
        %рекурсивный шаг 3:
        if (f == 0)
            G1 = graph(Matrix_adj);
        else
            G1 = digraph(Matrix_adj);
        end
%         Matrix_adj
        [mass_v, vvv] = fun(G1, temp_vertex, v_r, index_v_r);
        for j = 1:length(mass_v)
            Matrix_adj(temp_vertex, vvv(j)) = Matrix_adj(temp_vertex, vvv(j)) - 1;
            if (f == 0)
                Matrix_adj(vvv(j), temp_vertex) = Matrix_adj(vvv(j), temp_vertex) - 1;
            end
            class_node = find_class_node(I_e, Nn, temp_vertex, vvv(j));
            fprintf(fid, '%s', var4);
            fprintf(fid, '%d', class_node);
            fprintf(fid, '%s', var5);
            fprintf(fid, '%s', var3);
            fprintf(fid, '%s', '#');
            fprintf(fid, '%d', mass_v(j));
%             fprintf(fid, '%s', ';');
            type('notation.txt');
        end
        vertex = v_r(kk - 1);
    else
      [k, m] = find(v_r == vertex);
      v_r(m) = 0;
      kk = kk-1;
      index_v_r(m) = 0;
      pp = 0;
      for (i = 1:length(I_n))
        if (Matrix_adj(i, vertex) == 0 && Matrix_adj(vertex, i) == 0)
            pp = pp+ 1;
        end
      end
      if (pp == length(I_n))
          v_e(vertex) = 1;
      end
      fprintf(fid, '%s', var2);
      [k, m] = find(index_v_r == max(index_v_r));
      vertex = v_r(m);
      adj_v1 = vertex(1);
      
      if ((adj_v1 == 0) && length(find(v_e == 0)) > 0)
        ver = find(v_e == 0);
        index = min(I_n(ver));
        fprintf(fid, '%s', var7);
        fprintf(fid, '%d', index);
        fprintf(fid, '%s', var1);
        % fprintf(fid,'%s', var3);
        %помещаем вершину в v_r и присваиваем ей спец код
        [k, m] = find(I_n == index);
        for (i = 1:length(m))
            if (v_e(m(i)) == 0)
                break;
            end
        end
        adj_v1 = m(i);
        v_r(1, 1) = m(i);
        vertex = m(i);
        index_v_r(1, 1) = 1;
        kk = 2;
      end
    end
    
end
fclose(fid);
type('notation.txt');
end
