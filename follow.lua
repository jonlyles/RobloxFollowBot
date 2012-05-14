-- Finds all Humanoids in SearchArea
-- Returns HumanoidsList, a table of all Humanoids in the SearchArea
print("Executing game.Workspace.FollowBot.Follow.lua")
function GetHumanoids( SearchArea )
    local HumanoidsList = {}
    -- Default SearchArea is Workspace
    SearchArea = SearchArea or game.Workspace
    assert( SearchArea == 'Workspace' or SearchArea:isDescendantOf(game), "Error: SearchArea must be Workspace or a descendant of Workspace.")     
    -- Check all children of SearchArea
    assert( type(SearchArea:GetChildren()) == 'table', "Error: SearchArea wrong type, expected table, received " .. type(SearchArea))
    for key,val in pairs(SearchArea:GetChildren()) do
        -- Check if its ClassName is Model
        if val.ClassName == "Model" then
            for k,v in pairs(val:GetChildren()) do
               -- Check if its ClassName is Humanoid.
               if v.ClassName == "Humanoid" then
                   -- If ClassName is Humanoid, add it to PlayerList
                   table.insert(HumanoidsList,val)
               end
            end 
        end
    end
    return HumanoidsList
end


-- Takes a table of Humanoids and removes self (script.Parent), and 
-- removes any Humanoid that is dead ( Health == 0 )
-- @param HumanoidsList, table containing 
-- @return HumanoidsList, table (clean)
function CleanHumanoids( HumanoidsList )
    assert( type(HumanoidsList) == 'table' )
    local HumanoidsClean = {}
    for x = 1, #HumanoidsList do
    assert( HumanoidsList[x].Humanoid.Health, "Asertion failed! Follow.lua, Health is not a property of HumanoidsList[x].Humanoid") 
        if HumanoidsList[x] ~= script.Parent and HumanoidsList[x].Humanoid.Health ~= 0 then
            table.insert( HumanoidsClean, HumanoidsList[x] )
        end
    end
    HumanoidsList = HumanoidsClean
    return HumanoidsList
end


-- Takes a table of Humanoids and determines which is closest
-- @param pos, Vector3 Position 
-- @param HumanoidsList, table containing Humanoids
-- @return NearestHumanoid
function GetTargetHumanoid( Follower, HumanoidsList )
    assert( type(HumanoidsList) == 'table' )
    local TargetHumanoid = nil
    local candidate = nil
    local distance = 25
        
    for x = 1, #HumanoidsList do
        candidate = HumanoidsList[x]
        assert( candidate.Humanoid )
        if ( candidate.Torso.Position - Follower.Position ).magnitude < distance then
            TargetHumanoid = candidate
            assert( TargetHumanoid ~= nil, "Function GetTargetHumanoid: TargetHumanoid is nil") 
        end 
    end
    return TargetHumanoid    
end 

-- Follows a target
-- @param NearestHumanoid, this is the target
-- @param Follower, this is who will follow
-- @return returns a callback, where to move the follower
function FollowTarget(TargetHumanoid,Follower)
    local TargetHumanoid = TargetHumanoid or nil
    local Follower = Follower or nil
    local distance = (TargetHumanoid.Torso.Position - Follower.Position).magnitude
    assert( TargetHumanoid ~= nil, "FollowTarget: TargetHumanoid is nil")
    assert( Follower ~= nil, "FollowTarget: Follower is nil")
    repeat 
        repeat 
            wait(.5)            
        until ( TargetHumanoid.Torso.Position - Follower.Position ).magnitude >= distance
            repeat
                wait(.15)
                script.Parent.Humanoid:MoveTo(TargetHumanoid.Torso.Position + Vector3.new(math.random(1,3),0,math.random(1,3)), TargetHumanoid.Torso)
            until ( TargetHumanoid.Torso.Position - Follower.Position ).magnitude < distance        
    until TargetHumanoid.Humanoid.Health == 0 -- @todo: condition needs improvement 
end

function TalkToTarget( Follower )
    local head = Follower.Parent.Head
    assert( head )
    local text = Instance.new('Dialog',Workspace)
    assert( text )
    text.Parent = head
    text.Purpose = 0 --quest
    text.Tone = 1 --friendly tone
    text.DialogChoiceSelected:connect(function(player,choice)
        text.InitialPrompt = "I love you" .. player.Name
        wait(5)
        text:Destroy()
    end)
end

-- Run
local Follower = script.Parent.Torso
local HumanoidsList = GetHumanoids()
assert( type(HumanoidsList) == 'table', "Error: HumanoidsList not a table")
assert( HumanoidsList ~= nil, "Error: HumanoidsList is empty")
HumanoidsList = CleanHumanoids(HumanoidsList)
print(HumanoidsList)
local TargetHumanoid = nil

