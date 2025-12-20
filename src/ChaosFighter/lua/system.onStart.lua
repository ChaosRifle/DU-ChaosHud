ccat=table.concat

colour = '#64a5b9' --export
colourBoresight = '#808080' --export
colourTvi = '#56fca6' --export
colourAtvi = '#64a5b9' --export
colourIdentifyRange = '#cfff1e' --export
colourWeaponRange = '#00ab00' --export
colourBogey = '#ffff00' --export
colourBandit = '#ff0000' --export
colourFriendly = '#00ff00' --export
colourAmmo = '#ff0000' --export

local sHeight = system.getScreenHeight()
local sWidth = system.getScreenWidth()
local sWidthMod = sHeight / 9 * 16
local sWidthOffset = (sWidth - sWidthMod) / 2
local targetLockText = { 'TARGET LOCKED', 'NO TARGET' }
local weaponRange = 1401
local identRange = 1241
local weapons = {
    {'M', 0.45},
    {'M', 0.2},
    {'R', 1},
    {'C', 0.9},
    {'S', 0},
    {'L', 0.01}
}
local weaponCount = #weapons


function svgTxt(x,y,font,size,colour,anchor,text,rotate)
  if rotate then rotate ='" transform="rotate(-90)'else rotate =''end
  if anchor ==2 then anchor ='middle'elseif anchor ==3 then anchor ='end'else anchor = 'start'end
  return table.concat({'<text style="fill: ',colour,'; font-family: ',font,'; font-size: ',size,'; text-anchor:',anchor,';" x="',x,'" y="',y,rotate,'" >',text,'</text>'})
end

function svgPth(colour,path,width,opacity)
  if opacity == nil then opacity = 1 end
  return ccat({'<path d="m ', path,'" style="opacity:',opacity,';fill:none;stroke:',colour,';stroke-width:',width,';"/>'})
end
function svgPthFill(colour,path,opacity)
  if opacity == nil then opacity = 1 end
  return ccat({'<path d="m ',path,'" style="fill:',colour,';fill-opacity:',opacity,';stroke-opacity:0"/>'})
end
local DropShadow = false
function svg(content, left, top) --, vb3, vb4, vb1, vb2)
  --viewbox = {230,80,2560,1440}
  --contents = svgTxt()
  --if vb1 == nil then vb1 = 0 end
    --if vb2 == nil then vb2 = 0 end
    if left == nil then left=0 end
    if top == nil then top=0 end
    local shadow = ''
    if DropShadow == true then shadow = 'filter: drop-shadow(1px 1px 1px black);' end
  local data = {'<svg height='..sHeight ..' width='.. sWidthMod ..' style="'..shadow..'position:absolute;left:'..sWidthOffset + left..';top:'..top..'" viewbox="0 0 2560 1440" preserveAspectRatio="none">', '</svg>' }
  for i=1, #content, 1 do
    table.insert(data, 1+i, content[i])
  end
  return ccat(data)
end


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

periscopeStaticBorder =
[[
    <svg style="filter: drop-shadow(2px 2px 2px black);position:absolute;left:2vw;top:22.15vh;width:19.5vw;height:25vh;" viewbox="0 0 200 200" preserveAspectRatio="none">
        <polyline style="opacity:1;fill:none;stroke:]] .. colour .. [[;stroke-width:2;stroke-miterlimit:0;" points="5,0 0,0 0,200 5,200" />
        <polyline style="opacity:1;fill:none;stroke:]] .. colour .. [[;stroke-width:2;stroke-miterlimit:0;" points="195,0 200,0 200,200 195,200" />
    </svg>
]]

resolutionTest = [[<svg height="]]..sHeight ..[[" width="]]..sWidthMod..[[" style="position:absolute;left:]]..sWidthOffset..[[;top:0" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <path d="m 0,0 h 2560 v 1440 h -2560 z"
    style='opacity:1;fill:]]..colourBandit..[[;fill-opacity:]]..0 ..[[;stroke:]]..colour..[[;stroke-width:6;stroke-opacity:0'
    />
]] .. svgTxt(20,20,'Sans-Serif',40,colourBandit,1,'TEST! this is a test and must be seen')
  ..[[
  </svg>]]


