clc; % очистка консоли
clear; % удаление переменных из памяти

%% Определение ребёр через пары вершин
s = [1 2 2 3 4 5];
t = [2 3 5 4 2 1];
% Определение количества ребёр
w = [1 1 1 1 1 1];

%% Построение ориентированного графа
G = digraph(s, t, w);

%% Построение матрицы смежности графа
A = full(adjacency(G, 'weighted'))

%% Построение матрицы достижимости графа
% Матрица достижимости содержит информацию обо всех путях длиной от 1 до количества ребёр в графе
% На первом шаге матрица достижимости равна матрице смежности (длина пути равна 1)
E = A;
for i = 2 : length(G.Edges.EndNodes)
    % Возводя матрицу смежности в степень i, мы определяем все пути длиной i
    % Затем объединяем её с путями предыдущих длин
    E = E | (A ^ i); 
end

%% Находим порядки вершин соответствующие максикоду матрицы достижимости
p_max = maxicode(A)

%% Расчитываем матрицу смежности, соответствующую максикоду
A_max = A(p_max(1, :), p_max(1, :))

%% Находим индексы классов изоморфизма вершин
I_n = nodeindex(p_max);

% [I_e, num_class_result] = edges_map_digraph([1 2; 1 2; 1 3; 1 3; 2 3], A_max, p_max(1, 1:end), I_n);
[I_e, num_class_result] = edges_map_digraph(G.Edges.EndNodes, A_max, p_max(1, 1:end), I_n);
I_e

num_class_result

lin_notation(I_n, I_e, G, A, 1)
N  = length(I_n);
M = length(I_e);
weights = zeros(1, M);
for i = 1:M
    weights(i) = I_e(i).class_edge;
end

a = ['abcdefghijklmnopqrstvwxyz'];
names = num2cell(a(1:N));
nan = num2str(I_n(:));
s3 = '=';

for i = 1:N
    nn(i) = strcat(names(i), s3, nan(i));
end
text('FontSize', 14);
weights = [1 2 3];
G = digraph(s,t,[I_e.class_edge],nn);
h = plot(G,'Layout','force','EdgeLabel',G.Edges.Weight);
h.LineWidth = 1.5;