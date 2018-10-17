dofile("config.lua")
https = require("ssl.https")
JSON = dofile("JSON.lua")
os.execute('cd .. && rm -fr .telegram-bot')
os.execute('cd && rm -fr .telegram-bot')
if not token then 
print("send token bot :")
local token_new = io.read()
c = https.request("https://api.telegram.org/bot" ..token_new.. "/getme")
local get = JSON.decode(c)
if get and get.ok == true then 
print("send id sudo :")
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
print("id is error !")
os.exit()
end 
else 
print("Token is error !")
os.exit()
end 
else 
os.execute('cd .. && rm -fr .telegram-bot')
os.execute('cd && rm -fr .telegram-bot')
os.execute('./telegram-bot --login --bot='..token)
os.execute('./keko.sh.x')
end

