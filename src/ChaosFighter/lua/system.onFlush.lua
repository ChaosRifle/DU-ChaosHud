-- final inputs
finalRollInput = utils.clamp(rollInputKb + system.getControlDeviceYawInput() + system.getAxisValue(0), -1, 1)
finalPitchInput = utils.clamp(pitchInputKb + system.getControlDeviceForwardInput() + system.getAxisValue(1), -1, 1)
finalYawInput = utils.clamp(yawInputKb - system.getControlDeviceLeftRightInput() - system.getAxisValue(2), -1, 1)

finalLongitudinalStrafe = utils.clamp(longitudinalInputKb + system.getAxisValue(3) + system.getThrottleInputFromMouseWheel(), -1, 1)
finalHorizontalStrafe = utils.clamp(horizontalInputKb + system.getAxisValue(4), -1, 1)
finalVerticalStrafe = utils.clamp(verticalInputKb + system.getAxisValue(5), -1, 1)

local finalBrakeInput = brakeInput

local pitchSpeedFactor = 1
local rollSpeedFactor = 1
local yawSpeedFactor = 1
local brakeSpeedFactor = 1
local torqueFactor = 1
local brakeFlatFactor = 1

-- Axis
local worldVertical = vec3(core.getWorldVertical()) -- along gravity
local constructUp = vec3(construct.getWorldOrientationUp())
local constructForward = vec3(construct.getWorldOrientationForward())
local constructRight = vec3(construct.getWorldOrientationRight())
local constructVelocity = vec3(construct.getWorldVelocity())
local constructVelocityDir = vec3(construct.getWorldVelocity()):normalize()
local currentRollDeg = getRoll(worldVertical, constructForward, constructRight)
local currentRollDegAbs = math.abs(currentRollDeg)
local currentRollDegSign = utils.sign(currentRollDeg)

-- Engine commands
local keepCollinearity = 1 -- for easier reading
local dontKeepCollinearity = 0 -- for easier reading
local tolerancePercentToSkipOtherPriorities = 1 -- if we are within this tolerance (in%), we don't go to the next priorities

-- Rotation - HOW THE FUCK IS THIS VALID????
local constructAngularVelocity = vec3(construct.getWorldAngularVelocity())
targetAngularVelocity = finalPitchInput * pitchSpeedFactor * constructRight
+ finalRollInput * rollSpeedFactor * constructForward
+ finalYawInput * yawSpeedFactor * constructUp

angularAcceleration = torqueFactor * (targetAngularVelocity - constructAngularVelocity)
local airAcceleration = vec3(construct.getWorldAirFrictionAngularAcceleration())
if FCS == true then -- Try to compensate air friction
    angularAcceleration = angularAcceleration - airAcceleration
    end
    --Nav:setEngineTorqueCommand('torque', angularAcceleration, keepCollinearity, 'airfoil', '', '', tolerancePercentToSkipOtherPriorities)

    -- Translation - WHY DONT YOU WORK LIKE ROTATION
    local strafeTags = 'thrust analog longitudinal lateral vertical ground all'
    translationalAcceleration = vec3(finalLongitudinalStrafe, finalHorizontalStrafe, finalVerticalStrafe)
    --Nav:setEngineForceCommand( strafeTags, translationalAcceleration, keepCollinearity, 'ground', 'thrust', '', tolerancePercentToSkipOtherPriorities)

    --Nav.axisCommandManager:updateCommandFromActionStart(axisCommandId.vertical, 1.0)
    --Nav.axisCommandManager:setCommandByThrottle(axisCommandId.vertical, finalVerticalStrafe)
    vertAcceleration = Nav.axisCommandManager:composeAxisAccelerationFromThrottle(longitudinalEngineTags,axisCommandId.longitudinal)
    --Nav:setEngineForceCommand('all', vertAcceleration, keepCollinearity)


    Nav:setEngineCommand('all, thrust', translationalAcceleration, angularAcceleration, keepCollinearity, keepCollinearity, '', '', '', tolerancePercentToSkipOtherPriorities)



    -- Brakes
    --local brakeAcceleration = -finalBrakeInput * (brakeSpeedFactor * constructVelocity + brakeFlatFactor * constructVelocityDir)
    --Nav:setEngineForceCommand('brake', brakeAcceleration)
