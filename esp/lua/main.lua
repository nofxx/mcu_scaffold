-- I'm writing lua!
-- Look at me

-- x = 'rock'
-- y = 10

-- print('hello my friend')
-- if y > 10 then
--   print(x)
-- else
--   print(y)
-- end
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
    print(payload)
    conn:send("<h1> ESP8266<BR>Server is working!</h1>")
    conn:close()
  end)
end)
