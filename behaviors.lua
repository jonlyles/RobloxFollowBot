--Forked by TheEagleGuy from BontyHunter4567
local Model = script.Parent
local Backup = Model:clone()

function Respawn()
	Model:breakJoints()

	wait(5)

	script.Parent = Model.Parent

	Model:remove()
	Model = Backup:clone()
	Model.Parent = script.Parent
	Model:makeJoints()

	script:remove()
end

Model.Humanoid.Died:connect(Respawn)

function waitForChild(parent, childName)
	local child = parent:findFirstChild(childName)

	if child then
		return child
	end

	while true do
		print(childName)

		child = parent.ChildAdded:wait()

		if child.Name==childName then
			return child
		end
	end
end

-- declarations

local Figure = script.Parent
local Head = waitForChild(Figure, "Head")
local Humanoid = waitForChild(Figure, "Humanoid")

Figure.PrimaryPart = Head

-- ANIMATION

function Joint(Name, Part0, Part1, C0, C1, MaxVelocity)
	local Motor = Instance.new("Motor")

	Motor.C0 = C0
	Motor.C1 = C1
	Motor.MaxVelocity = MaxVelocity
	Motor.Name = Name
	Motor.Parent = Part0
	Motor.Part0 = Part0
	Motor.Part1 = Part1
end

-- declarations

local Torso = waitForChild(Figure, "Torso")
local LeftArm = waitForChild(Figure, "Left Arm")
local LeftLeg = waitForChild(Figure, "Left Leg")
local RightArm = waitForChild(Figure, "Right Arm")
local RightLeg = waitForChild(Figure, "Right Leg")

local Joints = {
{"Right Shoulder", Torso, RightArm, CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0), CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0), 0.5},
{"Left Shoulder", Torso, LeftArm, CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0), CFrame.new(0.5, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0), 0.5},
{"Right Hip", Torso, RightLeg, CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0), CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0), 0.10000000149012},
{"Left Hip", Torso, LeftLeg, CFrame.new(-1, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0), CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0), 0.10000000149012},
{"Neck", Torso, Head, CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0), CFrame.new(0, -0.5, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0), 0.10000000149012}}

Torso:breakJoints()

for _, v in pairs(Joints) do
	Joint(unpack(v))
end

local RightShoulder = waitForChild(Torso, "Right Shoulder")
local LeftShoulder = waitForChild(Torso, "Left Shoulder")
local RightHip = waitForChild(Torso, "Right Hip")
local LeftHip = waitForChild(Torso, "Left Hip")
local Neck = waitForChild(Torso, "Neck")
local Humanoid = waitForChild(Figure, "Humanoid")
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0

-- functions

function onRunning(speed)
	if speed>0 then
		pose = "Running"
	else
		pose = "Standing"
	end
end

function onDied()
	pose = "Dead"
end

function onJumping()
	pose = "Jumping"
end

function onClimbing()
	pose = "Climbing"
end

function onGettingUp()
	pose = "GettingUp"
end

function onFreeFall()
	pose = "FreeFall"
end

function onFallingDown()
	pose = "FallingDown"
end

function onSeated()
	pose = "Seated"
end

function onPlatformStanding()
	pose = "PlatformStanding"
end

function moveJump()
	RightShoulder.MaxVelocity = 0.5
	LeftShoulder.MaxVelocity = 0.5
	RightShoulder.DesiredAngle = 3.14
	LeftShoulder.DesiredAngle = -3.14
	RightHip.DesiredAngle = 0
	LeftHip.DesiredAngle = 0
end


-- same as jump for now

function moveFreeFall()
	RightShoulder.MaxVelocity = 0.5
	LeftShoulder.MaxVelocity = 0.5
	RightShoulder.DesiredAngle = 3.14
	LeftShoulder.DesiredAngle = -3.14
	RightHip.DesiredAngle = 0
	LeftHip.DesiredAngle = 0
end

function moveSit()
	RightShoulder.MaxVelocity = 0.15
	LeftShoulder.MaxVelocity = 0.15
	RightShoulder.DesiredAngle = 3.14 /2
	LeftShoulder.DesiredAngle = -3.14 /2
	RightHip.DesiredAngle = 3.14 /2
	LeftHip.DesiredAngle = -3.14 /2
end

function getTool()	
	for _, kid in ipairs(Figure:GetChildren()) do
		if kid.className == "Tool" then return kid end
	end
	return nil
end

function getToolAnim(tool)
	for _, c in ipairs(tool:GetChildren()) do
		if c.Name == "toolanim" and c.className == "StringValue" then
			return c
		end
	end
	return nil
