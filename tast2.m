clc; clear; %%close all;
set(0,'defaulttextfontsize',18);
% s = [1 2 3 1]; %квадрат
% t = [2 3 4 4];

% s = [1 2 3]; %треугольник
% t = [2 3 1];

% s = [1 2 3 4 5]; %пятиугольник
% t = [2 3 4 5 1];

% s = [1 1 1 2 2 3 3 4]; %G2
% t = [2 4 5 3 5 4 5 5];
% % 
% s = [1 1 1 1 2 2 2 3 3 3 4 4 5 5 5 6 6 7];
% t = [2 4 5 8 3 5 6 4 6 7 7 8 6 7 8 7 8 8];

% s = [1 1];
% t = [2 3];

% s = [1 2 2 3 3 4]; %G1
% t = [2 3 5 4 5 5];
% % 
% s = [1 1 1 2 2 3 4 4 5]; %G3!!!
% t = [2 3 4 3 5 6 5 6 6];

% s = [1 1 1 1 2 2 2 3 3 4 4 5 5 6 6 7 7 8]; %реберный граф для G3
% t = [4 5 2 3 5 6 3 4 6 7 9 7 8 8 9 8 9 9];

% s = [1 2 2 3 4]; %H
% t = [2 3 5 4 5];

% s = [1 2 3]; %граф P
% t = [2 3 4];

% s = [1 1 2 2 3 5 5 6 ]; %гамильтонов пуить
% t = [2 5 3 4 4 6 7 7 ];

% s = [1 2 2 3 4];
% t = [2 3 4 4 5];
% 
% s = [1 1];
% t = [2 3];

% s = [1 2 2 2 3];
% t = [2 3 5 4 4];

% s = [1 1 1 3 3  4 4 7 7 9  10];
% t = [2 3 4 6 10 5 7 8 9 10 11];

% s = [1 2 2  3 4 5 5 6 6 9  10];
% t = [2 3 10 4 5 6 9 7 8 10 11];

% s =[1 2 2 2 5 5 5 8];
% t =[2 3 4 5 6 7 8 9];

% s = [1 2 3 3  4 5 5 6 8 9  9];
% t = [2 3 4 11 5 6 8 7 9 10 11];

% s = [1 2 2 2 5 5 7]; %химичеких граф уксус
% t = [2 3 4 5 6 7 8];

% s = [1 1 1 1 2 2 2 8]; %этан
% t = [2 3 4 5 6 7 8 9];

% s = [1 1 1 2 4]; %для ориент
% t = [2 3 4 3 3];
% s = [1 1 2 3 4 4 5];
% t = [2 4 3 1 3 5 1];
% s = [1 2 3];
% t = [2 3 1];
% s = [2 2 2 5 5];
% t = [1 3 4 3 4];
% s = [1 1 3 3 5 5];
% t = [2 6 2 4 4 6];
% s = [1 1 2 2 3 3];
% t = [2 5 3 6 1 4];
% s = [1 2 3 4 5 5 5];
% t = [2 3 4 5 1 2 3];
% s = [1 1 1 2 3 4 5 5 6 7];
% t = [2 3 4 6 6 5 6 7 8 8];
s = [1 1 2];
t = [2 3 3];
% s = [1 2 3 3 4 5 5 6 8 9 9]; %для 3,5-диэтилтолуола
% t = [2 3 4 11 5 6 8 7 9 10 11];

% s = [1 2 2  3 3 5 6 6 8 8  10];
% t = [2 3 10 4 5 6 7 8 9 10 11];

G = graph(s,t);
A = adjacency(G);
Adj = full(A);
% Adj = [1 1 1; 
%        1 0 1; 
%        1 1 0];

[Max_matrix, max_v] = maxikod(Adj);
max_v
Max_matrix

I = isomorphism_nodes(max_v);
I = [1 2 2];

[E, num_class_result] = edges_map(G.Edges.EndNodes, Max_matrix, max_v(1, 1:end), I);
%[E, num_class_result] = edges_map([1 2; 1 2; 1 3; 1 3; 2 3], Max_matrix, max_v(1, 1:end), I);
E

num_class_result

lin_notation(I, E, G, Adj, 0)
N  = length(I);
M = length(E);
weights = zeros(1, M);
for i = 1:M
    weights(i) = E(i).class_edge;
end

a = ['abcdefghijklmnopqrstvwxyz'];
names = num2cell(a(1:N));
nan = num2str(I(:));
s3 = '=';

for i = 1:N
    nn(i) = strcat(names(i), s3, nan(i));
end
text('FontSize', 14);
weights = [2 2 3];
G = graph(s,t,weights,nn);
h = plot(G,'Layout','force','EdgeLabel',G.Edges.Weight);
h.LineWidth = 1.5;