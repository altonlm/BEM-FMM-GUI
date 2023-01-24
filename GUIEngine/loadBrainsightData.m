function matrices = loadBrainsightData(file)
A = readtable(file);
usefulData = A(:, [1 5:16]);
usefulDataCell = table2cell(usefulData);

for j=1:height(usefulDataCell)
    if (contains(usefulDataCell(j,1), 'Sample'))
        newData(j,:) = usefulDataCell(j,:);
    end
end

for j=1:length(newData)
    mat = [newData{j,5} newData{j,6} newData{j,7} newData{j,2}; ...
        newData{j,8} newData{j,9} newData{j,10} newData{j,3}; ...
        newData{j,11} newData{j,12} newData{j,13} newData{j,4}; ...
        0 0 0 1];

    correction = [0 -1 0;
                  1 0 0;
                  0 0 1];
    mat(1:3,1:3) = correction * mat(1:3, 1:3) * correction^0;
    matrices{j} = mat;
end
end