local longitudinalCommandType = Nav.axisCommandManager:getAxisCommandType(axisCommandId.longitudinal)
if (longitudinalCommandType == axisCommandType.byTargetSpeed) then
    local targetSpeed = Nav.axisCommandManager:getTargetSpeed(axisCommandId.longitudinal)
    if (math.abs(targetSpeed) > constants.epsilon) then
        Nav.axisCommandManager:updateCommandFromActionLoop(axisCommandId.longitudinal, - utils.sign(targetSpeed))
    end
end

