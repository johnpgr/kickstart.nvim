local function merge(arr1, arr2)
    local result = {}

    -- Move elements from the first array to the result table
    table.move(arr1, 1, #arr1, #result + 1, result)

    -- Move elements from the second array to the result table
    table.move(arr2, 1, #arr2, #result + 1, result)

    return result
end

return {
    merge = merge
}
