--[[
NOTE: THIS IS NOT THE INFLIB PLUGIN, THIS IS A SCRIPT TO HELP YOU DOWNLOAD IT
Once you have executed this, read the rest of the tutorial:
https://github.com/flamespill/InfLib/blob/main/README.md#how-to-download
]]
if isfile("InfLib") then notify("InfLib", 'InfLib is already downloaded.') return end
writefile("InfLib.iy", 'return loadstring(game:HttpGet("https://raw.githubusercontent.com/flamespill/InfLib/refs/heads/main/Core/Main.lua"))()')
