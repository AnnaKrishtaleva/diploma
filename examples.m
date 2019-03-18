clc; % ������� �������
clear; % �������� ���������� �� ������

%% ����������� ���� ����� ���� ������
s = [1 2 2 3 4 5];
t = [2 3 5 4 2 1];
% ����������� ���������� ����
w = [1 1 1 1 1 1];

%% ���������� �����
G = digraph(s, t, w);
% G = graph(s, t);

%% ���������� ������� ��������� �����
A = full(adjacency(G, 'weighted'))
% A = full(adjacency(G))

%% ������� ������� ������ ��������������� ��������� ������� ���������
p_max = maxicode(A)

%% ����������� ������� ���������, ��������������� ���������
A_max = A(p_max(1, :), p_max(1, :))

%% ������� ������� ������� ����������� ������
I_n = nodeindex(p_max);

%% ������� ������� ������� ����������� �����
[I_e, num_class_result] = edges_map_digraph(G.Edges.EndNodes, A_max, p_max(1, 1:end), I_n);
% [I_e, num_class_result] = edges_map(G.Edges.EndNodes, A_max, p_max(1, 1:end), I_n);
I_e
num_class_result

lin_notation(I_n, I_e, G, A, 1)
N  = length(I_n);
M = length(I_e);

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