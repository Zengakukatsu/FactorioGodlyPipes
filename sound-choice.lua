-- roll is 0-1 Below 100% leaves a silent outcome
return function(chances, roll)
  local total = 0
  for _, chance in ipairs(chances) do
    total = total + chance
  end
  local remaining = roll * math.max(100, total)
  for index, chance in ipairs(chances) do
    if remaining < chance then
      return index
    end
    remaining = remaining - chance
  end
  return nil
end
