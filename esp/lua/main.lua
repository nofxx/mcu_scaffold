-- WiFi Connection Verification --
tmr.alarm(0, 1000, 1, function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...\n")
   else
      ip, nm, gw=wifi.sta.getip()
      print("IP: ", ip, "Netmask: ", nm, "GW: ", gw, '\n')
      tmr.stop(0)
   end
end)

-- Global Variables --
led_pin = 1
sw_pin = 2
adc_id = 0 -- Not really necessary since there's only 1 ADC...
adc_value = 512

-- GPIO/Enable PWM output
print("Setting Up GPIO...")
pwm.setup(led_pin, 200, 512) -- 2Hz, 50% duty default
pwm.start(led_pin)
gpio.mode(sw_pin, gpio.INPUT)

-- Web Server --
if srv~=nil then
  srv:close()
end
print("Starting Web Server...")
srv = net.createServer(net.TCP) -- , 30)
srv:listen(80,function(conn)
  conn:on("receive", function(conn, payload)
    print(payload) -- Print data from browser to serial terminal
    local buf = ""

    -- 4:extra path and variables
    local _,_,method,path,vars = string.find(payload,"([A-Z]+) (.+)?(.+) HTTP")
    if(method==nil) then
      _, _, method, path = string.find(payload,"([A-Z]+) (.+) HTTP")
    end

    -- 5:extract the variables passed in the url
    local _GET = {}
    if (vars~=nil) then
      for k,v in string.gmatch(vars,"(%w+)=(%w+)&*") do
        _GET[k] = v
      end
    end


    -- adc_value = adc.read(adc_id)
    -- Sanitize ADC reading for PWM

    buf = buf..'<h1>YOUR COMMAND!</h1>'
    -- buf = buf..'<h2>Get: '.._GET..'</h2>'
    if (_GET.d1~=nil) then
       val = tonumber(_GET.d1)
       if (val > 1023) then
          val = 1024
       end
       -- print("Set PWM Clock")
       -- pwm.setclock(led_pin, adc_value) -- Adjust clock
       print("Set PWM Duty")
       pwm.setduty(led_pin, val) -- Adjust duty cycle
       buf = buf..'<h3>D1: '..val..'</h3>'
    end
    if (_GET.d2~=nil) then
      buf = buf..'<h3>D2: '.._GET.d2..'</h3>'
    end
    conn:send(buf)
    conn:close()
    collectgarbage()
  end)
end)
