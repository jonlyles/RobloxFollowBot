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
function FindNearestHumanoid( pos, HumanoidsList )
    assert( type(HumanoidsList) == 'table' )
    local NearestHumanoid = nil
    local candidate = nil
    local distance = 10
        
    for x = 1, #HumanoidsList do
        candidate = HumanoidsList[x]
        if (candidate.Position - pos).magnitude < distance then
            NearestHumanoid = candidate
            distance = (candidate.Position - pos).magnitude  -- what is the purpose of this line?
        end 
    end 
    return NearestHumanoid 
end 

-- Follows a target
-- @param NearestHumanoid, this is the target
-- @param Follower, this is who will follow
-- @return returns a callback, where to move the follower
function FollowTarget(NearestHumanoid,Follower)
    assert( NearestHumanoid ~= nil and Follower ~= nil )
    
    -- what is the purpose of this?
    if ( target.Parent:findFirstChild("ForceField")) or (target.Parent:findFirstChild("ForceField")) or (target.Position.Y < script.Parent["Right Leg"].Position.Y) then     
    else 
        script.Parent.Humanoid:MoveTo(target.Position + Vector3.new(math.random(1,3),0,math.random(1,3)), target)
        wait(.15) 
        script.Parent.Humanoid:MoveTo(target.Position - Vector3.new(math.random(1,3),0,math.random(1,3)), target)
    end 
end

-- Run
local pos = script.Parent.Torso.Position
local FollowBot = script.Parent
local HumanoidsList = GetHumanoids()
HumanoidsList = CleanHumanoids(HumanoidsList)
local NearestHumanoid = FindNearestHumanoid( pos, HumanoidsList )
FollowTarget( NearestHumanoid, FollowBot )
