%% Функция, возвращающая перестановки с повторением
function [y] = permn(x, K)
C = cell(K, 1);             %// Preallocate a cell array
[C{:}] = ndgrid(x);         %// Create K grids of values
y = cellfun(@(x){x(:)}, C); %// Convert grids to column vectors
y = [y{:}];                 %// Obtain all permutations
end