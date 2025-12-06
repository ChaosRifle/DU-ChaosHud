pitchInputKb = 0
rollInputKb = 0
yawInputKb = 0
longitudinalInputKb = 0
horizontalInputKb = 0
verticalInputKb = 0
FCS = true --export: fcs is atmospheric ccompensation
ShieldAuto = true --export: automate shield resistances
pitchInputMouse = 0
rollInputMouse = 0
yawInputMouse = 0

translationalAcceleration = {}
angularAcceleration = {}

pitchInput = 0
rollInput = 0
yawInput = 0
brakeInput = 0






--shield vars
ShieldHp = shield.getShieldHitpoints()
ShieldHpMax = shield.getMaxShieldHitpoints()
ShieldVentCD = shield.getVentingCooldown()
ShieldVentCDMax = shield.getVentingMaxCooldown()
ShieldIsVenting = shield.isVenting()

ShieldStressRatioRaw = shield.getStressRatioRaw()
ShieldStressRatio = shield.getStressRatio()
ShieldResistCD = shield.getResistancesCooldown()
ShieldResistCDMax = shield.getResistancesMaxCooldown()
ShieldResistPool = shield.getResistancesPool()
ShieldResistPoolRemaining = shield.getResistancesRemaining()
ShieldResistances = shield.getResistances()
ShieldIsActive = shield.isActive()

--construct vars
PvPZone = construct.isInPvPZone()

--startup
if PvPZone == true then
    if ShieldIsActive == false then
        shield.activate()
    end
end

system.print('shield: ' .. shield.getShieldHitpoints() / shield.getMaxShieldHitpoints() * 100 )
--system.print('fuel: ' .. fuel1.getItemsVolume() / fuel1.getMaxVolume() * 100)
--system.print('ammo: ' .. ammo1.getItemsVolume() / ammo1.getMaxVolume() * 100 )
if radar_1.getOperationalState() == 1 then
    local radarContacts = radar_1.getConstructIds()
    for x = 1, #radarContacts, 1 do
        system.print(table.concat({
                    '[',
                    radarContacts[x],
                    '] ',
                    radar.getConstructName(radarContacts[x]),
                    ' - ',
                    radar.getConstructCoreSize(radarContacts[x]),
                    ': ',
                    radar.getConstructDistance(radarContacts[x]),
                    'm'
                }))
    end
else
    system.print('radar inop')
end




local periscopeX = 0
local periscopeY = 0
local ccsX = 0
local ccsY = 0
local shieldX = 0
local shieldY = 0
local shieldResistX = 0
local shieldResistY = 0
local throttleX = 0
local throttleY = 0
local fuelX = 0
local fuelY = 0
local brakeDeltaX = 0
local brakeDeltaY = 0
local avionicsX = 0
local avionicsY = 0

colour = '#64a5b9'
--colour = '#ff1400'

testpoint = 100


--baseRender =
--[[
    <svg style="filter: drop-shadow(1px 1px 1px black);position:absolute;left:2vw;top:22.15vh;width:19.5vw;height:25vh;" viewbox="0 0 200 200" preserveAspectRatio="none">
        <polyline style="opacity:1;fill:none;stroke:#9DBDC6;stroke-width:2;stroke-miterlimit:1;" points="5,0 0,0 0,200 5,200" />
        <polyline style="opacity:1;fill:none;stroke:#9DBDC6;stroke-width:2;stroke-miterlimit:1;" points="195,0 200,0 200,200 195,200" />
    </svg>

]]

periscope = [[
<style>
img {
position: fixed;
width: 40vw;
max-height: 100%;
box-sizing: border-box;
bottom: 25vh;
left: 32vw;
border-radius: 8px;
animation:blinking 0.1s 1;
}

                    @keyframes blinking{
                    0%{   width: 19.5vw;  }
                    100%{  width: 32vw;   }
                    }

</style>
<img src="gunner_target.liveview" style="box-sizing: border-box">
]]

baseRender =
[[
    <svg style="filter: drop-shadow(1px 1px 1px black);position:absolute;left:2vw;top:22.15vh;width:19.5vw;height:25vh;" viewbox="0 0 200 200" preserveAspectRatio="none">
        <polyline style="opacity:1;fill:none;stroke:]] .. colour .. [[;stroke-width:2;stroke-miterlimit:0;" points="5,0 0,0 0,200 5,200" />
        <polyline style="opacity:1;fill:none;stroke:]] .. colour .. [[;stroke-width:2;stroke-miterlimit:0;" points="195,0 200,0 200,200 195,200" />
    </svg>

]]



system.showScreen(true)
system.setScreen(periscope .. baseRender)
if weapon_1 then system.print('wep1') end
if weapon_4 then system.print('wep4') end


