brakeInput = brakeInput + 1
local longitudinalCommandType = Nav.axisCommandManager:getAxisCommandType(axisCommandId.longitudinal)
if (longitudinalCommandType == axisCommandType.byTargetSpeed) then
    local targetSpeed = Nav.axisCommandManager:getTargetSpeed(axisCommandId.longitudinal)
    if (math.abs(targetSpeed) > constants.epsilon) then
        Nav.axisCommandManager:updateCommandFromActionStart(axisCommandId.longitudinal, - utils.sign(targetSpeed))
    end
end

