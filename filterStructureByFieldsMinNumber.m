% 3. Filter for fields with minimum number of elements
function filteredData = filterStructureByFieldsMinNumber(data, fieldName, minNumber)
    % Filter structure for fields that have a minimum number of elements
    validIndices = [];
    for i = 1:length(data)
        if length(entry.(fieldName)) >= minNumber
            validIndices = [validIndices, i];
        end
    end
    filteredData = data(validIndices);
end