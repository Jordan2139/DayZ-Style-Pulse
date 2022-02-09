--------------------------------------------------------------
-- Pulse Plus - A Simple FiveM Script, Made By Jordan.#2139 --
--------------------------------------------------------------

config = {
    use_chat = false, -- Display alerts and responsed in the chat box or above the mini map
    auto_pulse = true, -- Would you like the players pulse to be determined by their health automatically? (They will still have the option to set their own either way)
    set_pulse = true, -- Would you like to allow the players to set their own pulse? 
    only_dead = true, -- Should the option to check a players pulse only show then their health is 0, aka they are dead
    max_pulse = 200, -- How high can they set their pulse before dying?
    min_pulse = 35, -- How low can they set their pulse before dying?
    PopUpPrompt = '[E] Check Pulse', -- The prompt they get when they are close enought to a person to check their pulse
    Keybind = 86, -- The keybind to check a persons pulse
    DistToSee = 0.75, -- How close you have to be to a player to see the pop up 
    TextSize = 0.8, -- How large should the text be on their body
}