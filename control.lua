local sounds = require("sounds")
local choose_sound = require("sound-choice")
local COOLDOWN_TICKS = 24 -- 2/5 second at the normal 60 ticks per second.

local function play_pipe_sound(player_index, tick)
  local player = game.get_player(player_index)
  if not player or not player.valid then return end

  storage.last_sound_tick = storage.last_sound_tick or {}
  local previous = storage.last_sound_tick[player_index]
  if previous and tick - previous < COOLDOWN_TICKS then return end

  local player_settings = settings.get_player_settings(player)
  local chances = {}
  for index, sound in ipairs(sounds) do
    chances[index] = player_settings["pipe-sounds-chance-" .. sound.id].value
  end
  local selected = choose_sound(chances, math.random())
  if not selected then return end

  player.play_sound{path = "godly_pipes" .. sounds[selected].id}
  storage.last_sound_tick[player_index] = tick
end

script.on_event(defines.events.on_built_entity, function(event)
  local entity = event.entity
  if not entity or not entity.valid or entity.name ~= "pipe" then return end
  local player = game.get_player(event.player_index)
  if not player or player.controller_type ~= defines.controllers.character then return end
  play_pipe_sound(event.player_index, event.tick)
end, {{filter = "name", name = "pipe"}})

script.on_event(defines.events.on_player_crafted_item, function(event)
  local stack = event.item_stack
  if stack and stack.valid_for_read and stack.name == "pipe" then
    play_pipe_sound(event.player_index, event.tick)
  end
end)

script.on_event(defines.events.on_player_removed, function(event)
  if storage.last_sound_tick then
    storage.last_sound_tick[event.player_index] = nil
  end
end)
