%% �������, ������������ ������� ������� ����������� ������
function[indexes] = nodeindex(p)
% ���������� ���������� ������ � �������������
vertex_count = size(p, 2);
indexes = zeros(1, vertex_count);
current_index = 1;

% �������� �� ���� ������� ������
for current_class = 1:vertex_count
    % �������� ������� �� ������ ������
    class_nodes = unique(p(:, current_class))';
    % ���������� �� �������
    nodes_indexes = indexes(class_nodes);
    % ���� ����� ���� ������ ������� � ������ �� ���������
    for j = 1:length(nodes_indexes)
        class_nodes = unique([class_nodes, find(indexes == nodes_indexes(j) & indexes ~= 0)]);
    end
    
    % ������� ����� ���� �������� �����������
    min_index = min(nodes_indexes(nodes_indexes ~= 0));
    % ���� ��������� ������ �� ������ ������ ����� ������ ������� - �������������� ��
    if (~isempty(min_index))
        indexes(class_nodes) = min_index;
    else
        indexes(class_nodes) = current_index;
        current_index = current_index + 1;
    end
end
end
