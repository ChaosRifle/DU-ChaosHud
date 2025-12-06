framesRender = 0
framesUpdate = 0
unit.setTimer('render',1/60)
unit.setTimer('second',1)



-- category panel display helpers
_autoconf = {}
_autoconf.panels = {}
_autoconf.panels_size = 0
_autoconf.displayCategoryPanel = function(elements, size, title, type, widgetPerData)
    widgetPerData = widgetPerData or false -- default to one widget for all data
    if size > 0 then
        local panel = system.createWidgetPanel(title)
        local widget
        if not widgetPerData then
            widget = system.createWidget(panel, type)
        end
        for i = 1, size do
            if widgetPerData then
                widget = system.createWidget(panel, type)
            end
            system.addDataToWidget(elements[i].getWidgetDataId(), widget)
        end
        _autoconf.panels_size = _autoconf.panels_size + 1
        _autoconf.panels[_autoconf.panels_size] = panel
    end
end
_autoconf.hideCategoryPanels = function()
    for i=1,_autoconf.panels_size do
        system.destroyWidgetPanel(_autoconf.panels[i])
    end
end
-- Proxy array to access auto-plugged slots programmatically

atmofueltank = {}
atmofueltank_size = 0

spacefueltank = {}
spacefueltank_size = 0

rocketfueltank = {}
rocketfueltank_size = 0

weapon = {}
weapon_size = 0

radar = {}
radar_size = 0
-- End of auto-generated code
local exportvalue = 2 --export: test
pitchInputKb = 0
rollInputKb = 0
yawInputKb = 0
longitudinalInputKb = 0
horizontalInputKb = 0
verticalInputKb = 0
FCS = true
pitchInputMouse = 0
rollInputMouse = 0
yawInputMouse = 0

translationalAcceleration = {}
angularAcceleration = {}


Nav = Navigator.new(system, core, unit)
--Nav.axisCommandManager:setupCustomTargetSpeedRanges(axisCommandId.longitudinal, {1000, 5000, 10000, 20000, 30000})
--Nav.axisCommandManager:setTargetGroundAltitude(4)

-- Parenting widget
parentingPanelId = system.createWidgetPanel("Docking")
parentingWidgetId = system.createWidget(parentingPanelId,"parenting")
system.addDataToWidget(unit.getWidgetDataId(),parentingWidgetId)

-- Combat stress widget
coreCombatStressPanelId = system.createWidgetPanel("Core combat stress")
coreCombatStressgWidgetId = system.createWidget(coreCombatStressPanelId,"core_stress")
system.addDataToWidget(core.getWidgetDataId(),coreCombatStressgWidgetId)

-- element widgets
-- For now we have to alternate between PVP and non-PVP widgets to have them on the same side.
_autoconf.displayCategoryPanel(weapon, weapon_size, "Weapons", "weapon", true)
core.showWidget()
_autoconf.displayCategoryPanel(radar, radar_size, "Periscope", "periscope")
placeRadar = true
if atmofueltank_size > 0 then
    _autoconf.displayCategoryPanel(atmofueltank, atmofueltank_size, "Atmo Fuel", "fuel_container")
    if placeRadar then
        _autoconf.displayCategoryPanel(radar, radar_size, "Radar", "radar")
        placeRadar = false
    end
end
if spacefueltank_size > 0 then
    _autoconf.displayCategoryPanel(spacefueltank, spacefueltank_size, "Space Fuel", "fuel_container")
    if placeRadar then
        _autoconf.displayCategoryPanel(radar, radar_size, "Radar", "radar")
        placeRadar = false
    end
end
_autoconf.displayCategoryPanel(rocketfueltank, rocketfueltank_size, "Rocket Fuel", "fuel_container")
if placeRadar then -- We either have only rockets or no fuel tanks at all, uncommon for usual vessels
    _autoconf.displayCategoryPanel(radar, radar_size, "Radar", "radar")
    placeRadar = false
end
if antigrav ~= nil then antigrav.showWidget() end
if warpdrive ~= nil then warpdrive.showWidget() end
if gyro ~= nil then gyro.showWidget() end
if shield ~= nil then shield.showWidget() end

-- freeze the player in he is remote controlling the construct
if unit.isRemoteControlled() then
    player.freeze(1)
end

-- landing gear
-- make sure every gears are synchonized with the first
gearExtended = unit.isAnyLandingGearDeployed()
if gearExtended then
    unit.deployLandingGears()
else
    unit.retractLandingGears()
end

