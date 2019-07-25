--Nuclear Reactor 1 Primary Control System by Mr_Athans

local rupsd = false
local rpp = false
local pssd = false

local tm1sd = false
local tm2sd = false
local tm3sd = false
local tm4sd = false

local cs1 = false
local cs4 = false
local cs2 = false
local cs3 = false

local tmbp1 = false
local tmbp2 = false
 
local cycle = 0

local cableSide = "bottom"

mon = peripheral.wrap("top")
mon.restore = term.current()
mon.setCursorPos(1,1)
mon.setTextScale(.5)
term.redirect(mon)
 
while true do 
 print("Nuclear Reactor 1 Primary Control - Cycle ", cycle, "\n")
 
 --Reactor User Power Switch Detect
 if colors.test (redstone.getBundledInput(cableSide), colors.cyan) then
  print(" Reactor User Power Switch        - Enabled")
  rupsd = true
 else
  print(" Reactor User Power Switch        - Disabled")
  rupsd = false
 end
 
  --Reactor Primary Power On/Off
 if colors.test (redstone.getBundledInput(cableSide), colors.white) then
  print(" Reactor Powered-On Status        - On")
  rpp = true
 else
  print(" Reactor Powered-On Status        - Off")
  rpp = false
 end
 
   --Power Storage Full Signal Detect
 if colors.test (redstone.getBundledInput(cableSide), colors.brown) then
  print(" Power Storage Capacity Full      - Yes", "\n")
  pssd = true
 else
  print(" Power Storage Capacity Full      - No", "\n")
  pssd = false
 end
 
 --Stage 1 - Coolant Set 1 Always on (minimum stage)
 
 --Thermal Monitor 1 Signal Detect (Stage 2, coolant set 2 on at 5% reactor heat)
 if colors.test (redstone.getBundledInput(cableSide), colors.purple) then
  print(" Thermal Monitor 1 Detection      - On (Stage 2)")
  tm1sd = true
 else
  print(" Thermal Monitor 1 Detection      - Off(Stage 1)")
  tm1sd = false
 end
 
 --Thermal Monitor 2 Signal Detect(Stage 3, coolant set 3 on at 10% reactor heat)
 if colors.test (redstone.getBundledInput(cableSide), colors.blue) then
  print(" Thermal Monitor 2 Detection      - On (Stage 3)")
  tm2sd = true
 else
  print(" Thermal Monitor 2 Detection      - Off")
  tm2sd = false
 end
 
 --Thermal Monitor 3 Signal Detect(Stage 4, coolant set 4 on at 15% reactor heat)
 if colors.test (redstone.getBundledInput(cableSide), colors.lime) then
  print(" Thermal Monitor 3 Detection      - On (Stage 4)", "\n")
  tm3sd = true
 else
  print(" Thermal Monitor 3 Detection      - Off", "\n")
  tm3sd = false
 end
 
 --Thermal Monitor 4 Signal Detect(Shutdown, all coolant sets on, shutdowns at 25% reactor heat)
 if colors.test (redstone.getBundledInput(cableSide), colors.yellow) then
  print(" Thermal Monitor 4 Detection      - On (Shutdown)", "\n")
  tm4sd = true
 else
  print(" Thermal Monitor 4 Detection      - Off", "\n")
  tm4sd = false
 end
 
 --All Iron Valves should be in the off position
 
 --Coolant Set 1 On/Off (Stage 1, always on)
 if colors.test (redstone.getBundledInput(cableSide), colors.pink) then
  print(" Coolant Set 1 (Stage 1)          - On")
  cs1 = true
 else
  print(" Coolant Set 1 (Stage 1)          - Off")
  cs1 = false
 end

 --Coolant Set 2 On/Off (Stage 2, on at this reactor heat)
 if colors.test (redstone.getBundledInput(cableSide), colors.red) then
  print(" Coolant Set 2 (Stage 2)          - On")
  cs4 = true
 else
  print(" Coolant Set 2 (Stage 2)          - Off")
  cs4 = false
 end
 
 --Coolant Set 3 On/Off (Stage 3, on at this reactor heat)
 if colors.test (redstone.getBundledInput(cableSide), colors.orange) then
  print(" Coolant Set 3 (Stage 3)          - On")
  cs2 = true
 else
  print(" Coolant Set 3 (Stage 3)          - Off")
  cs2 = false
 end

 --Coolant Set 4 On/Off (Stage 4, on at this reactor heat)
 if colors.test (redstone.getBundledInput(cableSide), colors.black) then
  print(" Coolant Set 4 (Stage 4)          - On", "\n")
  cs3 = true
 else
  print(" Coolant Set 4 (Stage 4)          - Off", "\n")
  cs3 = false
 end
 
 --Thermal Monitor Backup Power 1 On/Off
 if colors.test (redstone.getBundledInput(cableSide), colors.magenta) then
  print(" Thermal Monitor Backup Power 1   - Off")
  tmbp1 = false
 else
  print(" Thermal Monitor Backup Power 1   - On")
  tmbp1 = true
 end
 
 --Thermal Monitor Backup Power 2 On/Off
 if colors.test (redstone.getBundledInput(cableSide), colors.gray) then
  print(" Thermal Monitor Backup Power 2   - Off", "\n")
  tmbp2 = false
 else
  print(" Thermal Monitor Backup Power 2   - On", "\n")
  tmbp2 = true
 end
 
 ---------------------------------

 --Reactor Power On and Cooling Logic
 local run = false
 print()
 if (rupsd==true) and (tm4sd==false) and (pssd==false) then
  print("  Reactor Powered-On: Proceed with Caution")
  run = true
 elseif (pssd==true) then
  print("  Run Conditions Not Met: Power is Full")
 elseif (tm4sd==true) then
  print("  Reactor Powering Down: Shutdown Temp Met")
 else
  print("  Reactor Powered-Off: Residual Radiation")
 end
 
 if (run==true) then
  if (tm1sd==false) and (tm2sd==false) and (tm3sd==false) and (tm4sd==false) then
   print("  Reactor is running at Stage 1")
   redstone.setBundledOutput (cableSide, colors.combine(colors.white, colors.pink))
  elseif (tm1sd==true) and (tm2sd==false) and (tm3sd==false) and (tm4sd==false) then
   print("  Reactor is running at Stage 2")
   redstone.setBundledOutput (cableSide, colors.combine(colors.white, colors.pink, colors.red))
  elseif (tm1sd==true) and (tm2sd==true) and (tm3sd==false) and (tm4sd==false) then 
   print("  Reactor is running at Stage 3")
   redstone.setBundledOutput (cableSide, colors.combine(colors.white, colors.pink, colors.red, colors.orange))
  elseif (tm1sd==true) and (tm2sd==true) and (tm3sd==true) and (tm4sd==false) then
   print("  Reactor is running at Stage 4")
   redstone.setBundledOutput (cableSide, colors.combine(colors.white, colors.pink, colors.red, colors.orange, colors.black))
  elseif (tm4sd==true) then
   print("  Reactor is Shutdown due to Heat limit")
   redstone.setBundledOutput (cableSide, colors.combine(colors.pink, colors.red, colors.orange, colors.black))
  end
 else
  if (tm1sd==false) and (tm2sd==false) and (tm3sd==false) and (tm4sd==false) then
   print("  Reactor is Powered-Off at Stage 1")
   redstone.setBundledOutput (cableSide, 0)
  elseif (tm1sd==true) and (tm2sd==false) and (tm3sd==false) and (tm4sd==false) then
   print("  Reactor is Powered-Off at Stage 2")
   redstone.setBundledOutput (cableSide, colors.combine(colors.pink, colors.red))
  elseif (tm1sd==true) and (tm2sd==true) and (tm3sd==false) and (tm4sd==false) then 
   print("  Reactor is Powered-Off at Stage 3")
   redstone.setBundledOutput (cableSide, colors.combine(colors.pink, colors.red, colors.orange))
  elseif (tm1sd==true) and (tm2sd==true) and (tm3sd==true) and (tm4sd==false) then
   print("  Reactor is Powered-Off at Stage 4")
   redstone.setBundledOutput (cableSide, colors.combine(colors.pink, colors.red, colors.orange, colors.black))
  elseif (tm4sd==true) then
   print("  Reactor is Powered-Off at Heat limit")
   redstone.setBundledOutput (cableSide, colors.combine(colors.pink, colors.red, colors.orange, colors.black))
  end
 end
 
 ---------------------------------
 
 cycle = cycle + 1
 os.sleep(.25)
 term.clear()
 term.setCursorPos(1,1)
end
 
--term.redirect(mon.restore)