scalingTest = [[<svg
  version="1.1"

  baseProfile="full"
  width="2560"
  height="1440"
  viewbox="0 0 2560 1440"
  style="position:absolute;left:-200;top:20.5"
  >
  <rect width="100%" height="100%" fill="black" />
  <circle cx="250" cy="275" r="90" fill="blue" transform="translate(50 0)" />
  <circle cx="250" cy="275" r="90" fill="red" />
  <circle cx="250" cy="275" r="90" fill="red" />
  <circle cx="250" cy="275" r="90" fill="red" />
  <circle cx="250" cy="275" r="90" fill="red" />

  <path d="m 1019,779 h 334" style="stroke:#00ff00;fill-opacity:0;stroke-opacity:1;stroke-width:1"/>
  <path d="m 1019,179 v1 h 334 v -1 z" style="fill:#00ff00;fill-opacity:1;stroke-opacity:0"/>
</svg>]]



------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- gunnery seat ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
local HitProbP = 0.65
local WeaponOptimalAngVel = .24
staticTarget = svg({
        svgPth(colour,'1113,312.5 h 334',1), --hit prob border
        svgPth(colour,'1113,323.5 h 334',1), --hit prob border
        svgTxt(1113,310,'Arial',14,colour,1,'HIT PROBABILITY'),
        svgPthFill('#188347','1113.5,252.5 0,17 124,0 '.. -124*(1-WeaponOptimalAngVel)..',-17 z',.5), --angVel bg
        svgPth('#34d484',1113+124*WeaponOptimalAngVel .. ',251.5 v 18',1), --angVel optimal line FIXME this needs to be rounded to the nearest x.5
        svgPth(colour,'1113.5,250.5 v 19 h 124 v -19',1), --angVel border
        svgTxt(1113,245,'Arial',14,colour,1,'ANGULAR VELOCITY'),
        svgTxt(1270,245,'Arial',14,colour,1,'RANGE'),
        svgTxt(1380,245,'Arial',14,colour,1,'MAX SPEED'),
    })
local angVelP = 0 --needs clamping as "100%" is just the limit of the gun, not the ship capability
local AngVelN = 0.07 --deg/s
local targetData = {['u'] = 'WMD', ['s'] = 'XS', ['n'] = 'TARGET SHIP NAME GOES HERE' }
local targetLocked = 1 --bool 1 or 2
    dynamicTarget = svg({
            svgPthFill(colour,'1113,314 v 8 h ' .. 334 * HitProbP ..' v -8 z'), --hit prob
            svgTxt(1447,322,'Arial',14,colour,1,HitProbP*100 ..'%'),
            svgPthFill(colour,1114-5+124*angVelP ..',270 5,-13.5 5,13.5 z'), --angVel needle
            svgTxt(1113,283,'Arial',16,colour,1,AngVelN .. '° per sec'),
            svgTxt(1270,265,'Arial',20,colour,1,'119 M'),
            svgTxt(1380,265,'Arial',20,colour,1,'51468 KPH'),
            svgTxt(1113,220,'Arial',20,colourBandit,1,targetData.u),
            svgTxt(1185,220,'Arial',20,colour,2,targetData.s),
            svgTxt(1203,220,'Arial',20,colour,1,targetData.n),
            svgTxt(1113,200,'Arial',14,colour,1,targetLockText[targetLocked]),
        })


staticWeapon = {
        svgTxt(1585,142,'Arial',8,colour,2,'WEAPON STATUS'),
        svgPth(colour,'1535,145.5 h 100',1),
    }
for i=1, weaponCount do
    table.insert(staticWeapon, svgTxt(1525,142 + 15 * i,'Arial',12,colour,2,weapons[i][1]))
    table.insert(staticWeapon, svgPth(colour,'1535,' .. 145.5 +15*i.. ' h 100',1))
