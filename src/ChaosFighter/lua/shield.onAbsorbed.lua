--hitpoints --after resist, absolute
--rawHitpoints --before resist

ShieldHp = ShieldHp - hitpoints
--ShieldHp = shield.getShieldHitpoints()
--ShieldHpMax = shield.getMaxShieldHitpoints()
ShieldVentCD = shield.getVentingCooldown()
--ShieldVentCDMax = shield.getVentingMaxCooldown()
--ShieldIsVenting = shield.isVenting()

ShieldStressRatioRaw = shield.getStressRatioRaw()
ShieldStressRatio = shield.getStressRatio()
ShieldResistCD = shield.getResistancesCooldown()
--ShieldResistCDMax = shield.getResistancesMaxCooldown()
--ShieldResistPool = shield.getResistancesPool()
--ShieldResistPoolRemaining = shield.getResistancesRemaining()
--ShieldResistances = shield.getResistances()
--ShieldIsActive = shield.isActive()






if ShieldAuto == true and ShieldResistCD == 0 then
    shield.setResistances(antimatter,electromagnetic,kinetic,thermic) --FIXME

    end



