% 2. Filter for values contained in a set
function filteredData = filterStructureByFieldsContainValue(data, fieldNames, fieldValues)
    % Filter structure for values contained in a specified set (e.g., using ismember)
    validIndices = [];
    for i = 1:length(data)
        if isEntryContainValue(data(i), fieldNames, fieldValues)
            validIndices = [validIndices, i];
        end
    end
    filteredData = data(validIndices);
end

function isValid = isEntryContainValue(entry, fieldNames, fieldValues)
    isValid = true;
    for j = 1:length(fieldNames)
        if ~ismember(entry.(fieldNames{j}), fieldValues{j})
            isValid = false;
            break;
        end
    end
end