end
dynamicWeapon = {}
for i=1, weaponCount do
    table.insert(dynamicWeapon, svgPthFill(colourAmmo,'1535,' .. 142 + 15 * i .. ' v-8 h ' .. 100 * weapons[i][2] ..' v 8 z'))
end
staticWeapon = svg(staticWeapon)
dynamicWeapon = svg(dynamicWeapon)

staticWeaponStats = svg({
        svgTxt(1800,150,'Arial',12,colour,1,'SHOTS FIRED'),
        svgTxt(1800,165,'Arial',12,colour,1,'SHOTS HIT'),
        svgTxt(1800,180,'Arial',12,colour,1,'ACCURACCY'),
        svgTxt(1800,195,'Arial',12,colour,1,'PEAK DPS'),
        svgTxt(1800,210,'Arial',12,colour,1,'DAMAGE TOTAL'),
})
dynamicWeaponStats = svg({
        svgTxt(1910,150,'Arial',12,colour,1,'1380'),
        svgTxt(1910,165,'Arial',12,colour,1,'1275'),
        svgTxt(1910,180,'Arial',12,colour,1,'95%'),
        svgTxt(1910,195,'Arial',12,colour,1,'102 K'),
        svgTxt(1910,210,'Arial',12,colour,1,'440295 K')
})

staticDpsMeter = svg({
        svgPth(colour,'1599.5,299.5 h -100 v -50 l 2,0',1),
    })
dynamicDpsMeter = svg({
  svgPth(colour,'1500.7484,298.79558 7.577,-11.85958 10.2124,-7.24752 7.9064,8.23582 10.5418,-12.84788 8.2359,-7.24753 8.2358,-10.54185 9.5535,-0.98829 9.2242,-0.32944 9.883,0.32944 11.2007,-10e-6 8.8946,-2.63545',1),
  svgTxt(1602,299,'Arial',8,colour,1,'102 K DPS'),
})

------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- gunner and pilot seat -----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
staticRangingTableVertical = [[
  <svg style="position:absolute;" viewbox="255 676 2560 1440" preserveAspectRatio="none">
    <path d="m 1040, ]] ..identRange..[[ h -14"
    style='opacity:1;fill:none;stroke:]]..colourIdentifyRange..[[;stroke-width:2;'
    />
    <text style="fill: ]]..colourIdentifyRange..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="1042" y="]] .. identRange + 4 .. [[" >IDENT</text>
    <path d="m 1040,]]..weaponRange..[[ h -14"
    style='opacity:1;fill:none;stroke:]]..colourWeaponRange..[[;stroke-width:2;'
    />
    <text style="fill: ]]..colourWeaponRange..[[; font-family: sans-serif; font-size: 12; text-anchor:start;" x="1044" y="]]..weaponRange + 4 ..[[" >MAX</text>
    <path d="M 1032,1550 V ]]..weaponRange..[["
    style='opacity:0.3;fill:none;stroke:]]..colourWeaponRange..[[;stroke-width:12;'
    />
  <text style="fill: ]]..colour..[[; font-family: sans-serif; font-size: 12; text-anchor:start;" x="1042.5" y="1555" >0.0 SU</text>
  <circle cx="1012" cy="1550" r="8"
    style='opacity:1;fill:none;stroke:]]..colourFriendly..[[;stroke-width:1;'
  />
  <text style="fill: ]]..colour..[[; font-family: sans-serif; font-size: 12; text-anchor:end;" x="999" y="1554" >SELF</text>

  <text style="fill: ]]..colour..[[; font-family: sans-serif; font-size: 12; text-anchor:start;" x="1046" y="805" >5.0 SU</text>

    <path d="m 1040.5,800.5 h -15 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 9.5 -9.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 15 -15 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 9.5 -9.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 4.5 -4.5 v 37.5 h 15"
    style='opacity:1;fill:none;stroke:]]..colour..[[;stroke-width:1;'
    />
  </svg>
]]
dynamicRangingTableVertical = [[
  <svg style="position:absolute;" viewbox="255 676 2560 1440" preserveAspectRatio="none">
    <rect width="16" height="16" x="837.5" y="1273.5"
    style='opacity:1;fill:none;stroke:]]..colourBogey..[[;stroke-width:1;'
    />
    <circle cx="930" cy="1280" r="8"
    style='opacity:1;fill:none;stroke:]]..colourFriendly..[[;stroke-width:1;'
    />
  <path d="m 945,1272 8,8 -8,8 -8,-8 8,-8"
    style='opacity:1;fill:none;stroke:]]..colourBandit..[[;stroke-width:1;'
    />

<path d="m 930,1273.5 1.45775,4.5201 4.7493,-0.01 -3.84837,2.7832 1.47749,4.5136 -3.83617,-2.8 -3.83616,2.8 1.47749,-4.5136 -3.84838,-2.7832 4.74931,0.01 z"
       style="fill:]]..colourBogey..[[;fill-opacity:1;stroke:none;stroke-width:1;stroke-opacity:1"
       />
  </svg>
]]