end

function animateTool()
	
	if (toolAnim == "None") then
		RightShoulder.DesiredAngle = 1.57
		return
	end

	if (toolAnim == "Slash") then
		RightShoulder.MaxVelocity = 0.5
		RightShoulder.DesiredAngle = 0
		return
	end

	if (toolAnim == "Lunge") then
		RightShoulder.MaxVelocity = 0.5
		LeftShoulder.MaxVelocity = 0.5
		RightHip.MaxVelocity = 0.5
		LeftHip.MaxVelocity = 0.5
		RightShoulder.DesiredAngle = 1.57
		LeftShoulder.DesiredAngle = 1.0
		RightHip.DesiredAngle = 1.57
		LeftHip.DesiredAngle = 1.0
		return
	end
end

function move(time)
	local amplitude
	local frequency
  
	if (pose == "Jumping") then
		moveJump()
		return
	end

	if (pose == "FreeFall") then
		moveFreeFall()
		return
	end
 
	if (pose == "Seated") then
		moveSit()
		return
	end

	local climbFudge = 0
	
	if (pose == "Running") then
		RightShoulder.MaxVelocity = 0.15
		LeftShoulder.MaxVelocity = 0.15
		amplitude = 1
		frequency = 9
	elseif (pose == "Climbing") then
		RightShoulder.MaxVelocity = 0.5 
		LeftShoulder.MaxVelocity = 0.5
		amplitude = 1
		frequency = 9
		climbFudge = 3.14
	else
		amplitude = 0.1
		frequency = 1
	end

	desiredAngle = amplitude * math.sin(time*frequency)

	RightShoulder.DesiredAngle = desiredAngle + climbFudge
	LeftShoulder.DesiredAngle = desiredAngle - climbFudge
	RightHip.DesiredAngle = -desiredAngle
	LeftHip.DesiredAngle = -desiredAngle


	local tool = getTool()

	if tool then
	
		animStringValueObject = getToolAnim(tool)

		if animStringValueObject then
			toolAnim = animStringValueObject.Value
			-- message recieved, delete StringValue
			animStringValueObject.Parent = nil
			toolAnimTime = time + .3
		end

		if time > toolAnimTime then
			toolAnimTime = 0
			toolAnim = "None"
		end

		animateTool()

		
	else
		toolAnim = "None"
		toolAnimTime = 0
	end
end


-- connect events

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)

-- util

function waitForChild(parent, childName)
	local child = parent:findFirstChild(childName)
	if child then return child end
	while true do
		child = parent.ChildAdded:wait()
		if child.Name==childName then return child end
	end
end

function newSound(id)
	local sound = Instance.new("Sound")
	sound.SoundId = id
	sound.archivable = false
	sound.Parent = script.Parent.Head
	return sound
end

-- declarations

local sDied = newSound("rbxasset://sounds/uuhhh.wav")
local sFallingDown = newSound("rbxasset://sounds/splat.wav")
local sFreeFalling = newSound("rbxasset://sounds/swoosh.wav")
local sGettingUp = newSound("rbxasset://sounds/hit.wav")
local sJumping = newSound("rbxasset://sounds/button.wav")
local sRunning = newSound("rbxasset://sounds/bfsl-minifigfoots1.mp3")
sRunning.Looped = true

-- functions

function onSoundDied()
	sDied:Play()
end

function onState(state, sound)
	if state then
		sound:Play()
	else
		sound:Pause()
	end
end

function onSoundRunning(speed)
	if speed>0 then
		sRunning:Play()
	else
		sRunning:Pause()
	end
end

-- connect up

Humanoid.Died:connect(onSoundDied)
Humanoid.Running:connect(onSoundRunning)
Humanoid.Jumping:connect(function(state) onState(state, sJumping) end)
Humanoid.GettingUp:connect(function(state) onState(state, sGettingUp) end)
Humanoid.FreeFalling:connect(function(state) onState(state, sFreeFalling) end)
Humanoid.FallingDown:connect(function(state) onState(state, sFallingDown) end)

local runService = game:service("RunService");

delay(0, function() 
	while Figure.Parent~=nil do
		local _, time = wait(0.1)
		move(time)
	end
end)

-- regeneration
while true do
	local s = wait(1)
	local health = Humanoid.Health

	if health > 0 and health < Humanoid.MaxHealth then
		health = health + 0.01 * s * Humanoid.MaxHealth

		if health * 1.05 < Humanoid.MaxHealth then
			Humanoid.Health = health
		else
			Humanoid.Health = Humanoid.MaxHealth
		end
	end
end