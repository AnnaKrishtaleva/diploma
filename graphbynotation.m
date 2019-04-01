%% Функция, возвращающая граф по его линейной нотации
function[G] = graphbynotation(notation)
%% Количество вершин совпадает с количеством квадратных скобок
node_count = length(notation(notation == '['));

%% Индексы классов изоморфизма вершин
indexes = zeros(1, node_count);

%% Путь
path = zeros(1, node_count);
%% Текущая длина пути
path_length = 0;

%% Матрица смежности исходного графа
A = zeros(node_count, node_count);

num = '';
is_loop = 0;

for i=1:length(notation)
    switch notation(i)
        case '['
            %% Индекс класса изоморфизма текущей вершины
            index = str2double(num);
            num = '';
            %% Нахождение индекса первого нулевого элемента
            node = find(indexes == 0, 1);
            %% Сохранение индекса текущей вершины
            indexes(node) = index;
            
            path_length = path_length + 1;
            path(path_length) = node;
            
            if (path_length > 1)
                %% Предыдущая вершина
                v_1 = path(path_length - 1);
                %% Текущая вершина
                v_2 = path(path_length);
                %% Добавление симметричных ребер в матрицу смежности
                A(v_1, v_2) = 1;
                A(v_2, v_1) = 1;
            end
            
            continue;
        case ']'
            path(path_length) = 0;
            path_length = path_length - 1;
            
            continue;
        case '('
            continue;
        case ')'
            continue;
        case '-'
            continue;
        case '>'
            num = '';
            
            continue;
        case '#'
            is_loop = 1;
            
            continue;
        otherwise
            %% Если встречаем цифру
            num = strcat(num, notation(i));
            
            %% Если мы в цикле и следующий символ не число, значит,
            %  мы находимся в вершине, на которой завершился цикл
            if (is_loop && isnan(str2double(notation(i + 1))))
                is_loop = 0;
                %% Предыдущая вершина
                v_1 = path(path_length);
                %% Текущая вершина
                v_2 = str2double(num);
                num = '';
                %% Добавление симметричных ребер в матрицу смежности
                A(v_1, v_2) = 1;
                A(v_2, v_1) = 1;
            end
            
            continue;
    end
end

G = graph(logical(A));

end