staticRangingTableHorizontal = [[
  <svg style="position:absolute;" viewbox="0 200 2560 1440" preserveAspectRatio="none">
    <path d="m 1239.2006,1255 4e-4,14"
    style='opacity:1;fill:none;stroke:]]..colourIdentifyRange..[[;stroke-width:2;'
    />
    <text style="fill: ]]..colourIdentifyRange..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="-1252.2352" y="1243.6326" transform="rotate(-90)" >IDENT</text>
    <path d="m 890.586,1255 v 14"
    style='opacity:1;fill:none;stroke:]]..colourWeaponRange..[[;stroke-width:2;'
    />
    <text style="fill: ]]..colourWeaponRange..[[; font-family: sans-serif; font-size: 12; text-anchor:start;" x="-1251.0969" y="894.69" transform="rotate(-90)" >MAX</text>
    <path d="M 750,1263 H 890.61179"
    style='opacity:0.3;fill:none;stroke:]]..colourWeaponRange..[[;stroke-width:12;'
    />
  <text style="fill: ]]..colour..[[; font-family: sans-serif; font-size: 12; text-anchor:start;" x="-1251.7878" y="1504.1157" transform="rotate(-90)" >5.0 SU</text>
  <text style="fill: ]]..colour..[[; font-family: sans-serif; font-size: 12; text-anchor:start;" x="-1248.2944" y="754.16522" transform="rotate(-90)" >0.0 SU</text>

    <path d="m 750,1255 v 15 h 37.5 v -4.5 4.5 H 825 v -4.5 4.5 h 37.5 v -4.5 4.5 H 900 v -4.5 4.5 h 37.5 v -9.5 9.5 H 975 v -4.5 4.5 h 37 v -4.5 4.5 h 38 v -4.5 4.5 h 37.5 v -4.5 4.5 h 37.5 v -15 15 h 37.5 v -4.5 4.5 h 37.5 v -4.5 4.5 h 37.5 v -4.5 4.5 h 37.5 v -4.5 4.5 h 37.5 v -9.5 9.5 h 37.5 v -4.5 4.5 h 37.5 v -4.5 4.5 h 37.5 v -4.5 4.5 h 37.5 v -4.5 4.5 h 37.5 v -15"
    style='opacity:1;fill:none;stroke:]]..colour..[[;stroke-width:1;'
    />
  </svg>
]]
dynamicRangingTableHorizontal = [[
  <svg style="position:absolute;" viewbox="0 200 2560 1440" preserveAspectRatio="none">

  </svg>
]]

warningFriendly = svg({
        svgTxt(1280,350,'Arial',24,colour,2,'FRIENDLY TARGET'), --FIXME alternate colour every second
    })

staticContacts = svg({
        svgTxt(2000,800,'Arial',28,colour,1,'CONTACTS'),
    })
