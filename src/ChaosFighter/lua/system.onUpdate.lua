Nav:update()
framesUpdate = framesUpdate + 1
--system.print('finalRollInput: ' .. tostring(finalRollInput))
--system.print('finalPitchInput: ' .. tostring(finalPitchInput))
--system.print('finalYawInput: ' .. tostring(finalYawInput))
--system.print('finalLongitudinalStrafe: ' .. tostring(finalLongitudinalStrafe))
--system.print('finalHorizontalStrafe: ' .. tostring(finalHorizontalStrafe))
--system.print('finalVerticalStrafe: ' .. tostring(finalVerticalStrafe))

--system.print('targetAngularVelocity: ' .. tostring(targetAngularVelocity))
--system.print('angularAcceleration: ' .. tostring(angularAcceleration))

--system.print('translationalAcceleration: ' .. tostring(translationalAcceleration))
--system.print(Nav.axisCommandManager:getAxisCommandType(axisCommandId.longitudinal))
--system.print(Nav.axisCommandManager:getAxisCommandType(axisCommandId.lateral))
--system.print(Nav.axisCommandManager:getAxisCommandType(axisCommandId.vertical))
--Nav.axisCommandManager:setAxisCommandType(axisCommandId.longitudinal)
--Nav.axisCommandManager:setAxisCommandType(axisCommandId.lateral)
--Nav.axisCommandManager:setAxisCommandType(axisCommandId.vertical)


testpoint = testpoint+1
if testpoint > 400 then testpoint = 100 end
if testpoint < 200 then
    colour = '#64a5b9'
elseif testpoint < 300 then
    colour = '#640000'
else
    colour = '#00ff00'
end

testrender = baseRender ..
[[
    <svg style="filter: drop-shadow(1px 1px 1px black);position:absolute;left:22vw;top:22.15vh;width:29.5vw;height:75vh;" viewbox="0 0 400 400" preserveAspectRatio="none">
        <polyline style="opacity:1;fill:none;stroke:]] .. colour .. [[;stroke-width:15;stroke-miterlimit:0;" points="10,0 ]].. testpoint ..[[,0" />
    </svg>

]]



system.showScreen(true)
system.setScreen(testrender)
