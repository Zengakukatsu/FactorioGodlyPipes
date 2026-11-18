local prototypes = {}
for index, sound in ipairs(require("sounds")) do
  prototypes[#prototypes + 1] = {
    type = "double-setting",
    name = "pipe-sounds-chance-" .. sound.id,
    setting_type = "runtime-per-user",
    default_value = sound.chance,
    minimum_value = 0,
    maximum_value = 100,
    order = "a-" .. index
  }
end
data:extend(prototypes)
