-- This is the original script from BontyHunter4567
local larm = script.Parent:FindFirstChild("Left Arm")
local rarm = script.Parent:FindFirstChild("Right Arm")

function findNearestTorso(pos)
local list = game.Workspace:children()
local torso = nil
local dist = 10
local temp = nil
local human = nil
local temp2 = nil
for x = 1, #list do
temp2 = list[x]
if (temp2.className == "Model") and (temp2 ~= script.Parent) then
temp = temp2:findFirstChild("Torso")
human = temp2:findFirstChild("Humanoid")
if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
if (temp.Position - pos).magnitude < dist then
torso = temp
dist = (temp.Position - pos).magnitude
end end end end return torso end 

while wait(.01) do
local target = findNearestTorso(script.Parent.Torso.Position)
if target ~= nil then 
if (script.Parent:findFirstChild("ForceField")) or (target.Parent:findFirstChild("ForceField")) or (target.Position.Y < script.Parent["Right Leg"].Position.Y) then 
else 
script.Parent.Humanoid:MoveTo(target.Position + Vector3.new(math.random(1,3),0,math.random(1,3)), target)
wait(.15) 
script.Parent.Humanoid:MoveTo(target.Position - Vector3.new(math.random(1,3),0,math.random(1,3)), target)
end end end 