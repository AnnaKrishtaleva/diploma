%% Функция, возвращающая индексы классов изоморфизма вершин
function[indexes] = nodeindex(p)
% Определяем количество вершин в перестановках
vertex_count = size(p, 2);
indexes = zeros(1, vertex_count);
current_index = 1;

% Проходим по всем классам вершин
for current_class = 1:vertex_count
    % Выбираем вершины из одного класса
    class_nodes = unique(p(:, current_class))';
    % Определяем их индексы
    nodes_indexes = indexes(class_nodes);
    % Ищем среди всех вершин вершины с такими же индексами
    for j = 1:length(nodes_indexes)
        class_nodes = unique([class_nodes, find(indexes == nodes_indexes(j) & indexes ~= 0)]);
    end
    
    % Находим среди всех индексов минимальный
    min_index = min(nodes_indexes(nodes_indexes ~= 0));
    % Если несколько вершин из одного класса имеют разные индексы - переопределяем их
    if (~isempty(min_index))
        indexes(class_nodes) = min_index;
    else
        indexes(class_nodes) = current_index;
        current_index = current_index + 1;
    end
end
end
