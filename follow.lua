-- Finds all Humanoids in SearchArea
-- Returns HumanoidsList, a table of all Humanoids in the SearchArea
function GetHumanoids( SearchArea )
    local HumanoidsList = {}
    -- Default SearchArea is Workspace
    SearchArea = SearchArea or game.Workspace      
    -- Check all children of SearchArea
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
        if HumanoidsList[x] ~= script.Parent and HumanoidsList[x].Health ~= 0 then
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
    local distance = 10
        
    for x = 1, #HumanoidsList do
        candidate = HumanoidsList[x]
        assert( candidate.Humanoid )
        if ( candidate.Torso.Position - Follower.Position ).magnitude < distance then
            TargetHumanoid = candidate
            assert( TargetHumanoid ~= nil, "Function GetTargetHumanoid: TargetHumanoid is nil") 
            --distance = (candidate.Torso.Position - pos).magnitude  -- what is the purpose of this line?
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
    assert( TargetHumanoid ~= nil, "FollowTarget: TargetHumanoid is nil")
    assert( Follower ~= nil, "FollowTarget: Follower is nil")
    
    -- what is the purpose of this?
    -- if ( TargetHumanoid.Parent:findFirstChild("ForceField")) or (TargetHumanoid.Parent:findFirstChild("ForceField")) or (TargetHumanoid.Torso.Position.Y < script.Parent["Right Leg"].Position.Y) then     
    --else  
    repeat
        wait(.15)
        script.Parent.Humanoid:MoveTo(TargetHumanoid.Torso.Position + Vector3.new(math.random(1,3),0,math.random(1,3)), TargetHumanoid.Torso)
    until false
      --  @todo what is the condition to stop following the target??
      --  wait(.15) 
      --  script.Parent.Humanoid:MoveTo(TargetHumanoid.Torso.Position - Vector3.new(math.random(1,3),0,math.random(1,3)), TargetHumanoid.Torso)
    --end 
end

-- Run
local Follower = script.Parent.Torso
print(Follower)
assert( Follower ~= nil, "Follower is nil")
local HumanoidsList = GetHumanoids()
print(HumanoidsList)
HumanoidsList = CleanHumanoids(HumanoidsList)
print(HumanoidsList)
local TargetHumanoid = nil

repeat wait() 
TargetHumanoid = GetTargetHumanoid( Follower, HumanoidsList )
until TargetHumanoid ~= nil
print("TargetHumanoid selected")
FollowTarget( TargetHumanoid, Follower )
