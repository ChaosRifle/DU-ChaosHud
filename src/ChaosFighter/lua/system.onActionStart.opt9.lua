--shield vent toggle
if not shield.isVenting() then
    shield.startVenting()
else
    shield.stopVenting()
end