dynamicContacts = svg({
        svgTxt(2000,800,'Arial',28,colour,1,'1258'), --contact count
        svgTxt(2100,850,'Arial',28,colourFriendly,3,'FRIENDS 3  '),
        svgTxt(2100,850,'Arial',28,colourFriendly,3,'/'),
        svgTxt(2100,850,'Arial',28,colourBandit,1,'  25 BOGEYS'),


        svgTxt(2000,800,'Arial',28,colour,1,'UID'),
        svgTxt(2000,800,'Arial',28,colour,1,'XL'),
        svgTxt(2000,800,'Arial',28,colour,1,'SHIP NAME HERE IS LONG OH NO'),
        svgTxt(2000,800,'Arial',28,colour,1,'108 SU'),
        svgTxt(2000,800,'Arial',28,colour,1,'10498 KPH'),

    })

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------ pilot seat ------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
dynamicTvi =  [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <path d="m 1161,481 v 21"
    style='opacity:1;fill:none;stroke:]]..colourTvi..[[;stroke-width:2;'
    />
    <path d="m 1170,511 h 21"
    style='opacity:1;fill:none;stroke:]]..colourTvi..[[;stroke-width:2;'
    />
    <path d="m 1161,520 v 21"
    style='opacity:0;fill:none;stroke:]]..colourTvi..[[;stroke-width:2;'
    />
    <path d="m 1131,511 h 21"
    style='opacity:1;fill:none;stroke:]]..colourTvi..[[;stroke-width:2;'
    />

    <circle cx="1161" cy="511" r="9"
    style='opacity:1;fill:none;stroke:]]..colourTvi..[[;stroke-width:2;'
    />
  </svg>
]]
dynamicAtvi =  [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <path d="m 1325,525 50,50"
    style='opacity:1;fill:none;stroke:]]..colourAtvi..[[;stroke-width:6;'
    />
    <path d="m 1375,525 -50,50"
    style='opacity:1;fill:none;stroke:]]..colourAtvi..[[;stroke-width:6;'
    />
  </svg>
]]
dynamicBoresight =   [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <path d="M 1250,537.5 V 525"
    style='opacity:0.5;fill:none;stroke:]]..colourBoresight..[[;stroke-width:1;'
    />
    <path d="M 1262.5,550 H 1275"
    style='opacity:0.5;fill:none;stroke:]]..colourBoresight..[[;stroke-width:1;'
    />
    <path d="M 1250,575 V 562.5"
    style='opacity:0.5;fill:none;stroke:]]..colourBoresight..[[;stroke-width:1;'
    />
    <path d="M 1237.5,550 H 1225"
    style='opacity:0.5;fill:none;stroke:]]..colourBoresight..[[;stroke-width:1;'
    />
  </svg>
]]

staticBrakesAndDeltaV = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1480" y="650" >BRK TME</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1485" y="670" >MIN</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1480" y="690" >BRK DST</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1485" y="710" >M</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1480" y="730" >BRK ΔV</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1485" y="750" >KPH</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1480" y="770" >BRN TIME</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1485" y="790" >MIN</text>
  </svg>
]]
dynamicBrakesAndDeltaV = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1480" y="670" >63:30</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1480" y="710" >28230</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1480" y="750" >7089754</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1480" y="790" >6:28</text>
  </svg>
]]


staticAvionics = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1680" y="650" >PVP EDGE</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1685" y="670" >SU</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1680" y="690" >PIPE DST</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1685" y="710" >SU</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1680" y="730" >ATMO DST</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1685" y="750" >SU</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="1680" y="770" >B-ALT</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:start;" x="1685" y="790" >M</text>
  </svg>
]]
dynamicAvionics = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1680" y="670" >63.1</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1680" y="710" >28</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1680" y="750" >61.2</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 22; text-anchor:end;" x="1680" y="790" >128582</text>
  </svg>
]]


warningBrakes = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 24; text-anchor:middle;" x="1280" y="350" >BRAKES ENGAGED</text>
  </svg>
]]

warningFuel = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 24; text-anchor:middle;" x="1280" y="370" >FUEL LOW - 20000 KPH ΔV</text>
  </svg>
]]

staticWarp = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="2000" y="350" >DESTINATION:</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="2000" y="365" >DISTANCE:</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="2000" y="380" >WARP CELLS:</text>
  </svg>
]]
dynamicWarp = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="2100" y="350" >CHAOS THEORY STATION</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="2100" y="365" >310.69 M</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="2100" y="380" >1160 / 110</text>
  </svg>
]]