repeat wait() 
TargetHumanoid = GetTargetHumanoid( Follower, HumanoidsList )
until TargetHumanoid ~= nil
assert(TargetHumanoid ~= nil )
-- Finds all Humanoids in SearchArea
-- Returns HumanoidsList, a table of all Humanoids in the SearchArea
print("Executing game.Workspace.FollowBot.Follow.lua")
function GetHumanoids( SearchArea )
    local HumanoidsList = {}
    -- Default SearchArea is Workspace
    SearchArea = SearchArea or game.Workspace
    assert( SearchArea == 'Workspace' or SearchArea:isDescendantOf(game), "Error: SearchArea must be Workspace or a descendant of Workspace.")     
    -- Check all children of SearchArea
    assert( type(SearchArea:GetChildren()) == 'table', "Error: SearchArea wrong type, expected table, received " .. type(SearchArea))
    for key,val in pairs(SearchArea:GetChildren()) do
        -- Check if its ClassName is Model
        if val.ClassName == "Model" then
            for k,v in pairs(val:GetChildren()) do
               -- Check if its ClassName is Humanoid.
               if v.ClassName == "Humanoid" then
                   -- If ClassName is Humanoid, add it to PlayerList
                   table.insert(HumanoidsList,val)
               end
            end 
        end
    end
    return HumanoidsList
end


-- Takes a table of Humanoids and removes self (script.Parent), and 
-- removes any Humanoid that is dead ( Health == 0 )
-- @param HumanoidsList, table containing 
-- @return HumanoidsList, table (clean)
function CleanHumanoids( HumanoidsList )
    assert( type(HumanoidsList) == 'table' )
    local HumanoidsClean = {}
    for x = 1, #HumanoidsList do
    assert( HumanoidsList[x].Humanoid.Health, "Asertion failed! Follow.lua, Health is not a property of HumanoidsList[x].Humanoid") 
        if HumanoidsList[x] ~= script.Parent and HumanoidsList[x].Humanoid.Health ~= 0 then
            table.insert( HumanoidsClean, HumanoidsList[x] )
        end
    end
    HumanoidsList = HumanoidsClean
    return HumanoidsList
end


-- Takes a table of Humanoids and determines which is closest
-- @param pos, Vector3 Position 
-- @param HumanoidsList, table containing Humanoids
-- @return NearestHumanoid
function GetTargetHumanoid( Follower, HumanoidsList )
    assert( type(HumanoidsList) == 'table' )
    local TargetHumanoid = nil
    local candidate = nil
    local distance = 25
        
    for x = 1, #HumanoidsList do
        candidate = HumanoidsList[x]
        assert( candidate.Humanoid )
        if ( candidate.Torso.Position - Follower.Position ).magnitude < distance then
            TargetHumanoid = candidate
            assert( TargetHumanoid ~= nil, "Function GetTargetHumanoid: TargetHumanoid is nil") 
        end 
    end
    return TargetHumanoid    
end 

-- Follows a target
-- @param NearestHumanoid, this is the target
-- @param Follower, this is who will follow
-- @return returns a callback, where to move the follower
function FollowTarget(TargetHumanoid,Follower)
    local TargetHumanoid = TargetHumanoid or nil
    local Follower = Follower or nil
    local distance = (TargetHumanoid.Torso.Position - Follower.Position).magnitude
    assert( TargetHumanoid ~= nil, "FollowTarget: TargetHumanoid is nil")
    assert( Follower ~= nil, "FollowTarget: Follower is nil")
    repeat 
        repeat 
            wait(.5)            
        until ( TargetHumanoid.Torso.Position - Follower.Position ).magnitude >= distance
            repeat
                wait(.15)
                script.Parent.Humanoid:MoveTo(TargetHumanoid.Torso.Position + Vector3.new(math.random(1,3),0,math.random(1,3)), TargetHumanoid.Torso)
            until ( TargetHumanoid.Torso.Position - Follower.Position ).magnitude < distance
        
    until TargetHumanoid.Humanoid.Health == 0 --and other conditions to add later 
end

function TalkToTarget( Follower )
    local head = Follower.Parent.Head
    assert( head )
    local text = Instance.new('Dialog',Workspace)
    assert( text )
    text.Parent = head
    text.Purpose = 0 --quest
    text.Tone = 1 --friendly tone
    text.DialogChoiceSelected:connect(function(player,choice)
        text.InitialPrompt = "I love you" .. player.Name
        wait(5)
        text:Destroy()
    end)
end

-- Run
local Follower = script.Parent.Torso
local HumanoidsList = GetHumanoids()
assert( type(HumanoidsList) == 'table', "Error: HumanoidsList not a table")
assert( HumanoidsList ~= nil, "Error: HumanoidsList is empty")
HumanoidsList = CleanHumanoids(HumanoidsList)
print(HumanoidsList)
local TargetHumanoid = nil

repeat wait() 
TargetHumanoid = GetTargetHumanoid( Follower, HumanoidsList )
until TargetHumanoid ~= nil
assert(TargetHumanoid ~= nil )
print("game.Workspace.FollowBot.follow.lua: TargetHumanoid selected")
FollowTarget( TargetHumanoid, Follower )
