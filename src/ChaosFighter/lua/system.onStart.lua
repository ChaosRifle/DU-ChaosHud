colour = '#64a5b9'
local temp = 'hahah'
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
    <svg style="filter: drop-shadow(1px 1px 1px black);position:absolute;left:2vw;top:22.15vh;width:19.5vw;height:25vh;" viewbox="0 0 200 200" preserveAspectRatio="none">
        <polyline style="opacity:1;fill:none;stroke:]] .. colour .. [[;stroke-width:2;stroke-miterlimit:0;" points="5,0 0,0 0,200 5,200" />
        <polyline style="opacity:1;fill:none;stroke:]] .. colour .. [[;stroke-width:2;stroke-miterlimit:0;" points="195,0 200,0 200,200 195,200" />
    </svg>
]]

staticThrottle = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
    <path d="m 765,49.06617 -10,2e-4 v 108.4998 h 2.5 -2.5 v 108.5 h 3"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="745.17616" y="43.56797" >MAX 51000 KPH</text>
    <path d="m 768.10496,245.19536 v 10.20758 l 10.20758,-5.10379 z"
    style='opacity:0;fill:#64a5b9;fill-opacity:1;stroke:none;'
    />
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 20; text-anchor:start;" x="782.88995" y="279.01715" >25.3G</text>

  </svg>
]]

dynamicThrottle = [[
  <svg style="position:absolute;" viewbox="0 0 2560 1440" preserveAspectRatio="none">
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
  <svg style="position:absolute;" viewbox="0 400 2560 1440" preserveAspectRatio="none">
    <path d="m 1006,1242 h -3 v -217 h 10"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
   <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1010.0212" y="1019.8666" >Shield</text>
    <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:end;" x="-1025.4011" y="1000.0139" transform="rotate(-90)" >MAX VENT CD: 342s</text>
  </svg>
]]
dynamicShield = [[
  <svg style="position:absolute;" viewbox="0 400 2560 1440" preserveAspectRatio="none">
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
  <svg style="position:absolute;" viewbox="50 400 2560 1440" preserveAspectRatio="none">
    <path d="m 1006,1242 h -3 v -217 h 10"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
   <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1010.0212" y="1019.8666" >CCS</text>
  </svg>
]]
dynamicCCS = [[
  <svg style="position:absolute;" viewbox="50 400 2560 1440" preserveAspectRatio="none">
    <path d="m 1010.7098,1243.3259 v -217"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:6;'
    />
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1013.0198" y="1255.3564" >80%</text>
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="-1242.896" y="998.469" transform="rotate(-90)" >29.2 M / 32.0 M</text>
  </svg>
]]


staticFuel = [[
  <svg style="position:absolute;" viewbox="-250 400 2560 1440" preserveAspectRatio="none">
    <path d="m 1006,1242 h -3 v -217 h 10"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
   <text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1010.0212" y="1019.8666" >FUEL</text>
  </svg>
]]
dynamicFuel = [[
  <svg style="position:absolute;" viewbox="-250 400 2560 1440" preserveAspectRatio="none">
    <path d="m 1010.7098,1243.3259 v -217"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:6;'
    />
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:middle;" x="1013.0198" y="1255.3564" >100%</text>
<text style="fill: ]]..colour..[[; font-family: Arial; font-size: 12; text-anchor:start;" x="-1242.896" y="998.469" transform="rotate(-90)" >29.2 M / 32.0 M</text>
  </svg>
]]



-- transform is -993.22343,-869.18211 so viewbox in the positive offsets to correct position
staticShieldResist = [[
  <svg style="position:absolute;" viewbox="993.223 869.182 2560 1440" preserveAspectRatio="none">
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
<svg style="position:absolute;" viewbox="993.223 869.182 2560 1440" preserveAspectRatio="none">

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
 <svg style="position:absolute;" viewbox="993.223 869.182 2560 1440" preserveAspectRatio="none">
    <path d="m 1529.0343,990.37962 h -100 v -50 h 2"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:2;'
    />
  </svg>
]]
dynamicShieldHistory = [[
 <svg style="position:absolute;" viewbox="993.223 869.182 2560 1440" preserveAspectRatio="none">
    <path d="m 1528.743,969.93136 -13.8923,-1.46761 -9.0345,-12.33143 -6.4533,-9.54325 -8.4758,2.67381 -8.3172,10.53767 -9.8677,-0.23861 -6.7605,-8.45595 -9.0634,-3.23858 -9.3995,0.33149 -10.6528,-10e-6 -7.878,-3.91154"
    style='opacity:1;fill:none;stroke:#64a5b9;stroke-width:1;'
    />
  </svg>
]]

periscope = ''
system.showScreen(true)
system.setScreen(table.concat({periscope, periscopeStaticBorder, staticCCS, dynamicCCS, staticShieldResist, dynamicShieldResist,
  staticShieldHistory, dynamicShieldHistory, dynamicShield, staticShield, staticFuel, dynamicFuel,dynamicThrottle, staticThrottle}))


spam=table.concat({periscope, periscopeStaticBorder, staticCCS, dynamicCCS, staticShieldResist, dynamicShieldResist,
  staticShieldHistory, dynamicShieldHistory, dynamicShield, staticShield, staticFuel, dynamicFuel,dynamicThrottle, staticThrottle})
spam = spam..spam
