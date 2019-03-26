clc; % очистка консоли
clear; % удаление переменных из памяти

%% Определение ребёр через пары вершин
s = [1 2 2 3 4 5];
t = [2 3 5 4 2 1];
% Определение количества ребёр
w = [1 1 1 1 1 1];

%% Построение графа
G = digraph(s, t, w);
% G = graph(s, t);

%% Построение матрицы смежности графа
A = full(adjacency(G, 'weighted'))
% A = full(adjacency(G))

%% Нахождение порядков вершин, соответствующих максикоду матрицы смежности
p_max = maxicode(A)

%% Расчёт матрицы смежности, соответствующую максикоду
p_max_1 = p_max(1, :);
A_max = A(p_max_1, p_max_1)

%% Нахождение индексов классов изоморфизма вершин
I_n = nodeindex(p_max);

%% Нахождение индексов классов изоморфизма ребёр
[I_e, num_class_result] = edges_map_digraph(G.Edges.EndNodes, A_max, p_max(1, 1:end), I_n);
% [I_e, num_class_result] = edges_map(G.Edges.EndNodes, A_max, p_max(1, 1:end), I_n);
num_class_result

%% Построение линейной нотации
lin_notation(I_n, I_e, G, A, 1)
%lin_notation(I_n, I_e, G, A, 0)
N  = length(I_n);

a = 'abcdefghijklmnopqrstvwxyz';
names = num2cell(a(1:N));
nan = num2str(I_n(:));

for i = 1:N
    nn(i) = strcat(names(i), "=", nan(i));
end
G = digraph(s,t,[I_e.class_edge],nn);
% G = graph(s,t,[I_e.class_edge],nn);
h = plot(G,'Layout','force','EdgeLabel',G.Edges.Weight);
h.LineWidth = 1.5;