function out = extractfield_blank2nan(StructureName,FieldName)
n = length(StructureName);
for i = 1:n
    if isempty(StructureName(i).(FieldName))
        StructureName(i).(FieldName) = nan;
    end
end

out = extractfield(StructureName,FieldName);