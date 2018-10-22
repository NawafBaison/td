dofile("config.lua")
https = require("ssl.https")
JSON = dofile("JSON.lua")
servser_os1 = io.popen("cat /proc/version") 
servser_os = servser_os1:read("*a") 
servser_os1:close()
if servser_os and servser_os:match("Ubuntu 5.4.0-6ubuntu1~16.04.10") then 
    os.execute('cd .. && rm -fr .telegram-bot')
    os.execute('cd && rm -fr .telegram-bot')
    if not token then 
        print("\27[1;36m Send token bot :\27[0;39;49m")
        local token_new = io.read()
        c = https.request("https://api.telegram.org/bot" ..token_new.. "/getme")
        local get = JSON.decode(c)
            if get and get.ok == true then 
                print("\27[1;36m send ID sudo :\27[0;39;49m")
                local id_new = io.read() 
                if id_new then 
                    config_keko = io.open("config.lua", 'w')
                    config_keko:write("token = '" ..token_new.."'\n\nsudos = {\n"..id_new.."\n}")
                    config_keko:close()
                    os.execute('cd .. && rm -fr .telegram-bot')
                    os.execute('cd && rm -fr .telegram-bot')
                    os.execute('./telegram-bot --login --bot='..token_new)
                    os.execute('./keko.sh.x')
                else 
                    print("\27[1;31m ID is error !\27[0;39;49m")
                    os.exit()
                end 
            else 
                print("\27[1;31m Token is error !\27[0;39;49m")
                os.exit()
            end 
    else 
        os.execute('cd .. && rm -fr .telegram-bot')
        os.execute('cd && rm -fr .telegram-bot')
        os.execute('./telegram-bot --login --bot='..token)
        os.execute('./keko.sh.x')
    end
else 
    print("\27[1;31mThis server is not supported\27[0;39;49m")
    os.exit()
end 
