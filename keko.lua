JSON = require("JSON")
HTTPS = require('ssl.https')
redis = require("redis")
databace = redis.connect('127.0.0.1', 6379)
local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")

function tdbot_update_callback(data)

--code 

end