staticThrottle = [[
  <svg style="position:absolute;" viewbox="-640 -775 2560 1440" preserveAspectRatio="none">
    <path d="m 765,49.06617 -10,2e-4 v 108.4998 h 2.5 -2.5 v 108.5 h 3"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="745.17616" y="43.56797" >MAX 51000 KPH</text>
    <path d="m 768.10496,245.19536 v 10.20758 l 10.20758,-5.10379 z"
    style='opacity:1;fill:#64a5b9;fill-opacity:1;stroke:none;'
    />
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 20; text-anchor:start;" x="782.88995" y="279.01715" >25.3G</text>

  </svg>
]]
dynamicThrottle = [[
  <svg style="position:absolute;" viewbox="-640 -775 2560 1440" preserveAspectRatio="none">
    <path d="m 762,267.06617 v -91"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:6;'
    />
    <path d="M 750,267.06614 V 112.12906"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:6;'
    />
    <path d="M 745,267.06614 V 87.066141 h 7.5"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="755.38361" y="278.5592" >20%</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 10; text-anchor:start;" x="767.62813" y="55.3797" >TME EST 6:23</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 28; text-anchor:start;" x="781.94476" y="259.8413" >11058 KPH</text>


  </svg>
]]

--staticCCS = [[
--  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
--    <polyline style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;' points='1006.7098,242.3259 1003.7098,242.3259 1006.7098,25.3259 1016.7098,25.3259' />
--  </svg>
--]]

staticShield = [[
  <svg style="position:absolute;" viewbox="-130 200 2560 1440" preserveAspectRatio="none">
    <path d="m 1006,1242 h -3 v -217 h 10"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
   <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1010.0212" y="1019.8666" >Shield</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="-1025.4011" y="1000.0139" transform="rotate(-90)" >MAX VENT CD: 342s</text>
  </svg>
]]
dynamicShield = [[
  <svg style="position:absolute;" viewbox="-130 200 2560 1440" preserveAspectRatio="none">
    <path d="m 1010.7098,1243.3259 v -217"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:6;'
    />
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1013.0198" y="1255.3564" >80%</text>
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="-1242.896" y="998.469" transform="rotate(-90)" >29.2 M / 32.0 M</text>
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 14; text-anchor:start;" x="-1243.191" y="1024.6381" transform="rotate(-90)" >VENTING - 342 s</text>
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 10;text-anchor:start;" x="1016.3262" y="1032.3166" >NXT VENT: 614s</text>
  </svg>
]]


staticCCS = [[
  <svg style="position:absolute;" viewbox="-80 200 2560 1440" preserveAspectRatio="none">
    <path d="m 1006,1242 h -3 v -217 h 10"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
   <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1010.0212" y="1019.8666" >CCS</text>
  </svg>
]]
dynamicCCS = [[
  <svg style="position:absolute;" viewbox="-80 200 2560 1440" preserveAspectRatio="none">
    <path d="m 1010.7098,1243.3259 v -217"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:6;'
    />
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1013.0198" y="1255.3564" >80%</text>
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="-1242.896" y="998.469" transform="rotate(-90)" >29.2 M / 32.0 M</text>
  </svg>
]]


staticFuel = [[
  <svg style="position:absolute;" viewbox="-350 200 2560 1440" preserveAspectRatio="none">
    <path d="m 1006,1242 h -3 v -217 h 10"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
   <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1010.0212" y="1019.8666" >FUEL</text>
  </svg>
]]
dynamicFuel = [[
  <svg style="position:absolute;" viewbox="-350 200 2560 1440" preserveAspectRatio="none">
    <path d="m 1010.7098,1243.3259 v -217"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:6;'
    />
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1013.0198" y="1255.3564" >100%</text>
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="-1242.896" y="998.469" transform="rotate(-90)" >29.2 M / 32.0 M</text>
  </svg>
]]



