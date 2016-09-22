print('MCU init!')
wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')')
print('MAC: ', wifi.sta.getmac())
print('chip: ', node.chipid(), 'heap: ', node.heap())
wifi.sta.config("pirata", "12345678")
dofile("main.lua") -- Run the main file
