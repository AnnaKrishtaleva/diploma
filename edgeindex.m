function[class_iso_edges] = edgeindex(E, I_n)
%% Количество рёбер
n = length(E);
%% Установка соответствия каждой вершины её индексу класса изоморфизма
I_e = I_n(E);
%% Сортировка направления каждого ребра (3 1 -> 1 3)
I_e = sort(I_e);
%% Добавление рёбер, чтобы не потерять при сортировке
I_e = [I_e; E];
%% Сортировка порядка списка ребёр
I_e = sortrows(I_e', [1 2]);
%% Определение индекса каждого ребра
[~,~,indexes] = unique(I_e(:,1:2),'rows', 'stable');
%% Добавление индексов
I_e = [I_e, indexes];

class_iso_edges = struct('edge', [], 'class_edge', 0);
for i = 1:n
    class_iso_edges(i).edge = I_e(i, [3 4]);
    class_iso_edges(i).class_edge = I_e(i, 5);
end
end