-- transform is -993.22343,-869.18211 so viewbox in the positive offsets to correct position
staticShieldResist = [[
  <svg style="position:absolute;" viewbox="93.223 339.182 2560 1440" preserveAspectRatio="none">
    <path d="m ]] .. 1300.1373 .. [[,]] .. 1302.42 .. [[ v -1.3523 l 6.1822,-4.057 v -1.932 h -4.1536 l -2.1251,-2.5115 v -3.8639 l 2.1251,-2.7047 h 7.9209 l 5.7958,1.3524 h 20.5751 v 2.3183 h -17.7738 l -0.7728,0.7728 v 0.966 l 0.7728,0.7727 h 17.7738 v 2.3184 h -11.3018 v 0.9659 h -4.2503 l -2.8979,0.7728 v 2.8013 l 3.1877,2.0285 v 1.3523 z"
    style='fill:#64a5b9;fill-opacity:0.2;stroke:#64a5b9;stroke-width:0.5;stroke-opacity:1'
    />
    <path d="m 1345.3374,1352.3781 v -1.3523 l 6.1822,-4.057 v -1.932 h -4.1537 l -2.0285,-2.5559 v -3.8125 l 2.0285,-2.7117 h 7.921 l 5.9889,2.7047 h 10.6257 l 2.5115,1.5456 h 16.7112 v 2.3183 h -16.7112 v 0.7728 h -8.1141 l -6.0856,1.7387 v 1.932 l 6.1822,4.057 v 1.3523 z"
    style='fill:#64a5b9;fill-opacity:0.2;stroke:#64a5b9;stroke-width:0.5;stroke-opacity:1'
    />
    <path d="m 1295.2928,1352.298 v -1.3523 l 6.1821,-4.057 v -1.932 h -4.1536 l -2.0285,-2.6081 v -3.7673 l 2.0285,-2.7047 h 7.9209 l 5.989,2.7047 h 5.023 v 1.5456 h 12.8935 l 0.5014,-1.2552 -4.6046,-4.5406 0.5796,-0.5796 4.5766,4.5544 1.2192,-0.5058 v -6.5601 h 0.7728 v 6.5424 l 1.2637,0.5234 4.532,-4.5543 0.5796,0.5796 -4.5511,4.5426 0.5206,1.2532 h 6.542 v 0.7728 h -6.5657 l -0.5041,1.2185 4.5583,4.5773 -0.5796,0.5795 -4.5607,-4.5957 -1.235,0.5122 v 6.4018 h -0.7729 l 1e-4,-6.423 -1.1854,-0.4912 -4.6104,4.5959 -0.5796,-0.5795 4.6091,-4.5834 -0.5058,-1.2124 h -12.8936 v 2.3183 l -6.0855,1.7387 v 1.932 l 6.1821,4.057 v 1.3523 z"
    style='fill:#64a5b9;fill-opacity:0.2;stroke:#64a5b9;stroke-width:0.5;stroke-opacity:1'
    />
    <path d="m 1384.699,1296.7202 h -28.1096 l -10.529,2.5115 c 1.7842,-3.6067 1.3472,-6.8922 0,-10.046 l 10.6256,2.5115 h 28.013 c 0,0 5.8292,0.4097 5.8248,2.526 0,2.1124 -5.8248,2.497 -5.8248,2.497 z"
    style='fill:#64a5b9;fill-opacity:0.2;stroke:#64a5b9;stroke-width:0.5;stroke-opacity:1'
    />

    <path d="m 1343.2234,1269.1821 v 100"
    style='opacity:1;fill:none;fill-opacity:1;stroke:#64a5b9;stroke-width:1;stroke-dasharray:1, 4;stroke-dashoffset:5.5;stroke-opacity:1;'
    />
    <path  d="m 1393.2234,1319.1821 h -100"
    style='opacity:1;fill:none;fill-opacity:1;stroke:#64a5b9;stroke-width:1;stroke-dasharray:1, 4;stroke-dashoffset:5.5;stroke-opacity:1;'
    />

    <path  d="m 1293.2234,1269.1821 h 100 v 100 h -100 z"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:1;'
    />

</svg>
]]
dynamicShieldResist = [[
<svg style="position:absolute;" viewbox="93.223 339.182 2560 1440" preserveAspectRatio="none">

<path d="m 1309.9444,1318.7169 33.8322,-11.1347 14.3465,11.5629 -14.1324,11.1346 z"
    style='fill:#ff0e00;fill-opacity:0.488559;stroke-opacity:0'
  />
<path d="m 1333.1415,1319.3783 10.1753,-30.2348 2.7237,30.0978 -2.5267,9.9611 z"
    style='fill:#64a5b9;fill-opacity:0.488559;stroke-opacity:0'
  />
 <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1345.5724" y="1268.0247" >AM - 82%</text>
 <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1345.5724" y="1379.0377" >TH - 00%</text>
 <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="-1317.7576" y="1402.7263" transform="rotate(-90)" >KN - 02%</text>
 <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="-1317.8109" y="1292.1652" transform="rotate(-90)">EM - 04%</text>

<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1346.5496" y="1397.5146" >NXT Resist: 351s</text>
  </svg>
]]

