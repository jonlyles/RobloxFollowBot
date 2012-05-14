-- Now with exciting TeamColors HACK!

        function waitForChild(parent, childName)
        local child = parent:findFirstChild(childName)
        if child then return child end
        while true do
        child = parent.ChildAdded:wait()
        if child.Name==childName then return child end
        end
        end

        -- TEAM COLORS


        function onTeamChanged(player)

        wait(1)

        local char = player.Character
        if char == nil then return end

        if player.Neutral then
        -- Replacing the current BodyColor object will force a reset
        local old = char:findFirstChild("Body Colors")
        if not old then return end
        old:clone().Parent = char
        old.Parent = nil
        else
        local head = char:findFirstChild("Head")
        local torso = char:findFirstChild("Torso")
        local left_arm = char:findFirstChild("Left Arm")
        local right_arm = char:findFirstChild("Right Arm")
        local left_leg = char:findFirstChild("Left Leg")
        local right_leg = char:findFirstChild("Right Leg")

        if head then head.BrickColor = BrickColor.new(24) end
        if torso then torso.BrickColor = player.TeamColor end
        if left_arm then left_arm.BrickColor = BrickColor.new(26) end
        if right_arm then right_arm.BrickColor = BrickColor.new(26) end
        if left_leg then left_leg.BrickColor = BrickColor.new(26) end
        if right_leg then right_leg.BrickColor = BrickColor.new(26) end
        end
        end

        function onPlayerPropChanged(property, player)
        if property == "Character" then
        onTeamChanged(player)
        end
        if property== "TeamColor" or property == "Neutral" then
        onTeamChanged(player)
        end
        end


        local cPlayer = game.Players:GetPlayerFromCharacter(script.Parent)
        cPlayer.Changed:connect(function(property) onPlayerPropChanged(property, cPlayer) end )
        onTeamChanged(cPlayer)

      