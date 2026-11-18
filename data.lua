local prototypes = {}
for _, sound in ipairs(require("sounds")) do
  prototypes[#prototypes + 1] = {
    type = "sound",
    name = "godly_pipes" .. sound.id,
    filename = "__godly_pipes__/sounds/pipe" .. sound.id .. ".wav",
    category = "game-effect",
    volume = 1
  }
end
data:extend(prototypes)