staticShieldHistory = [[
 <svg style="position:absolute;" viewbox="230 80 2560 1440" preserveAspectRatio="none">
    <path d="m 1529.0343,990.37962 h -100 v -50 h 2"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
   <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 8; text-anchor:middle;" x="1479.0343" y="987.37962" >SHIELD HISTORY</text>
  </svg>
]]
dynamicShieldHistory = [[
 <svg style="position:absolute;" viewbox="230 80 2560 1440" preserveAspectRatio="none">
    <path d="m 1528.743,969.93136 -13.8923,-1.46761 -9.0345,-12.33143 -6.4533,-9.54325 -8.4758,2.67381 -8.3172,10.53767 -9.8677,-0.23861 -6.7605,-8.45595 -9.0634,-3.23858 -9.3995,0.33149 -10.6528,-10e-6 -7.878,-3.91154"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:1;'
    />
  </svg>
]]

------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- end ---------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

periscope = ''
system.showScreen(true)
system.setScreen(table.concat({'<html> <body> ', periscope, periscopeStaticBorder, staticCCS, dynamicCCS, staticShieldResist, dynamicShieldResist,
  staticShieldHistory, dynamicShieldHistory, dynamicShield, staticShield, staticFuel, dynamicFuel,dynamicThrottle, staticThrottle,
  staticWarp, dynamicWarp, warningFriendly, warningBrakes, warningFuel, staticBrakesAndDeltaV, dynamicBrakesAndDeltaV,
  staticAvionics, dynamicAvionics, dynamicTvi, dynamicAtvi, dynamicBoresight,
  dynamicRangingTableVertical, staticRangingTableVertical, staticTarget, dynamicTarget, staticWeapon, dynamicWeapon,
  staticDpsMeter, dynamicDpsMeter, staticContacts, dynamicContacts, staticWeaponStats, dynamicWeaponStats, ' </body> </html>'}))

--staticRangingTableHorizontal, dynamicRangingTableHorizontal
--system.setScreen(scalingTest)

spam=table.concat({'<html> <body> ', periscope, periscopeStaticBorder, staticCCS, dynamicCCS, staticShieldResist, dynamicShieldResist,
  staticShieldHistory, dynamicShieldHistory, dynamicShield, staticShield, staticFuel, dynamicFuel,dynamicThrottle, staticThrottle,
  staticWarp, dynamicWarp, warningFriendly, warningBrakes, warningFuel, staticBrakesAndDeltaV, dynamicBrakesAndDeltaV,
  staticAvionics, dynamicAvionics, dynamicTvi, dynamicAtvi, dynamicBoresight,
  dynamicRangingTableVertical, staticRangingTableVertical, staticTarget, dynamicTarget, staticWeapon, dynamicWeapon,
  staticDpsMeter, dynamicDpsMeter, staticContacts, dynamicContacts, resolutionTest, ' </body> </html>'})


spam = spam --..spam

--system.print(svg({svgTxt(0,100,'Arial',40,colour,1,'CHAOS-HUD'),}, 300, 300))
