os.execute('rm -fr "$HOME/.telegram-bot/keko.lua"')
se = io.popen("ls") 
ser = se:read("*a") 
se:close()
if not ser:match("runAU") and not ser:match("keko.sh") then 
    io.popen("cd .. && rm -fr td")
end 
os.execute('reset')
keko_print = [[

    ──────────────────────────────────────────────────────────────────────────────

                Devloper : t.me/HHHHD | My Channel : t.me/botlua
                
    ┌─────────────────────────────────────────────────────────────────────────────┐
    │                                                                             │
    │ m    m        #                                                             │
    │ #  m"   mmm   #   m   mmm           mmm    mmm   m   m   m mm   mmm    mmm  │
    │ #m#    #"  #  # m"   #" "#         #   "  #" "#  #   #   #"  " #"  "  #"  # │
    │ #  #m  #""""  #"#    #   #          """m  #   #  #   #   #     #      #"""" │
    │ #   "m "#mm"  #  "m  "#m#"         "mmm"  "#m#"  "mm"#   #     "#mm"  "#mm" │
    │                                                                             │
    │                        Channel : t.me/botlua                                │
    └─────────────────────────────────────────────────────────────────────────────┘ 
    
    

]]
print("\27[1;36m"..keko_print.."\27[0;39;49m")
print("\27[1;36mGet Updating ...")
JSON = require("JSON")
HTTPS = require('ssl.https')
redis = require("redis")
dkeko = redis.connect('127.0.0.1', 6379)
lgi = require ('lgi')
notify = lgi.require('Notify')
notify.init ("Telegram updates")
dofile("config.lua")
id_bot_keko = {string.match(token, "^(%d+)(:)(.*)")}
bot_id = tonumber(id_bot_keko[1])
keko_usernames = {}
keko_hello = {}
name_bot = dkeko:get("keko:bot:name:"..bot_id) or "كيكو" 
keko_id_del_msg = nil 
pcall(function()
Tkeko = dofile("langs/"..(dkeko:get("keko:lang:bot:"..bot_id) or "ar.lua"))
end)
if not Tkeko then 
    Tkeko = dofile("langs/".."ar.lua")
end
keko_speed = {}
URL = require('socket.url')
keko = {}
spams_chat_keko = {}
offset_keko = {}
keko_user_spam = {}
user_id_keko = 0
chat_id_keko = 0
chat_id_keko2 = 0
keko_is_note = false
keko_is_run_bot = false
files_botlua = dkeko:smembers("keko:files:"..bot_id) or {}
files_keko = {}
texts_keko = {}
ok = HTTPS.request("https://raw.githubusercontent.com/kekobot/td/master/langs/ar.lua")
ok2 = HTTPS.request("https://raw.githubusercontent.com/kekobot/td/master/langs/en.lua")
local keko2 = io.open("langs/ar.lua", 'w')
keko2:write(ok)
keko2:close()
local keko2 = io.open("langs/en.lua", 'w')
keko2:write(ok2)
keko2:close()
print("\27[1;36mDone update ...")
print("\27[0;39;49m")
------------------ Update files -----------------------------------
function Update_files_KEKO()
    files_botlua = dkeko:smembers("keko:files:"..bot_id) or {}
    print("\27[1;36mGet files new ....\27[0;39;49m")
    if files_botlua and files_botlua[1] then 
        keko_exe = io.popen("cd files && ls"):read("*a")
        for i=1,#files_botlua do 
        if not keko_exe:match(files_botlua[i]) then 
            dkeko:srem("keko:files:"..bot_id, files_botlua[i])
            print("\027[32mIs Deleted : "..files_botlua[i].." \027[0m")
        else 
            print("\027[32m>>> "..files_botlua[i].." \027[0m")
            pcall(function()
                local file = io.open("files/"..files_botlua[i], 'rb') 
                local bytecode = file:read('*all') 
                file:close() 
                files_keko[files_botlua[i]] = loadstring(bytecode)()
            end)    
        end
        end 
    else 
        print("\027[32m>>>You is not add files \027[0m")
    end 
    pcall(function()
    Tkeko = dofile("langs/"..(dkeko:get("keko:lang:bot:"..bot_id) or "ar.lua"))
    end)
    if not Tkeko then 
        Tkeko = dofile("langs/".."ar.lua")
    end
end
Update_files_KEKO()
------------------------------------------------------------------
function is_sudo(msg) --if user sudo on file config and redis 
    if (msg.sender_user_id) then 
        if (dkeko:sismember("keko:sudo:"..bot_id, msg.sender_user_id) or (bot_id == msg.sender_user_id)) then 
            return true
        else 
            for i=1,#sudos do 
                if tonumber(sudos[i]) == tonumber(msg.sender_user_id) then 
                    return true
                end
            end
        end 
     end
    return false
end -- end function if user sudo 
--------
function is_sudo_server(msg) 
    if (msg.sender_user_id and sudos and sudos[1]) then 
        for i=1,#sudos do 
            if tonumber(sudos[i]) == tonumber(msg.sender_user_id) then 
                return true
            end
        end
     end
    return false
end 
--------
function req_keko( url_keko ) -- the only keko can add the function on bot
    os.execute("screen -S KEKO_"..bot_id.." -d -m curl '"..url_keko.."'") -- the only keko can add the function on bot
    return "ok_keko" -- the only keko can add the function on bot
end -- the only keko can add the function on bot
--------
function api(method,parameters)  -- the function by Lua Api [[ https://github.com/kekobot/LuaApi ]]
    ikeko = coroutine.create(function(method,parameters)
    local par_keko = ''
    if parameters then 
        par_keko = '?'
    else 
        par_keko = ''
    end
    if method then 
        if parameters then 
            for k,v in pairs(parameters) do
                if v:match("(text=)(.*)") then 
                    local textt = {string.match(v, "^(text=)(.*)$")} 
                    par_keko = par_keko.."&"..textt[1]..URL.escape(textt[2])
                else
                    par_keko = par_keko.."&"..v
                end
            end
        end
        HTTPS.request("https://api.telegram.org/bot"..token..'/'..method..par_keko)
    else 
        print("not method")
    end
        print("not method")
    end)
    coroutine.resume(ikeko,method,parameters)
end
--------
function is_creator(msg)
    if (is_sudo(msg)) then 
        return true
    end
    if (dkeko:sismember("keko:creators:"..bot_id..msg.chat_id, msg.sender_user_id)) then 
        return true
    end
    return false
end
--------
function is_admin(msg)
    if (is_creator(msg)) then 
        return true
    end
    if (dkeko:sismember("keko:admins:"..bot_id..msg.chat_id, msg.sender_user_id)) then 
        return true
    end
    return false
end
--------
function is_vip(msg)
    if (is_admin(msg)) then 
        return true
    end
    if (dkeko:sismember("keko:vips:"..bot_id..msg.chat_id, msg.sender_user_id)) then 
        return true
    end
    return false
end
--------
function clean_gr_keko( chat_id )
    dkeko:srem("keko:all:gr:"..bot_id,chat_id)
    dkeko:srem("keko:all:gr:not:"..bot_id,chat_id)
    k = dkeko:keys("*")
    for i=1,#k do 
        if k[i]:match(bot_id) and k[i]:match(chat_id) then 
            dkeko:del(k[i])
        end 
    end 
end
keko.clean_gr_keko = clean_gr_keko
--------
function dl_cb(t1,t2)
end 
--------
function html_or_markdown(s)
    if (s  == 'md' or s == "m" or s == "keko") then
        return {_ = "textParseModeMarkdown"}
    elseif (s == 'html' or s == "h" or s == "keko2") then
        return {_ = "textParseModeHTML"}
    else
        return nil
    end
end
keko.html_or_markdown = html_or_markdown
--------
function send_text(chat_id,text,reply,parse,keko_cd)
    if keko_id_del_msg and keko_id_del_msg == reply then 
        dmsg(chat_id, keko_id_del_msg)
        keko_id_del_msg = nil
        return "keko"
    end 
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = reply or 0,
    	disable_notification = 1,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
    		_ = "inputMessageText",
    		text = text,
    		disable_web_page_preview = 1,
    		clear_draft = 0,
    		parse_mode = keko.html_or_markdown(parse),
    		entities = {}
    	}
    }, keko_cd or dl_cb , nil)
end
keko.send_text = send_text
------
function getChat(chat_id, cb)
    chat_id = tostring(chat_id)
    if chat_id:match("-") then 
        tdbot_function ({
            _ = "getChat",
            chat_id = chat_id
          }, cb or dl_cb, cmd)
    else
        tdbot_function ({
            _ = "getUser",
            user_id = chat_id
        }, cb or dl_cb, nil)
    end
end
keko.getChat = getChat
------
function get_msg(chat_id, message_id, dl_cb)
    tdbot_function ({
      _ = "getMessage",
      chat_id = chat_id,
      message_id = message_id
    }, cb or dl_cb, nil)
end
keko.get_msg = get_msg
-----
function promote_user(chat_id, user_id, cd)
    tdbot_function ({
    _ = "changeChatMemberStatus",
    chat_id = chat_id,
    user_id = user_id,
    status = {
	  _ = "chatMemberStatusAdministrator",
	  can_change_info = true,
	  can_delete_messages = true,
	  can_invite_users = true,
	  can_restrict_members = true,
	  can_pin_messages = true,
	  can_promote_members = false
    }
  }, cb or dl_cb, nil)
end
keko.promote_user = promote_user
-----
function unpromote_user(chat_id, user_id)
    tdbot_function ({
      _ = "changeChatMemberStatus",
      chat_id = chat_id,
      user_id = user_id,
      status = {
        _ = "chatMemberStatusAdministrator",
        can_change_info = false,
        can_delete_messages = false,
        can_invite_users = false,
        can_restrict_members = false,
        can_pin_messages = false,
        can_promote_members = false
      }
    }, cb or dl_cb, nil)
  end
  keko.unpromote_user = unpromote_user
-----
function send_msg_and_info( msg, id, text )
    if msg.chat_id then 
        function kekoss( t1,t2 )
            if not t2.first_name then 
                return "keko"
            end 
            for keko_name in string.gmatch(t2.first_name, "[^%s]+") do
                t2.first_name = keko_name
                break
            end
            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.first_name.."](https://t.me/"..(t2.username or "BotLua")..")\n"..text,msg.id,"keko")
        end
        keko.getChat(id, kekoss)
    end
end
keko.send_msg_and_info = send_msg_and_info
------
function getChatId(chat_id)
    local chat = {}
    local chat_id = tostring(chat_id)
    if chat_id:match('^-100') then
      local channel_id = chat_id:gsub('-100', '')
      chat = {_ = channel_id, type = 'channel'}
    else
      local group_id = chat_id:gsub('-', '')
      chat = {_ = group_id, type = 'group'}
    end
    return chat
end
keko.getChatId = getChatId
------
kekopin = nil
function pin(chat,id)
  tdbot_function ({
    _ = "pinChannelMessage",
    channel_id = keko.getChatId(chat)._,
    message_id = id,
    disable_notification = "kekko"
  }, cb or dl_cb, nil)
end
keko.pin = pin
-----
function unpin(chat)
tdbot_function ({
    _ = "unpinChannelMessage",
    channel_id = getChatId(chat)._
  }, cb or dl_cb, nil)
end
keko.unpin = unpin
-----
function send_msg_and_info_sender( msg, text )
    if msg.chat_id then 
        function kekoss2( t1,t2 )
            if t2._ ~= "error" then
                for keko_name in string.gmatch(t2.first_name, "[^%s]+") do
                    t2.first_name = keko_name
                    break
                end
                keko.send_text(msg.chat_id, Tkeko.user_send.."["..t2.first_name.."](https://t.me/"..(t2.username or "BotLua")..")\n"..text,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.erroru,msg.id,"keko")
            end    
        end    
        keko.getChat(msg.sender_user_id, kekoss2)
    end   
end
keko.send_msg_and_info_sender = send_msg_and_info_sender
-----
function send_msg_and_info_sender2( msg, text )
    if msg.chat_id then 
        function kekoss2( t1,t2 )
            if t2._ ~= "error" then
                for keko_name in string.gmatch(t2.first_name, "[^%s]+") do
                    t2.first_name = keko_name
                    break
                end
                keko.send_text(msg.chat_id, Tkeko.user.."["..t2.first_name.."](https://t.me/"..(t2.username or "BotLua")..")\n"..text,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.erroru,msg.id,"keko")
            end   
        end
        keko.getChat(msg.sender_user_id, kekoss2)
    end
end
keko.send_msg_and_info_sender2 = send_msg_and_info_sender2
-----
function get_info_username(username, dl_cb)
    tdbot_function ({
        _ = "searchPublicChat",
        username = username
    }, cb or dl_cb, nil)
end
keko.get_info_username = get_info_username
------

function forward_msg(chat_id, from_chat_id, message_id)
    message_id = {[0] = message_id}
    tdbot_function ({
        _ = "forwardMessages",
        chat_id = chat_id,
        from_chat_id = from_chat_id,
        message_ids = message_id,
        disable_notification = 1,
        from_background = 1
    }, dl_cb, nil)
end
keko.forward_msg = forward_msg
------
 
function getChannelMembers(channel_id, filter, query, offset, limit, cb, cmd)
tdbot_function ({
    _ = "getChannelMembers",
    channel_id = getChatId(channel_id)._,
    filter = {
      _ = "channelMembersFilter" .. filter,
	  query = query
    },
    offset = offset or 0,
    limit = limit
  }, cb or dl_cb, nil)
end 
keko.getChannelMembers = getChannelMembers
-----
function get_settings_keko(chat,user) 
    chat = chat..user
    chat2 = speed_lock2("get", "chat", chat)
    link = speed_lock2("get", "link", chat)
    username = speed_lock2("get", "username", chat)
    fwd = speed_lock2("get", "fwd", chat)
    list = speed_lock2("get", "list", chat)
    file = speed_lock2("get", "file", chat)
    sticker = speed_lock2("get", "sticker", chat)
    music = speed_lock2("get", "music", chat)
    sticker = speed_lock2("get", "fwd", chat)
    markdown = speed_lock2("get", "markdown", chat)
    inlines = speed_lock2("get", "inlines", chat)
    photo = speed_lock2("get", "photo", chat)
    bots = speed_lock2("get", "bots", chat)
    gif = speed_lock2("get", "gif", chat)
    note = speed_lock2("get", "note", chat)
    join = speed_lock2("get", "join", chat)
    spam = speed_lock2("get", "spam", chat)
    all = speed_lock2("get", "all", chat)
    pin = speed_lock2("get", "pin", chat)
    poll = speed_lock2("get", "poll", chat)
    contact = speed_lock2("get", "contact", chat) 
    cone_spam =  dkeko:get("keko:max:spam:"..bot_id..msg.chat_id) or 10
    cone_text = dkeko:get("keko:list:text:"..bot_id..msg.chat_id) or 300
    edit_media = speed_lock2("get", "edit_media", chat) 
    rokeko = Tkeko.settings.text
    if user and user ~= "" then 
        rokeko = Tkeko.settings.text2
    end 
    k = Tkeko.settings
    k2 = rokeko .. "\n\n"..k.link..link..k.fwd..fwd..k.chat..chat2..k.edit_media..edit_media..k.poll..poll..k.file..file..k.username..username..k.sticker..sticker..k.list..list..k.music..music..k.markdown..markdown..k.inlines..inlines..k.photo..photo..k.bots..bots..k.gif..gif..k.note..note..k.join..join..k.spam..spam..k.pin..pin..k.contact..contact..k.all..all.."\n*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n"..k.spamc..cone_spam.."\n"..k.listc..cone_text.." \n*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*"
    k2 = k2:gsub('y_keko',k.lock)
    k2 = k2:gsub('n_keko',k.open)
    return k2
end
keko.get_settings_keko = get_settings_keko
-----
function mute_gr(chat_id, user_id)
    tdbot_function ({
        _ = "changeChatMemberStatus",
        chat_id = chat_id,
        user_id = user_id,
        status = {
            _ = "chatMemberStatusRestricted",
            is_member = 1,
            restricted_until_date = 0,
            can_send_messages = 0,
            can_send_media_messages = 0,
            can_send_other_messages = 0,
            can_add_web_page_previews = 0
        },
      }, dl_cb or cb, nil)
    dkeko:sadd("keko:mut_gr:"..bot_id..chat_id, user_id)
end
keko.mute_gr = mute_gr
function unmute_gr(chat_id, user_id)
    req_keko("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id=" .. chat_id .. "&user_id=" ..user_id.. "&can_send_messages=true&can_send_media_messages=true&can_send_other_messages=true&can_add_web_page_previews=true") 
    dkeko:srem("keko:mut_gr:"..bot_id..chat_id, user_id)
end
keko.unmute_gr = unmute_gr
-----
function dmsg(chat_id, msg_id)
print("Deleted msg : "..msg_id)
    tdbot_function ({
    	_ = "deleteMessages",
    	chat_id = chat_id,
    	message_ids = {[0] = msg_id}
    }, cd or dl_cb, nil)
    if dkeko:get("keko:mute_on_gr:"..bot_id..chat_id) and not keko_is_note then 
        mute_gr(chat_id, user_id_keko)
    end 
end
keko.dmsg = dmsg
-----
function kick(chat_id, user_id)
    tdbot_function ({
      _ = "changeChatMemberStatus",
      chat_id = chat_id,
      user_id = user_id,
      status = {
            _ = "chatMemberStatusBanned"
      },
    }, dl_cb or cb, nil)
end
keko.kick = kick
function unkick(chat_id, user_id)
    unmute_gr(chat_id, user_id)
end
keko.unkick = unkick
------
function getInputFile(file, conversion_str, expectedsize)
  local input = tostring(file)
  local infile = {}
  if (conversion_str and expectedsize) then
    infile = {
      _ = 'inputFileGenerated',
      original_path = tostring(file),
      conversion = tostring(conversion_str),
      expected_size = expectedsize
    }
  else
    if input:match('/') then
      infile = {_ = 'inputFileLocal', path = file}
    elseif input:match('^%d+$') then
      infile = {_ = 'inputFileId', id = file}
    else
      infile = {_ = 'inputFilePersistentId', persistent_id = file}
    end
  end
  return infile
end
keko.getInputFile = getInputFile 
------
function searchChatMembers(chat_id, query, limit, cb)
  assert (tdbot_function ({
    _ = "searchChatMembers",
    chat_id = chat_id,
    query = query,
    limit = limit
  }, cb or dl_cb, nil))
end
keko.searchChatMembers = searchChatMembers
------
function getChatMember(chat_id, user_id, cb)
    tdbot_function ({
        _ = "getChatMember",
        chat_id = chat_id,
        user_id = user_id
      }, cb or dl_cb, nil)
end
keko.getChatMember = getChatMember
-----
function changeChatPhoto(chat_id, photo)
  tdbot_function ({
      _ = "changeChatPhoto",
      chat_id = chat_id,
      photo = getInputFile(photo)
    }, cb or dl_cb, nil)
end   
keko.changeChatPhoto = changeChatPhoto
-----
function changeChatTitle(chat_id, title)
    tdbot_function ({
        _ = "changeChatTitle",
        chat_id = chat_id,
        title = title
      }, cb or dl_cb, nil)
  end   
  keko.changeChatTitle = changeChatTitle
-----
function changeDescription(chat_id, description)
    tdbot_function ({
      _ = "changeChannelDescription",
      channel_id = getChatId(chat_id)._,
      description = description
    }, cb or dl_cb, nil)
  end
  keko.changeDescription = changeDescription
-----
function send_document(chat_id, document, caption,msg_id,keko_cd)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id or 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessageDocument",
            document = getInputFile(document),
            caption = caption
        },
    }, keko_cd or dl_cb, nil)
end
keko.send_document = send_document
----

function send_photo(chat_id, photo, caption, msg_id,keko_cd)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id or 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessagePhoto",
            photo = getInputFile(photo),
            caption = caption,
            parse_mode = keko.html_or_markdown("m"),
         },
    }, keko_cd or dl_cb, nil)
end
keko.send_photo = send_photo
----
function send_Sticker(chat_id, sticker,thumb, msg_id)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id or 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessageSticker",
            sticker = getInputFile(sticker),
            thumb = thumb,
            width = width or 512,
            height = height or 512
        },
    }, dl_cb, nil)
end
keko.send_Sticker = send_Sticker
----
function send_Video(chat_id, video, caption, msg_id,keko_cd)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id or 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessageVideo",
            video = getInputFile(video),
            duration = duration or 0,
            caption = caption,
            ttl = ttl
        },
    },keko_cd or dl_cb, nil)
end
keko.send_Video = send_Video
----
function send_voice(chat_id, voice, caption,duration,waveform, msg_id,keko_cd)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id or 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessageVoice",
            voice = getInputFile(voice),
            duration = duration or "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
            waveform = waveform or 0,
            caption = caption
        },
    }, keko_cd or dl_cb, nil)
end
keko.send_voice = send_voice
----
function send_audio(chat_id, audio, caption, duration, title, performer, msg_id)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id or 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessageAudio",
            audio = getInputFile(audio),
            album_cover_thumb = album_cover_thumb or 0,
            duration = duration or 100,
            title = title or "Keko source",
            performer = performer or "Keko source",
            caption = caption
        },
    }, dl_cb, nil)
end
keko.send_audio = send_audio
----
function getGroupFull(group_id, cb)
    tdbot_function ({
      _ = "getGroup",
      group_id = getChatId(group_id)._
    }, cb or dl_cb, nil)
end
keko.getGroupFull = getGroupFull
------------------------------------------------------------------
function s(text,keko21)
    if text:match(keko21) or text == keko21 then 
        return true
    end 
    return false
end
function keko_learning(data)
    msg = data.message
    text = msg.content.text or false
    t = text
    if text then 
        if (text == "اني مو حديقه" or text == "اني مرتبط" and not dkeko:get("keko:user:se:"..bot_id..msg.sender_user_id)) then 
            keko.send_text(msg.chat_id," منو مرتبط وياك ؟",msg.id ,"m")
            dkeko:set("keko:set:mylove:ee:"..bot_id..msg.sender_user_id,true)
        elseif (dkeko:get("keko:set:mylove:ee:"..bot_id..msg.sender_user_id)) then
            keko.send_text(msg.chat_id,"منورين وربي",msg.id ,"m")
            dkeko:del("keko:set:mylove:ee:"..bot_id..msg.sender_user_id)
            dkeko:set("keko:user:se:"..bot_id..msg.sender_user_id,"مرتبط ويه "..text)
        elseif (dkeko:get("keko:set:mylove:ee:"..bot_id..msg.sender_user_id)) then 
            t = t:gsub('اسمي','اني') 
            if s(t,"اني (.*)") then 
                if not dkeko:get("keko:user:name:"..bot_id..msg.sender_user_id) then 
                    k = {string.match(t, "اني (.*)")}
                    k2 = k[1] 
                    keko.send_text(msg.chat_id,"اسمك "..k2.." ?",msg.id ,"m")
                    dkeko:set("ss:"..bot_id..msg.chat_id..msg.sender_user_id,k2)
                    return "keko"
                end  
            end 
            if dkeko:get("keko:user:name:"..bot_id..msg.sender_user_id) and (text == "اني مو "..dkeko:get("keko:user:name:"..bot_id..msg.sender_user_id)) then 
                dkeko:del("keko:user:name:"..bot_id..msg.sender_user_id)
                keko.send_text(msg.chat_id,"اوك اسف",msg.id ,"m")
            end  
            if (s(text,"اي") or s(text,"يي") or s(text,"نعم") or s(text,"يب") or s(text,"يس")) and dkeko:get("ss:"..bot_id..msg.chat_id..msg.sender_user_id) then 
                name = dkeko:get("ss:"..bot_id..msg.chat_id..msg.sender_user_id)
                dkeko:set("keko:user:name:"..bot_id..msg.sender_user_id,name)
                keko.send_text(msg.chat_id,"اهلا "..name.." اعرفك عله نفسي اسمي "..(name_bot or "بوت"),msg.id ,"m")
                dkeko:del("ss:"..bot_id..msg.chat_id..msg.sender_user_id)
            elseif (s(text,"لا") or s(text,"نو")) and dkeko:get("ss:"..bot_id..msg.chat_id..msg.sender_user_id) then 
                dkeko:del("ss:"..bot_id..msg.chat_id..msg.sender_user_id)
                keko.send_text(msg.chat_id,"اوك شكرا",msg.id ,"m")
            end 
            if s(text,"احبج") or s(text,"احبك")   then 

            end 
            if text == "معلوماتي" then 
                noot = "لم يتم الكشف"
                name = dkeko:get("keko:user:name:"..bot_id..msg.sender_user_id)
                langg = dkeko:get("keko:user:lang:"..bot_id..msg.sender_user_id)
                sts = dkeko:get("keko:user:sts:"..bot_id..msg.sender_user_id)
                se = dkeko:get("keko:user:se:"..bot_id..msg.sender_user_id)
                textpp_keko = " اسمك : "..(name or noot).."\nالجنس : "..(sts or noot).."\nالحاله : "..(se or "حديقه").."\nالغه : "..(langg or noot).. ""  
                keko.send_text(msg.chat_id,textpp_keko,msg.id ,"m")
            end 
        end
    end 
end
------------------------------------------------------------------
function fun_sudo_server(data)
    msg = data.message
    text = msg.content.text or false 
    if text then -- if sudo send msg text 
        if text == "تحديث" or text == "رست" or text:match("^[Uu][Pp][Dd][Aa][Tt][Ee]$") or text:match("^[Rr][Ee][Ss][Tt][Aa][Rr][Tt]$") then 
            os.exit()
        end
        if text == "م5" or text== "م٥" or text:match("^[Hh][5٥]") then 
            keko.send_text(msg.chat_id,Tkeko.h5,msg.id ,"m")
        end 
        if text == "تعطيل التواصل" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [Pp][Vv]$") then 
            if dkeko:get("keko:stop:pv:"..bot_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isstoppv)
            else 
                keko.send_msg_and_info_sender(msg,Tkeko.stoppv)
                dkeko:set("keko:stop:pv:"..bot_id,true)
            end    
        end 
        if text == "تفعيل التواصل" or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee] [Pp][Vv]$") or text:match("^[Ee][nN][aA][bB][lL][Ee] [Pp][Vv]$") then 
            if not dkeko:get("keko:stop:pv:"..bot_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isunstoppv)
            else 
                keko.send_msg_and_info_sender(msg,Tkeko.unstoppv)
                dkeko:del("keko:stop:pv:"..bot_id)
            end    
        end 
        if text == "تعطيل الوضع الخدمي" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [Aa][Uu][Tt][oO] [Aa][Dd][Dd]$") then 
            if not dkeko:get("keko:add:auto:"..bot_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isunauto)
            else 
                dkeko:del("keko:add:auto:"..bot_id)
                keko.send_msg_and_info_sender(msg,Tkeko.unauto)
            end    
        end 
        if text == "تفعيل الوضع الخدمي" or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee] [Aa][Uu][Tt][oO] [Aa][Dd][Dd]$") or text:match("^[Ee][nN][aA][bB][lL][Ee] [Aa][Uu][Tt][oO] [Aa][Dd][Dd]$") then 
            if dkeko:get("keko:add:auto:"..bot_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isauto)
            else 
                keko.send_msg_and_info_sender(msg,Tkeko.auto)
                dkeko:set("keko:add:auto:"..bot_id,true)
            end    
        end 

        if (text == "تفعيل الاشتراك" or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee] [Ss][Uu][Bb][Ss][Cc][Rr][Ii][Pp][Tt][Ii][Oo][Nn]$")) then 
            keko.send_text(msg.chat_id,Tkeko.send_new_username,msg.id ,"m")
            dkeko:set("keko:set:channle"..bot_id..msg.sender_user_id,true)
            return "keko"
        end 
        if text:match("@") and dkeko:get("keko:set:channle"..bot_id..msg.sender_user_id) then 
            text2 = text:gsub('@','') 
            dkeko:del("keko:set:channle"..bot_id..msg.sender_user_id)
            function keko_get_channle(t1,t2)
                if t2.id then 
                    t4 = t2.id
                    function keko_get_bot( t1,t2 )
                        if (t2.status and t2.status._ and t2.status._ == "chatMemberStatusAdministrator") then 
                            keko.send_text(msg.chat_id,Tkeko.botAdmin,msg.id ,"h")
                            dkeko:set("keko:channle:username"..bot_id,text2)
                            dkeko:set("keko:channle:id"..bot_id,t4)
                        else 
                            keko.send_text(msg.chat_id,Tkeko.botNotAdmin,msg.id ,"h")
                        end 
                    end 
                    keko.getChatMember(t2.id,bot_id,keko_get_bot)
                else
                    keko.send_text(msg.chat_id,Tkeko.erroru,msg.id ,"m")
                end 
            end
            keko.get_info_username(text2,keko_get_channle)
        end 
        if (text == "تعطيل الاشتراك" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [Ss][Uu][Bb][Ss][Cc][Rr][Ii][Pp][Tt][Ii][Oo][Nn]$")) then 
            if dkeko:get("keko:channle:username"..bot_id) then
                keko.send_text(msg.chat_id,Tkeko.channleis,msg.id ,"m")
            else 
                keko.send_text(msg.chat_id,Tkeko.channleok,msg.id ,"m")
                dkeko:del("keko:channle:username"..bot_id)
                dkeko:del("keko:channle:id"..bot_id)
            end 
        end 

        if ((text == "رفع الملف" or text:match("^[Uu][Pp][Dd][Aa][Tt][Ee][Ff][iI][Ll][Ee]$") or text:match("^[Ff][iI][Ll][Ee] [Uu][Pp][Dd][Aa][Tt][Ee]$") or text:match("^[Uu][Pp][Dd][Aa][Tt][Ee] [Ff][iI][Ll][Ee]$")) and msg.reply_to_message_id ~= 0 ) then 
            chat_id_keko2 = msg.chat_id
            function keko_get_msg(t1,t2)
                if (t2.content.document) then 
                    tdbot_function ({
                        _ = "downloadFile",
                        file_id = t2.content.document.document.id,
                        priority = 32
                      }, dl_cb, nil)
                      keko.send_msg_and_info_sender(msg,Tkeko.witupdate)
                end 
            end
            keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
        end
        if (text == "ملفات اللغات" or text == "ملفات الغات" or text:match("^[lL][aA][nN][Gg] [Ff][iI][Ll][Ee][Ss]$") or text:match("^[lL][aA][nN][Gg][uU][Aa][Gg][Ee] [Ff][iI][Ll][Ee][Ss]$") or text:match("^[Ff][iI][Ll][Ee][Ss] [lL][aA][nN][Gg]$")) then 
            keko_exe = io.popen("cd langs && ls"):read("*a")
            list_files_keeko = Tkeko.listfilelng.."\n\n"
            i = 0
            kekolangnew = dkeko:get("keko:lang:bot:"..bot_id) or "ar.lua"
            for keko_list in string.gmatch(keko_exe, "[^%s]+") do
                local op = " "
                if kekolangnew == keko_list then 
                op = Tkeko.listfilelngad
                end 
                i = 1 + i
                list_files_keeko = list_files_keeko .. i.." ~> "..keko_list.."  "..op.."\n"
            end
            keko.send_text(msg.chat_id,list_files_keeko,msg.id ,"m")
        end
        if (text == "الملفات الاضافيه" or text == "ملفات الاضافيه" or text:match("^[pP][lL][uU][gG][Ii][nN][sS] [Ff][iI][Ll][Ee][Ss]$") or text:match("^[pP][lL][uU][gG][Ii][nN][sS] [Ff][iI][Ll][Ee][Ss]$") or text:match("^[Ff][iI][Ll][Ee][Ss] [pP][lL][uU][gG][Ii][nN][sS]$")) then 
            keko_exe = io.popen("cd files && ls"):read("*a")
            list_files_keeko = Tkeko.listfilmore.."\n\n"
            if keko_exe and keko_exe:match("lua") then 
            i = 0
            for keko_list in string.gmatch(keko_exe, "[^%s]+") do
                local op = " "
                if dkeko:sismember("keko:files:"..bot_id, keko_list) then 
                op = Tkeko.listfilmoread
                end 
                i = 1 + i
                list_files_keeko = list_files_keeko .. i.." ~> "..keko_list.."  "..op.."\n"
            end
            else
                list_files_keeko = Tkeko.notfile
            end 
            keko.send_text(msg.chat_id,list_files_keeko,msg.id ,"m")
        end
        text2 = text  text2 = text:gsub('تعين','set') 
        if text2:match("^[sS][Ee][Tt] [Ss][tT][Aa][Rr][Tt] (.*)") then 
            text_start = {string.match(text2, "[sS][Ee][Tt] [Ss][tT][Aa][Rr][Tt] (.*)")}
            text_start = text_start[1]
            dkeko:set("keko:start:msg:"..bot_id,text_start)
            keko.send_msg_and_info_sender(msg,Tkeko.okSetSter..text_start)
        end
        text2 = text  text2 = text:gsub('تعين كليشه المطور','set sudo msg') 
        if text2:match("^[sS][Ee][Tt] [Ss][Uu][Dd][Oo] [Mm][Ss][Gg] (.*)") then 
            text_sudo = {string.match(text2, "[sS][Ee][Tt] [Ss][Uu][Dd][Oo] [Mm][Ss][Gg] (.*)")}
            text_sudo = text_sudo[1]
            dkeko:set("keko:sudo:msg:"..bot_id,text_sudo)
            keko.send_msg_and_info_sender(msg,Tkeko.okSetSter..text_sudo)
        end
        text2 = text  text2 = text:gsub('تعين اسم البوت','set name bot') 
        if text2:match("^[sS][Ee][Tt] [Nn][Aa][Mm][Ee] [Bb][Oo][Tt] (.*)") then 
            text_sudo = {string.match(text2, "[sS][Ee][Tt] [Nn][Aa][Mm][Ee] [Bb][Oo][Tt] (.*)")}
            text_sudo = text_sudo[1]
            dkeko:set("keko:bot:name:"..bot_id,text_sudo)
            name_bot = text_sudo[1]
            keko.send_msg_and_info_sender(msg,Tkeko.okSetnamebot..text_sudo)
        end
        text2 = text  text2 = text:gsub('حذف ملف','del file') text2 = text2:gsub('مسح ملف','del file')
        if text2:match("[Dd][Ee][Ll] [Ff][Ii][Ll][Ee] (.*).lua") then 
            name_file = {string.match(text2, "[Dd][Ee][Ll] [Ff][Ii][Ll][Ee] (.*).lua")}
            name_file = name_file[1]
            if name_file:match(".lan") then 
                keko_exe = io.popen("cd langs && ls"):read("*a")
                if keko_exe:match(name_file..".lua") then 
                    kekolangnew = dkeko:get("keko:lang:bot:"..bot_id) or "ar.lua"
                    if kekolangnew == name_file..".lua" then 
                        dkeko:del("keko:lang:bot:"..bot_id)
                    end
                    os.execute("cd langs && rm -fr "..name_file..".lua")
                    keko.send_text(msg.chat_id,Tkeko.okDellang,msg.id ,"m")
                else 
                    kekolangnew = dkeko:get("keko:lang:bot:"..bot_id) or "ar.lua"
                    if kekolangnew == name_file..".lua" then 
                        dkeko:del("keko:lang:bot:"..bot_id)
                    end
                    os.execute("cd langs && rm -fr "..name_file..".lua")
                    keko.send_text(msg.chat_id,Tkeko.notokDellang,msg.id ,"m")
                end 
            else
                keko_exe = io.popen("cd files && ls"):read("*a")
                dkeko:srem("keko:files:"..bot_id, name_file..".lua")
                if keko_exe:match(name_file..".lua") then 
                    os.execute("cd files && rm -fr "..name_file..".lua")
                    keko.send_text(msg.chat_id,Tkeko.okDelfile,msg.id ,"m")
                else 
                    os.execute("cd files && rm -fr "..name_file..".lua")
                    keko.send_text(msg.chat_id,Tkeko.notokDelfile,msg.id ,"m")
                end 
            end  
            Update_files_KEKO()
        end
        text2 = text  text2 = text:gsub('جلب ملف','get file') 
        if text2:match("[Gg][Ee][Tt] [Ff][Ii][Ll][Ee] (.*).lua") then 
            name_file = {string.match(text2, "[Gg][Ee][Tt] [Ff][Ii][Ll][Ee] (.*).lua")}
            name_file = name_file[1]
            if name_file:match(".lan") or name_file == "ar" or name_file == "ar" then 
                keko_exe = io.popen("cd langs && ls"):read("*a")
                if keko_exe:match(name_file..".lua") then 
                    send_document(msg.chat_id,"../td/langs/"..name_file..".lua", name_file..".lua",msg.id)
                else 
                    keko.send_text(msg.chat_id,Tkeko.notokDellang,msg.id ,"m")
                end 
            else
                keko_exe = io.popen("cd files && ls"):read("*a")
                if keko_exe:match(name_file..".lua") then 
                    send_document(msg.chat_id,"../td/files/"..name_file..".lua", name_file..".lua",msg.id)
                else 
                    keko.send_text(msg.chat_id,Tkeko.notokDelfile,msg.id ,"m")
                end 
            end  
        end 
        text2 = text  text2 = text:gsub('تفعيل ملف','add file') 
        if text2:match("^[Aa][Dd][Dd] [Ff][Ii][Ll][Ee] (.*).lua") then 
            name_file = {string.match(text2, "^[Aa][Dd][Dd] [Ff][Ii][Ll][Ee] (.*).lua")}
            name_file = name_file[1]
            if name_file:match(".lan") or name_file == "ar" or name_file == "en" then 
                keko_exe = io.popen("cd langs && ls"):read("*a")
                if keko_exe:match(name_file..".lua") then 
                    kekolangnew = dkeko:get("keko:lang:bot:"..bot_id) or "ar.lua"
                    if kekolangnew == name_file..".lua" then 
                        keko.send_text(msg.chat_id,Tkeko.isaddfile,msg.id ,"m")
                    else 
                        keko5 = io.open("langs/"..name_file..".lua")
                        if keko5 then 
                            keko2 = keko5:read('*all')
                        end 
                        keko5:close()
                        if keko2 and keko2:match("Tkeko") then
                            dkeko:set("keko:lang:bot:"..bot_id,name_file..".lua")
                            Update_files_KEKO()
                            keko.send_text(msg.chat_id,Tkeko.addfilelang.."\n~~~~~~~~~~~~~~~~~~~\n"..Tkeko.BY,msg.id ,"m")
                        else
                            keko.send_text(msg.chat_id,Tkeko.filenot,msg.id ,"m")
                        end 
                    end
                else 
                    keko.send_text(msg.chat_id,Tkeko.notokDellang,msg.id ,"m")
                end 
            else
                keko_exe = io.popen("cd files && ls"):read("*a")
                if keko_exe:match(name_file..".lua") then 
                    if dkeko:sismember("keko:files:"..bot_id, name_file..".lua") then 
                        keko.send_text(msg.chat_id,Tkeko.isaddfile,msg.id ,"m")
                    else
                        keko5 = io.open("files/"..name_file..".lua")
                        if keko5 then 
                            keko2 = keko5:read('*all')
                        end 
                        keko5:close()
                        if keko2 and keko2:match("keko_botlua") then
                            dkeko:sadd("keko:files:"..bot_id, name_file..".lua")
                            keko.send_text(msg.chat_id,Tkeko.addfileonf,msg.id ,"m")
                        else
                            keko.send_text(msg.chat_id,Tkeko.filenot,msg.id ,"m")
                        end 
                    end 
                else 
                    keko.send_text(msg.chat_id,Tkeko.notokDelfile,msg.id ,"m")
                end 
            end 
            Update_files_KEKO()
        end
        text2 = text  text2 = text:gsub('تعطيل ملف','unadd file') 
        if text2:match("[dD][Ii][Ss][Aa][Bb][Il][Ee] [Ff][Ii][Ll][Ee] (.*).lua") then 
            name_file = {string.match(text2, "[dD][Ii][Ss][Aa][Bb][Il][Ee] [Ff][Ii][Ll][Ee] (.*).lua")}
            name_file = name_file[1]
            if name_file:match(".lan") then 
                keko_exe = io.popen("cd langs && ls"):read("*a")
                if keko_exe:match(name_file..".lua") then 
                    kekolangnew = dkeko:get("keko:lang:bot:"..bot_id) or "ar.lua"
                    if kekolangnew ~= name_file..".lua" then 
                        keko.send_text(msg.chat_id,Tkeko.isunaddfile,msg.id ,"m")
                    else 
                        if keko2:match("Tkeko") then
                            dkeko:del("keko:lang:bot:"..bot_id,name_file..".lua")
                            keko.send_text(msg.chat_id,Tkeko.unaddfilelang,msg.id ,"m")
                        else
                            keko.send_text(msg.chat_id,Tkeko.filenot,msg.id ,"m")
                        end 
                    end
                else 
                    keko.send_text(msg.chat_id,Tkeko.notokDellang,msg.id ,"m")
                end 
            else
                keko_exe = io.popen("cd files && ls"):read("*a")
                if keko_exe:match(name_file..".lua") then 
                    if not dkeko:sismember("keko:files:"..bot_id, name_file..".lua") then 
                        keko.send_text(msg.chat_id,Tkeko.isunaddfile,msg.id ,"m")
                    else
                        dkeko:srem("keko:files:"..bot_id, name_file..".lua")
                        keko.send_text(msg.chat_id,Tkeko.unaddfileonf,msg.id ,"m")
                    end 
                else 
                    keko.send_text(msg.chat_id,Tkeko.notokDelfile,msg.id ,"m")
                end 
            end 
            Update_files_KEKO()
        end 
        if text and (text == "روابط الكروبات" or text:match("^[Ll][iI][Nn][Kk][Ss] [Gg][Rr][Oo][Uu][Pp][Ss]$") or text:match("^[Ll][iI][Nn][Kk][Ss] [Gg][Rr][Oo][Uu][Pp][Ss]$")) then 
            keko0 = ""
            all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0
            for i=1,#all do 
                if dkeko:get("keko:link:gr"..bot_id..all[i]) then 
                    keko0 = keko0..i.." ~> ["..all[i].."]("..dkeko:get("keko:link:gr"..bot_id..all[i])..")\n"
                end 
            end 
            keko.send_text(msg.chat_id, keko0,msg.id ,"m")
        end 
        if (text == "عدد الخاص" or text == "المشتركين" or text:match("^[Aa][Ll][Ll] [Uu][Ss][Ee][Rr][Ss]$") or text:match("^[Aa][Ll][Ll] [Uu][Ss][Ee][Rr]$") or text:match("^[Uu][Ss][Ee][Rr][Ss]$") or text == "عدد الكروبات" or text == "الكروبات" or text:match("^[Aa][Ll][Ll] [Gg][Rr][Oo][Uu][Pp][Ss]$") or text:match("^[Aa][Ll][Ll] [Gg][Rr][Oo][Uu][Pp]$") or text:match("^[Gg][Rr][Oo][Uu][Pp][Ss]$")) then 
            all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0
            gr_add = dkeko:smembers("keko:all:gr:"..bot_id) or 0
            users = dkeko:smembers("keko:all:user:"..bot_id) or 0
            keko.send_text(msg.chat_id, Tkeko.all_gr .. "{ " ..#all .." }\n" .. Tkeko.all_add_gr .. "{ " .. #gr_add .. " }\n" .. Tkeko.all_gr_not_add .. "{ " .. #all-#gr_add.. " } \n\n"..Tkeko.users.." { "..#users.." } ",msg.id ,"m")
        end
        kekoststus = "all"  
        text2 = text
        if (text:match("^[bB][cC] [Uu][Ss][Ee][Rr][Ss]$") or text == "اذاعه خاص") then 
            kekoststus = "users"
            text2 = "bc"
            text2 = text2:gsub(' خاص','') 
        elseif (text:match("^[bB][cC] [Gg][Rr][Oo][Uu][Pp][Ss]$") or text == "اذاعه للكروبات") then 
            kekoststus = "group"
            text2 = "bc" 
            text2 = text2:gsub(' للكروبات','') 
        elseif (text:match("^[bB][cC] [Pp][Ii][Nn]$") or text == "اذاعه بالتثبيت") then 
            kekoststus = "pin"
            text2 = "bc" 
            text2 = text2:gsub(' بالتثبيت','') 
        end 
        function keko_pin( t1,t2 )
            if t2.chat_id then
                t2.chat_id = tostring(t2.chat_id)
            end
            if t2.id and t2.chat_id and t2.chat_id:match("-") then 
                keko.pin(t2.chat_id,(tonumber(t2.id) + 1048567))
            end 
        end
        if (text2 == "اذاعه" or text2:match("^[bB][cC]$")) and msg.reply_to_message_id ~= 0 then 
            keko_all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0
            users = dkeko:smembers("keko:all:user:"..bot_id) or 0
            textrKEKO = Tkeko.dc 
            function keko_get_msg(t1,t2)
                if t2.content then 
                    if t2.content.text then 
                        if kekoststus == "all" or kekoststus == "group" then 
                            for i=1,#keko_all do 
                                keko.send_text(keko_all[i],t2.content.text,0,"keko")
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then 
                            for i=1,#users do 
                                keko.send_text(users[i],t2.content.text,0,"keko")
                            end
                        end
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                keko.send_text(keko_all[i],t2.content.text,0,"keko",keko_pin)
                            end 
                        end
                    elseif (t2.content.document) then 
                        if kekoststus == "all" or kekoststus == "group" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.document.document.id, t2.content.caption,0)
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then 
                            for i=1,#users do 
                                send_document(users[i], t2.content.document.document.id, t2.content.caption,0)
                            end
                        end
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.document.document.id, t2.content.caption,0,keko_pin)
                            end 
                        end
                    elseif (t2.content.sticker) then 
                        if kekoststus == "all" or kekoststus == "group" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.sticker.sticker.id, "", 0)
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then 
                            for i=1,#users do 
                                send_document(users[i], t2.content.sticker.sticker.id,"",0)
                            end 
                        end
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.sticker.sticker.id,"",0,keko_pin)
                            end 
                        end
                    elseif (t2.content.voice) then 
                        if kekoststus == "all" or kekoststus == "group" then 
                            for i=1,#keko_all do 
                                send_voice(keko_all[i], t2.content.voice.voice.id, t2.content.caption,t2.content.voice.duration,t2.content.voice.waveform, 0)
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then 
                            for i=1,#users do 
                                send_voice(users[i], t2.content.voice.voice.id, t2.content.caption,t2.content.voice.duration,t2.content.voice.waveform, 0)
                            end 
                        end 
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                send_voice(keko_all[i], t2.content.voice.voice.id, t2.content.caption,t2.content.voice.duration,t2.content.voice.waveform, 0,keko_pin)
                            end 
                        end
                    elseif (t2.content.video) then 
                        if kekoststus == "all" or kekoststus == "group" then 
                            for i=1,#keko_all do 
                                send_Video(keko_all[i], t2.content.video.video.id, t2.content.caption, 0)
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then
                            for i=1,#users do 
                                send_Video(users[i], t2.content.video.video.id, t2.content.caption, 0)
                            end 
                        end
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                send_Video(keko_all[i], t2.content.video.video.id, t2.content.caption, 0,keko_pin)
                            end 
                        end
                    elseif (t2.content.audio) then 
                        if kekoststus == "all" or kekoststus == "group" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.audio.audio.id, t2.content.caption,0)
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then
                            for i=1,#users do 
                                send_document(users[i], t2.content.audio.audio.id, t2.content.caption,0)
                            end 
                        end
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.audio.audio.id, t2.content.caption,0,keko_pin)
                            end 
                        end
                    elseif (t2.content.animation) then 
                        if kekoststus == "all" or kekoststus == "group" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.animation.animation.id, t2.content.caption, 0)
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then
                            for i=1,#users do 
                                send_document(users[i], t2.content.animation.animation.id, t2.content.caption, 0)
                            end 
                        end
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                send_document(keko_all[i], t2.content.animation.animation.id, t2.content.caption,0,keko_pin)--
                            end 
                        end
                    elseif (t2.content.photo) then 
                        if kekoststus == "all" or kekoststus == "group" then
                            for i=1,#keko_all do 
                                send_photo(keko_all[i],t2.content.photo.sizes[#t2.content.photo.sizes].photo.id, t2.content.caption, 0)
                            end 
                        end
                        if kekoststus == "all" or kekoststus == "users" then
                            for i=1,#users do 
                                send_photo(users[i],t2.content.photo.sizes[#t2.content.photo.sizes].photo.id, t2.content.caption, 0)
                            end 
                        end
                        if kekoststus == "pin" then 
                            for i=1,#keko_all do 
                                send_photo(keko_all[i],t2.content.photo.sizes[#t2.content.photo.sizes].photo.id, t2.content.caption, 0,keko_pin)
                            end 
                        end
                    else 
                        textrKEKO = Tkeko.erroru
                    end 
                else
                    textrKEKO = Tkeko.erroru
                end 
                msg3 = msg msg3.id = msg.reply_to_message_id
                keko.send_msg_and_info_sender(msg3,textrKEKO)
            end
            keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
        end
        if (text == "اذاعه توجيه" or text:match("^[Bb][cC][Ff][Ww][Dd]$")) and msg.reply_to_message_id ~= 0 then 
            keko_all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0
            users = dkeko:smembers("keko:all:user:"..bot_id) or 0
            for i=1,#keko_all do 
                forward_msg(keko_all[i],msg.chat_id, msg.reply_to_message_id)
            end 
            for i=1,#users do 
                forward_msg(users[i],msg.chat_id, msg.reply_to_message_id)
            end 
            msg3 = msg msg3.id = msg.reply_to_message_id
            keko.send_msg_and_info_sender(msg3,Tkeko.dcfwd)
        end
        if text == "المطورين" or text == "قائمه المطورين" or text:match("^[Ll][Ii][Ss][Tt] [Ss][Uu][Dd][Oo]$") or text:match("^[Ll][Ii][Ss][Tt] [Ss][Uu][Dd][Oo][Ss]$") or text:match("^[Ss][Uu][Dd][Oo][Ss]$") then 
            list_sudo = dkeko:smembers("keko:sudo:"..bot_id)
            if list_sudo and list_sudo[1] then 
                list_keko = Tkeko.sudolist.."\n"
                for i=1,#list_sudo do
                    username = dkeko:get("keko:username:user:"..list_sudo[i]) or list_sudo[i]
                    list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_sudo[i]..")}"
                end
                keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.notsudo,msg.id,"keko")
            end 
        end 
        if text == "مسح المطورين" or text == "مسح قائمه المطورين" or text:match("^[Dd][Ee][Ll][Ll][Ii][Ss][Tt] [Ss][Uu][Dd][Oo]$") or text:match("^[Dd][Ee][Ll][Ll][Ii][Ss][Tt] [Ss][Uu][Dd][Oo][Ss]$") or text:match("^[Dd][Ee][Ll][Ss][Uu][Dd][Oo][Ss]$") then 
            list_sudo = dkeko:smembers("keko:sudo:"..bot_id)
            if list_sudo and list_sudo[1] then 
                dkeko:del("keko:sudo:"..bot_id)
                keko.send_text(msg.chat_id, Tkeko.del_list_sudo,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.notsudo,msg.id,"keko")
            end 
        end 
        text2 = text  text2 = text:gsub('رفع مطور','set sudo')
        if (text2:match("[Ss][Ee][Tt] [Ss][Uu][Dd][Oo]")) then
            if (text2:match("^[Ss][Ee][Tt] [Ss][Uu][Dd][Oo]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         if dkeko:sismember("keko:sudo:"..bot_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.issudo )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.tosudo )
                            dkeko:sadd("keko:sudo:"..bot_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Ss][Ee][Tt] [Ss][Uu][Dd][Oo] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [Ss][Uu][Dd][Oo] (%d+)")}
                id_user_keko = id_user_keko[1]
                if dkeko:sismember("keko:sudo:"..bot_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.issudo )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.tosudo )
                    dkeko:sadd("keko:sudo:"..bot_id,id_user_keko)
                 end
            elseif (text2:match("^[Ss][Ee][Tt] [Ss][Uu][Dd][Oo] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [Ss][Uu][Dd][Oo] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if dkeko:sismember("keko:sudo:"..bot_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.issudo,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.tosudo,msg.id,"keko")
                            dkeko:sadd("keko:sudo:"..bot_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end

        text2 = text  text2 = text:gsub('تنزيل مطور','del sudo')
        if (text2:match("[Dd][Ee][Ll] [Ss][Uu][Dd][Oo]")) then
            if (text2:match("^[Dd][Ee][Ll] [Ss][Uu][Dd][Oo]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         if not dkeko:sismember("keko:sudo:"..bot_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isunsudo )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.tounsudo )
                            dkeko:srem("keko:sudo:"..bot_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Dd][Ee][Ll] [Ss][Uu][Dd][Oo] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [Ss][Uu][Dd][Oo] (%d+)")}
                id_user_keko = id_user_keko[1]
                if not dkeko:sismember("keko:sudo:"..bot_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isunsudo )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.tounsudo )
                    dkeko:srem("keko:sudo:"..bot_id,id_user_keko)
                 end
            elseif (text2:match("^[Dd][Ee][Ll] [Ss][Uu][Dd][Oo] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [Ss][Uu][Dd][Oo] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if not dkeko:sismember("keko:sudo:"..bot_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isunsudo,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.tounsudo,msg.id,"keko")
                            dkeko:srem("keko:sudo:"..bot_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end

        if text == "المحظورين عام" or text == "قائمه المحظورين عام" or text:match("^[Ll][Ii][Ss][Tt] [bB][Aa][Nn] [Aa][Ll][Ll]$") or text:match("^[Ll][Ii][Ss][Tt] [bB][Aa][Nn][Ss] [Aa][Ll][Ll]$") then 
            list_ban_all = dkeko:smembers("keko:ban_all:"..bot_id)
            if list_ban_all and list_ban_all[1] then 
                list_keko = Tkeko.ban_alllist.."\n"
                for i=1,#list_ban_all do
                    username = dkeko:get("keko:username:user:"..list_ban_all[i]) or list_ban_all[i]
                    list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_ban_all[i]..")}" 
                end
                keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.notban_all,msg.id,"keko")
            end 
        end 
        if text == "مسح المحظورين عام" or text == "مسح قائمه المحظورين عام" or text == "مسح العام" or text == "مسح قائمه العام" or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [bB][Aa][Nn] [Aa][Ll][Ll]$") or text:match("^[Dd][Ee][Ll][Ll][Ii][Ss][Tt] [bB][Aa][Nn] [Aa][Ll][Ll]$") or text:match("^[Dd][Ee][Ll][bB][Aa][Nn] [Aa][Ll][Ll]$") then 
            list_ban_all = dkeko:smembers("keko:ban_all:"..bot_id)
            if list_ban_all and list_ban_all[1] then 
                dkeko:del("keko:ban_all:"..bot_id)
                keko.send_text(msg.chat_id, Tkeko.del_list_ban_all,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.notban_all,msg.id,"keko")
            end 
        end 
        text2 = text  text2 = text2:gsub('حظر عام','ban all') 
        if (text2:match("[bB][Aa][Nn] [Aa][Ll][Ll]")) then
            if (text2:match("^[bB][Aa][Nn] [Aa][Ll][Ll]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         msg2 = msg msg2["sender_user_id"] = t2.sender_user_id
                         if is_sudo(msg2) then 
                            send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                            return "keko"
                         end
                         if dkeko:sismember("keko:ban_all:"..bot_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isban_all )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.toban_all )
                            dkeko:sadd("keko:ban_all:"..bot_id,id_user_keko)
                            keko.kick(msg.chat_id, id_user_keko)
                            keko_all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0 
                            for i=1,#keko_all do 
                                keko.kick(keko_all[i], id_user_keko)
                            end 
                        end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[bB][Aa][Nn] [Aa][Ll][Ll] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[bB][Aa][Nn] [Aa][Ll][Ll] (%d+)")}
                id_user_keko = id_user_keko[1]
                msg2 = msg msg2["sender_user_id"] = id_user_keko
                if is_sudo(msg2) then 
                   send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                   return "keko"
                end
                if dkeko:sismember("keko:ban_all:"..bot_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isban_all )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.toban_all )
                    dkeko:sadd("keko:ban_all:"..bot_id,id_user_keko)
                    keko.kick(msg.chat_id, id_user_keko)
                    keko_all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0 
                    for i=1,#keko_all do 
                        keko.kick(keko_all[i], id_user_keko)
                    end 
                 end
            elseif (text2:match("^[bB][Aa][Nn] [Aa][Ll][Ll] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[bB][Aa][Nn] [Aa][Ll][Ll] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        msg2 = msg msg2["sender_user_id"] = t2.id
                        if is_sudo(msg2) then 
                           send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                           return "keko"
                        end
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if dkeko:sismember("keko:ban_all:"..bot_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isban_all,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.toban_all,msg.id,"keko")
                            dkeko:sadd("keko:ban_all:"..bot_id,t2.id)
                            keko.kick(msg.chat_id, t2.id)
                            keko_all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0 
                            for i=1,#keko_all do 
                                keko.kick(keko_all[i], t2.id)
                            end 
                        end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end

        text2 = text  text2 = text:gsub('الغاء حظر عام','del ban all')
        if (text2:match("[Dd][Ee][Ll] [bB][Aa][Nn] [Aa][Ll][Ll]")) then
            if (text2:match("^[Dd][Ee][Ll] [bB][Aa][Nn] [Aa][Ll][Ll]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         if not dkeko:sismember("keko:ban_all:"..bot_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isunban_all )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.tounban_all )
                            dkeko:srem("keko:ban_all:"..bot_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Dd][Ee][Ll] [bB][Aa][Nn] [Aa][Ll][Ll] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [bB][Aa][Nn] [Aa][Ll][Ll] (%d+)")}
                id_user_keko = id_user_keko[1]
                if not dkeko:sismember("keko:ban_all:"..bot_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isunban_all )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.tounban_all )
                    dkeko:srem("keko:ban_all:"..bot_id,id_user_keko)
                 end
            elseif (text2:match("^[Dd][Ee][Ll] [bB][Aa][Nn] [Aa][Ll][Ll] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [bB][Aa][Nn] [Aa][Ll][Ll] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if not dkeko:sismember("keko:ban_all:"..bot_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isunban_all,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.tounban_all,msg.id,"keko")
                            dkeko:srem("keko:ban_all:"..bot_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end

    end -- if text 
end 
------------------------------------------------------------------

function fun_sudo(data)
     msg = data.message
     text = msg.content.text or false 
     if text then -- if sudo send msg text 
        if text == "مغادره" or text:match("^[Ll][Ee][Aa][Vv][Ee]") then 
            keko.send_text(msg.chat_id,(Tkeko.leave or "ok Leave"),msg.id,"keko")
            function keko_linfk( t1,t2 )
                for i=1,#sudos do  
                    send_text(sudos[i],(Tkeko.donelift or "تم مغارده المجموعه : ").."["..t2.title.."]\n"..(Tkeko.grid or "🔆┋ID group :").." {"..msg.chat_id.."}\n\n"..Tkeko.candeld, 0,"keko")
                end             
            end
            keko.getChat(msg.chat_id,keko_linfk)
            keko.kick(msg.chat_id,bot_id)
        end 
        if text == "م4" or text== "م٤" or text:match("^[Hh][٤4]") then 
            keko.send_text(msg.chat_id,Tkeko.h4,msg.id ,"m")
        end 
        text2 = text  text2 = text:gsub('اضف رد عام','add reply all')
        if (text2:match("^[Aa][Dd][Dd] [Rr][Ee][Pp][Ll][Yy] [Aa][Ll][Ll] (.*)") and msg.reply_to_message_id ~= 0) then 
            t = {string.match(text2, "[Aa][Dd][Dd] [Rr][Ee][Pp][Ll][Yy] [Aa][Ll][Ll] (.*)")}
            t = t[1]
            textrKEKO = Tkeko.okaddreply 
            function keko_get_msg(t1,t2)
                if t2.content then 
                    if t2.content.text then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"text:"..t2.content.text)
                    elseif (t2.content.document) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"document:"..t2.content.document.document.persistent_id)
                    elseif (t2.content.sticker) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"sticker:"..t2.content.sticker.sticker.persistent_id)
                    elseif (t2.content.voice) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"voice:"..t2.content.voice.voice.persistent_id)
                    elseif (t2.content.video_note) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"video_note:"..t2.content.video_note.video.persistent_id)
                    elseif (t2.content.video) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"video:"..t2.content.video.video.persistent_id)
                    elseif (t2.content.audio) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"audio:"..t2.content.audio.audio.persistent_id)
                    elseif (t2.content.animation) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"animation:"..t2.content.animation.animation.persistent_id) 
                    elseif (t2.content.photo) then 
                        dkeko:set("keko:reply:gr:"..bot_id..t,"photo:"..t2.content.photo.sizes[#t2.content.photo.sizes].photo.persistent_id) 
                    else 
                        textrKEKO = Tkeko.erroru
                    end 
                else
                    textrKEKO = Tkeko.erroru
                end 
                if textrKEKO ~= Tkeko.erroru then 
                    dkeko:sadd("keko:reply:all:gr:"..bot_id,t)
                end 
                msg3 = msg msg3.id = msg.reply_to_message_id
                keko.send_msg_and_info_sender(msg3,textrKEKO)
            end
            keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
        end     
        text2 = text  text2 = text:gsub('حذف رد عام','del reply all') text2 = text:gsub('مسح رد عام','del reply all')
        if (text2:match("^[Dd][Ee][Ll] [Rr][Ee][Pp][Ll][Yy] [Aa][Ll][Ll] (.*)")) then 
            t = {string.match(text2, "^[Dd][Ee][Ll] [Rr][Ee][Pp][Ll][Yy] [Aa][Ll][Ll] (.*)")}
            t = t[1]       
            if dkeko:sismember("keko:reply:all:gr:"..bot_id,t) then 
                keko.send_msg_and_info_sender(msg,Tkeko.delreply)
                dkeko:del("keko:reply:gr:"..bot_id..t)
                dkeko:srem("keko:reply:all:gr:"..bot_id,t)
            else
                keko.send_msg_and_info_sender(msg,Tkeko.notreply)
            end 
        end     
        if text == "الردود العامه" or text == "قائمه الردود العامه" or text == "ردود العامه" or text:match("^[Rr][Ee][Pp][Ll][Yy][Ss] [Aa][Ll][Ll]$") or text:match("^[LL][Ii][Ss][Tt] [Rr][Ee][Pp][Ll][Yy][Ss] [Aa][Ll][Ll]$") then 
            keko90 = Tkeko.listreplyall.."\n\n"
            keko_replay = dkeko:smembers("keko:reply:all:gr:"..bot_id)
            if keko_replay and keko_replay[1] then     
                for i=1,#keko_replay do 
                        kekoio = dkeko:get("keko:reply:gr:"..bot_id..msg.chat_id..keko_replay[i])
                    if kekoio then 
                        t = {string.match(kekoio, "^(.*):(.*)")}
                        t[1] = t[1]:gsub("animation",'Gif')
                        t[1] = t[1]:gsub("text",t[2])
                        keko90 = keko90 .. i .." ~> "..keko_replay[i] .. " { "..t[1].." }\n"                   
                    end
                end 
                keko.send_text(msg.chat_id,keko90,msg.id,"keko")
            else
                keko.send_msg_and_info_sender(msg,Tkeko.notlistreply)
            end 
        end 
        if text == "مسح الردود العامه" or text == "مسح قائمه الردود العامه" or text:match("^[Dd][Ee][Ll] [Rr][Ee][Pp][Ll][Yy][Ss] [Aa][Ll][Ll]$") or text:match("^[Dd][Ee][Ll] [LL][Ii][Ss][Tt] [Rr][Ee][Pp][Ll][Yy][Ss] [Aa][Ll][Ll]$") then 
            keko_replay = dkeko:smembers("keko:reply:all:gr:"..bot_id)
            if keko_replay and keko_replay[1] then     
                for i=1,#keko_replay do 
                    dkeko:del("keko:reply:gr:"..bot_id..keko_replay[i])
                end 
                dkeko:del("keko:reply:all:gr:"..bot_id)
                keko.send_text(msg.chat_id,Tkeko.dellistreplyall,msg.id,"keko")
            else
                keko.send_msg_and_info_sender(msg,Tkeko.notlistreplyall)
            end 
        end         
    end -- end if sudo send msg text 
end -- end fun_sudo
-------------------
function fun_creator( data )
    msg = data.message
    text = msg.content.text or false
    if text then 
        if text == "رفع الادمنيه" or text:match("^[Uu][pP][Ll][Oo][Aa][Dd] [Aa][Dd][Mm][Ii][Nn][Ss]$") then 
            function keko_get_mder( t1,t2 )
                if t2.total_count ~= 0 then 
                    for i=0,#t2.members do 
                         dkeko:sadd("keko:admins:"..bot_id..msg.chat_id,t2.members[i].user_id)
                    end 
                    keko.send_text(msg.chat_id,(Tkeko.toadminusers or "✔️┋تم رفع : ")..t2.total_count,msg.id ,"m")
                end 
            end
            tdbot_function ({
                _ = "getChannelMembers",
                channel_id = keko.getChatId(msg.chat_id)._,
                filter = {
                  _ = "channelMembersFilterAdministrators",
                  query = ""
                },
                offset = offset or 0,
                limit = 199
              }, keko_get_mder, nil)
        end 
        if text == "م3" or text== "م٣" or text:match("^[Hh][3٣]$") then 
            keko.send_text(msg.chat_id,Tkeko.h3,msg.id ,"m")
        end  
        if text == "تعطيل الالعاب" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [Gg][Aa][Mm][Ee][Ss]$") then 
            if not dkeko:get("keko:run:game:"..bot_id..msg.chat_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isstopgame)
            else 
                keko.send_msg_and_info_sender(msg,Tkeko.stopgame)
                dkeko:del("keko:run:game:"..bot_id..msg.chat_id)
            end    
        end 
        if text == "تفعيل الالعاب" or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee] [Gg][Aa][Mm][Ee][Ss]$") or text:match("^[Ee][nN][aA][bB][lL][Ee] [Gg][Aa][Mm][Ee][Ss]$") then 
            if dkeko:get("keko:run:game:"..bot_id..msg.chat_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isunstopgame)
            else 
                keko.send_msg_and_info_sender(msg,Tkeko.unstopgame)
                dkeko:set("keko:run:game:"..bot_id..msg.chat_id,true)
            end    
        end 
        if (text == "وضع صوره" or text == "تعين صوره" or text:match("^[cC][hH][aA][nN][gG][eE][Cc][hH][aA][Tt][Pp][hH][Oo][Tt][Oo]$")or text:match("^[cC][hH][aA][nN][gG][eE][Pp][hH][Oo][Tt][Oo]$")) and msg.reply_to_message_id ~= 0 then 
            textrKEKO = Tkeko.setphoto
            function keko_get_msg(t1,t2)
                if t2.content.photo then 
                    keko.changeChatPhoto(msg.chat_id,t2.content.photo.sizes[#t2.content.photo.sizes].photo.persistent_id)
                else
                    textrKEKO = Tkeko.erroru
                end 
                keko.send_msg_and_info_sender(msg,textrKEKO)
            end
            keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
        end
        text2 = text  text2 = text:gsub('تعين اسم البوت','set name bot') 
        if text2:match("^[sS][Ee][Tt] [Nn][Aa][Mm][Ee] [Bb][Oo][Tt] (.*)") then 
            return "keko"
        end 
        text2 = text  text2 = text2:gsub('وضع ترحيب','change Greating')  
        if (text2:match("^[cC][hH][aA][nN][gG][eE] [Gg][Rr][Ee][Aa][Tt][Ii][Nn][Gg] (.*)")) then 
            id_user_keko = {string.match(text2, "[cC][hH][aA][nN][gG][eE] [Gg][Rr][Ee][Aa][Tt][Ii][Nn][Gg] (.*)")}
            id_user_keko = id_user_keko[1]
            dkeko:set("keko:chat:greating:"..bot_id..msg.chat_id,id_user_keko)
            keko.send_msg_and_info_sender(msg,Tkeko.setchacccc)
            dkeko:set("keko:yes:greating:"..bot_id..msg.chat_id,true)
        end
        if text == "تفعيل الترحيب" or text:match("^[Ee][nN][aA][bB][lL][Ee] [Gg][Rr][Ee][Aa][Tt][Ii][Nn][Gg]$") then 
            if dkeko:get("keko:yes:greating:"..bot_id..msg.chat_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.setchaccccisyes)
            else
                keko.send_msg_and_info_sender(msg,Tkeko.setchaccccyes)
                dkeko:set("keko:yes:greating:"..bot_id..msg.chat_id,true)
            end 
        end 
        if text == "تعطيل الترحيب" or text:match("^[Ee][nN][aA][bB][lL][Ee] [dD][Ii][Ss][Aa][Bb][Il][Ee]$") then 
            if not dkeko:get("keko:yes:greating:"..bot_id..msg.chat_id) then 
                keko.send_msg_and_info_sender(msg,Tkeko.setchaccccisnoyes)
            else
                keko.send_msg_and_info_sender(msg,Tkeko.setchaccccnoyes)
                dkeko:del("keko:yes:greating:"..bot_id..msg.chat_id)
            end 
        end 
        text2 = text  text2 = text2:gsub('وضع اسم','change title')  text2 = text2:gsub('تعين اسم','change title')
        if (text2:match("^[cC][hH][aA][nN][gG][eE] [tT][iI][tT][Ll][Ee] (.*)")) then 
            id_user_keko = {string.match(text2, "[cC][hH][aA][nN][gG][eE] [tT][iI][tT][Ll][Ee] (.*)")}
            id_user_keko = id_user_keko[1]
            keko.changeChatTitle(msg.chat_id, id_user_keko)
            keko.send_msg_and_info_sender(msg,Tkeko.setchattitle)
        end
        text2 = text  text2 = text2:gsub('وضع وصف','change Description')  text2 = text2:gsub('تعين وصف','changechatDescription')
        if (text2:match("^[cC][hH][aA][nN][gG][eE] [Dd][eE][sS][cC][rR][iI][pP][tT][iI][Oo][Nn] (.*)")) then 
            id_user_keko = {string.match(text2, "[cC][hH][aA][nN][gG][eE] [Dd][eE][sS][cC][rR][iI][pP][tT][iI][Oo][Nn] (.*)")}
            id_user_keko = id_user_keko[1]
            keko.changeDescription(msg.chat_id, id_user_keko)
            keko.send_msg_and_info_sender(msg,Tkeko.changeDescription)
        end
        text2 = text  text2 = text2:gsub('تنظيف','clean')  
        if (text2:match("^[cC][lL][eE][Aa][Nn] (%d+)")) then 
            id_user_keko = {string.match(text2, "[cC][lL][eE][Aa][Nn] (%d+)")}
            id_user_keko = id_user_keko[1]
            if tonumber(id_user_keko) > 1001 then 
                keko.send_msg_and_info_sender(msg,Tkeko.notclean)
                return "keko"    
            end 
            kekopp = 1048576
            msg_keko_new = tonumber(msg.id)
            for i=1,tonumber(id_user_keko) do
                if msg_keko_new > 0 then  
                tdbot_function ({
                    _ = "deleteMessages",
                    chat_id = msg.chat_id,
                    message_ids = {[0] = msg_keko_new}
                }, cd or dl_cb, nil)
                msg_keko_new = msg_keko_new-kekopp
                end 
            end 
            keko.send_msg_and_info_sender(msg,Tkeko.clean..id_user_keko)
        end
        if text == "الادمنيه" or text == "قائمه الادمنيه" or text:match("^[Ll][Ii][Ss][Tt] [Aa][Dd][Mm][Ii][Nn]$") or text:match("^[Ll][Ii][Ss][Tt] [Aa][Dd][Mm][Ii][Nn][Ss]$") or text:match("^[Aa][Dd][Mm][iI][Nn][Ss]$") then 
            list_mute = dkeko:smembers("keko:admins:"..bot_id..msg.chat_id)
            if list_mute and list_mute[1] then 
                list_keko = Tkeko.adminlist.."\n"
                for i=1,#list_mute do
                    username = dkeko:get("keko:username:user:"..list_mute[i]) or list_mute[i]
                    list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_mute[i]..")}" 
                end
                keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.isdeleteadmin,msg.id,"keko")
            end 
        end 
        if text == "مسح الادمنيه" or text == "مسح قائمه الادمنيه" or text:match("^[Dd][Ee][Ll][Ll][Ii][Ss][Tt] [Aa][Dd][Mm][Ii][Nn]$") or text:match("^[Dd][Ee][Ll][Ll][Ii][Ss][Tt] [Aa][Dd][Mm][Ii][Nn][Ss]$") or text:match("^[Dd][Ee][Ll][Aa][Dd][Mm][iI][Nn][Ss]$") then 
            list_admin = dkeko:smembers("keko:admins:"..bot_id..msg.chat_id)
            if list_admin and list_admin[1] then 
                for i=1,#list_admin do 
                    keko.unpromote_user(msg.chat_id,list_admin[i])
                end 
                dkeko:del("keko:admins:"..bot_id..msg.chat_id)
                keko.send_text(msg.chat_id, Tkeko.deleteadmin,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.isdeleteadmin,msg.id,"keko")
            end 
        end 
        text2 = text:gsub('الاعضاء ','')
        if text2 == "المميزين" or text2 == "قائمه المميزين" or text:match("^[Ll][Ii][Ss][Tt] [Vv][Ii][Pp]$") or text:match("^[Ll][Ii][Ss][Tt] [Vv][Ii][Pp][Ss]$") or text:match("^[Vv][Ii][Pp][Ss]$") then 
            list_mute = dkeko:smembers("keko:vips:"..bot_id..msg.chat_id)
            if list_mute and list_mute[1] then 
                list_keko = Tkeko.viplist.."\n"
                for i=1,#list_mute do
                    username = dkeko:get("keko:username:user:"..list_mute[i]) or list_mute[i]
                    list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_mute[i]..")}" 
                end
                keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.isdeletevip,msg.id,"keko")
            end 
        end 
        if text2 == "مسح المميزين" or text2 == "مسح قائمه المميزين" or text:match("^[Dd][Ee][Ll][Ll][Ii][Ss][Tt] [Vv][Ii][Pp]$") or text:match("^[Dd][Ee][Ll][Ll][Ii][Ss][Tt] [Vv][Ii][Pp][Ss]$") or text:match("^[Dd][Ee][Ll][Vv][Ii][Pp][Ss]$") then 
            list_vip = dkeko:smembers("keko:vips:"..bot_id..msg.chat_id)
            if list_vip and list_vip[1] then 
                dkeko:del("keko:vips:"..bot_id..msg.chat_id)
                keko.send_text(msg.chat_id, Tkeko.deletevip,msg.id,"keko")
            else
                keko.send_text(msg.chat_id, Tkeko.isdeletevip,msg.id,"keko")
            end 
        end 
        text2 = text  text2 = text:gsub(' عضو ','') text2 = text2:gsub('رفع مميز','set vip') 
        if (text2:match("[Ss][Ee][Tt] [Vv][Ii][Pp]")) then
            if (text2:match("^[Ss][Ee][Tt] [Vv][Ii][Pp]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         if dkeko:sismember("keko:vips:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isvip )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.tovip )
                            dkeko:sadd("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Ss][Ee][Tt] [Vv][Ii][Pp] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [Vv][Ii][Pp] (%d+)")}
                id_user_keko = id_user_keko[1]
                if dkeko:sismember("keko:vips:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isvip )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.tovip )
                    dkeko:sadd("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                 end
            elseif (text2:match("^[Ss][Ee][Tt] [Vv][Ii][Pp] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [Vv][Ii][Pp] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if dkeko:sismember("keko:vips:"..bot_id..msg.chat_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isadmin,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.tovip,msg.id,"keko")
                            dkeko:sadd("keko:vips:"..bot_id..msg.chat_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end
        text2 = text  text2 = text:gsub(' عضو ','') text2 = text2:gsub('تنزيل مميز','del vip') 
        if (text2:match("[Dd][Ee][Ll] [Vv][Ii][Pp]")) then
            if (text2:match("^[Dd][Ee][Ll] [Vv][Ii][Pp]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         if not dkeko:sismember("keko:vips:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isunvip )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.tounvip )
                            dkeko:srem("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Dd][Ee][Ll] [Vv][Ii][Pp] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [Vv][Ii][Pp] (%d+)")}
                id_user_keko = id_user_keko[1]
                if not dkeko:sismember("keko:vips:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isunvip )
                 else 
                    if keko_on_gr then 
                        keko.unpromote_user(msg.chat_id,id_user_keko)
                    end 
                    send_msg_and_info( msg, id_user_keko, Tkeko.tounvip )
                    dkeko:srem("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                 end
            elseif (text2:match("^[Dd][Ee][Ll] [Vv][Ii][Pp] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [Vv][Ii][Pp] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if not dkeko:sismember("keko:vips:"..bot_id..msg.chat_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isunvip,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.tounvip,msg.id,"keko")
                            dkeko:srem("keko:vips:"..bot_id..msg.chat_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end



        text2 = text  text2 = text:gsub('رفع ادمن','set admin')
        keko_on_gr = false
        if (text2:match("بالكروب" ) or text2:match("[oO][Nn] [Gg][Rr][Oo][Uu][Pp]") or text2:match("[Gg][Rr][Oo][Uu][Pp]")) then
            keko_on_gr = true
            text2 = text2:gsub(' بالكروب','')
            text2 = text2:gsub(' on group','')
            text2 = text2:gsub(' group','')
        end 
        if (text2:match("[Ss][Ee][Tt] [Aa][dD][Mm][iI][Nn]")) then
            if (text2:match("^[Ss][Ee][Tt] [Aa][dD][Mm][iI][Nn]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         if keko_on_gr then 
                            keko.promote_user(msg.chat_id,id_user_keko)
                         end 
                         if dkeko:sismember("keko:admins:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isadmin )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.toadmin )
                            dkeko:sadd("keko:admins:"..bot_id..msg.chat_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Ss][Ee][Tt] [Aa][dD][Mm][iI][Nn] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [Aa][dD][Mm][iI][Nn] (%d+)")}
                id_user_keko = id_user_keko[1]
                if keko_on_gr then 
                    keko.promote_user(msg.chat_id,id_user_keko)
                end 
                if dkeko:sismember("keko:admins:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isadmin )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.toadmin )
                    dkeko:sadd("keko:admins:"..bot_id..msg.chat_id,id_user_keko)
                 end
            elseif (text2:match("^[Ss][Ee][Tt] [Aa][dD][Mm][iI][Nn] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [Aa][dD][Mm][iI][Nn] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if keko_on_gr then 
                            keko.promote_user(msg.chat_id,t2.id)
                        end 
                        if dkeko:sismember("keko:admins:"..bot_id..msg.chat_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isadmin,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.toadmin,msg.id,"keko")
                            dkeko:sadd("keko:admins:"..bot_id..msg.chat_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end
        text2 = text  text2 = text:gsub('تنزيل ادمن','del admin')
        keko_on_gr = false
        if (text2:match("بالكروب" ) or text2:match("[oO][Nn] [Gg][Rr][Oo][Uu][Pp]") or text2:match("[Gg][Rr][Oo][Uu][Pp]")) then
            keko_on_gr = true
            text2 = text2:gsub(' بالكروب','')
            text2 = text2:gsub(' on group','')
            text2 = text2:gsub(' group','')
        end 
        if (text2:match("[Dd][Ee][Ll] [Aa][dD][Mm][iI][Nn]")) then
            if (text2:match("^[Dd][Ee][Ll] [Aa][dD][Mm][iI][Nn]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         if keko_on_gr then 
                            keko.unpromote_user(msg.chat_id,id_user_keko)
                         end 
                         if not dkeko:sismember("keko:admins:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isunadmin )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.tounadmin )
                            dkeko:srem("keko:admins:"..bot_id..msg.chat_id,id_user_keko)
                            dkeko:srem("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Dd][Ee][Ll] [Aa][dD][Mm][iI][Nn] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [Aa][dD][Mm][iI][Nn] (%d+)")}
                id_user_keko = id_user_keko[1]
                if keko_on_gr then 
                    keko.unpromote_user(msg.chat_id,id_user_keko)
                end
                if not dkeko:sismember("keko:admins:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isunadmin )
                 else  
                    send_msg_and_info( msg, id_user_keko, Tkeko.tounadmin )
                    dkeko:srem("keko:admins:"..bot_id..msg.chat_id,id_user_keko)
                    dkeko:srem("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                 end
            elseif (text2:match("^[Dd][Ee][Ll] [Aa][dD][Mm][iI][Nn] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [Aa][dD][Mm][iI][Nn] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if keko_on_gr then 
                            keko.unpromote_user(msg.chat_id,t2.id)
                        end 
                        if not dkeko:sismember("keko:admins:"..bot_id..msg.chat_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isunadmin,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.tounadmin,msg.id,"keko")
                            dkeko:srem("keko:admins:"..bot_id..msg.chat_id,t2.id)
                            dkeko:srem("keko:vips:"..bot_id..msg.chat_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end

    end
end
function speed_lock( stats, y, msg )
    if stats == "lock" then 
        if dkeko:get("keko:lock:"..y..":"..msg..bot_id) and msg == chat_id_keko then   
            return "is"
        elseif (msg == chat_id_keko) then 
			dkeko:set("keko:lock:"..y..":"..msg..bot_id,true)
			return "ok"
		else 
		    if dkeko:get("keko:lock:"..y..":"..msg..bot_id) then 
                if dkeko:get("keko:open:user:"..y..":"..msg..bot_id) then 
                    dkeko:del("keko:open:user:"..y..":"..msg..bot_id)
                    dkeko:set("keko:lock:"..y..":"..msg..bot_id,true)
					return "ok"
                else
					return "is"
                end
		    else 
			    dkeko:del("keko:open:user:"..y..":"..msg..bot_id)
			    dkeko:set("keko:lock:"..y..":"..msg..bot_id,true)
                return "ok"
		    end
        end
    elseif( stats == "open") then 
        keko09 = 0
        if msg ~= chat_id_keko then 
            keko09 = msg
            if not dkeko:get("keko:lock:"..y..":"..msg..bot_id) then   
                if not dkeko:get("keko:lock:"..y..":"..chat_id_keko..bot_id) then 
                    return "is"
                else
                    dkeko:set("keko:open:user:"..y..":"..keko09..bot_id,true)
                end 
            else
                if not dkeko:get("keko:open:user:"..y..":"..keko09..bot_id) then 
					dkeko:set("keko:open:user:"..y..":"..keko09..bot_id,true)
					return "ok"
                else
					return "is"
                end
            end
        else
            if not dkeko:get("keko:lock:"..y..":"..msg..bot_id) then   
                return "is"
            else
                dkeko:del("keko:lock:"..y..":"..msg..bot_id)
                return "ok"
            end
        end 
    end
    return "no"
end
-- y_keko == lock 
function speed_lock2(stats,y,msg)
    if( stats == "get") then 
        if dkeko:get("keko:lock:"..y..":"..msg..bot_id) and tonumber(msg) == tonumber(chat_id_keko) then  
            return "y_keko"
        elseif (tonumber(msg) == tonumber(chat_id_keko)) then 
            return "n_keko"
		elseif (tonumber(msg) ~= tonumber(chat_id_keko)) then 
            keko09 = msg
            if dkeko:get("keko:lock:"..y..":"..chat_id_keko..bot_id) then 
                if not dkeko:get("keko:open:user:"..y..":"..keko09..bot_id) then 
                    return "y_keko"
                else 
                    return "n_keko"
                end 
            else 
                if dkeko:get("keko:lock:"..y..":"..keko09..bot_id) and not dkeko:get("keko:open:user:"..y..":"..keko09..bot_id) then 
                    return "y_keko"
                else 
                    return "n_keko"
                end  
            end 
        end 
    end
    return "y_keko"    
end

function fun_admin( data )
    msg = data.message
    text = msg.content.text or false
    if msg.content._ == "messageChatJoinByLink" then 
        dkeko:srem("keko:creators:"..bot_id..msg.chat_id,msg.sender_user_id)
        dkeko:srem("keko:admins:"..bot_id..msg.chat_id,msg.sender_user_id)
    end
    if text then 
        if text == "ايدي الكروب" or text:match("^[Ii][Dd] [Gg][Rr][Oo][Uu][Pp]$") then 
            keko.send_text(msg.chat_id,"`"..msg.chat_id.."`",msg.id ,"m")
        end 
        if text == "طرد البوتات" or text == "مسح البوتات" or text:match("^[Bb][Aa][Nn] [Bb][Oo][Tt][Ss]$") or text:match("^[Bb][Aa][Nn] [Aa][lL][Ll] [Bb][Oo][Tt]$") then 
            function keko_get_mder( t1,t2 )
                if t2.total_count == 0 or t2.total_count == 1 then 
                    keko.send_text(msg.chat_id,Tkeko.notbotsgr,msg.id ,"m")
                else 
                    for i=0,#t2.members do 
                        if t2.members[i].user_id ~= bot_id then 
                            keko.kick(msg.chat_id,t2.members[i].user_id)
                        end
                    end 
                    keko.send_text(msg.chat_id,Tkeko.botsban..t2.total_count,msg.id ,"m")
                end 
            end
            tdbot_function ({
                _ = "getChannelMembers",
                channel_id = keko.getChatId(msg.chat_id)._,
                filter = {
                  _ = "channelMembersFilterBots",
                  query = ""
                },
                offset = offset or 0,
                limit = 199
              }, keko_get_mder, nil)
        end 
        if text == "طرد الايرانين" or text == "مسح الايرانين" or text:match("^[Kk][iI][cC][Kk] [iI][Rr][Aa][Nn][iI][Aa][Nn][Ss]$") or text:match("^[Dd][Ee][Ll] [iI][Rr][Aa][Nn][iI][Aa][Nn][Ss]$") then 
            function keko_get_mder22( t1,t2 )
                if t2.total_count == 0 or t2.total_count == 1 then 
                    keko.send_text(msg.chat_id,Tkeko.notbotsgr,msg.id ,"m")
                else 
                    oi = 0 
                    for i=0,#t2.members do
                        t222 = t2
                        msg2 = msg
                        if not t2.members[i] then 
                            break
                        end 
                        msg2["sender_user_id"] = t2.members[i].user_id or 0
                        if not is_vip(msg2) then 
                            function chat_keko2( t1,t2 )
                                if t2.about then 
                                    if t2.about:match("@iran") or t2.about:match("محصولات") or t2.about:match("moodern_shopp") then 
                                        keko.kick(msg.chat_id, t222.members[i].user_id) 
                                        oi = oi + 1 
                                    end 
                                end 
                            end
                            tdbot_function ({
                                _ = "getUserFull",
                                user_id = t2.members[i].user_id
                            }, chat_keko2, nil)
                        end
                    end 
                    keko.send_text(msg.chat_id,Tkeko.banarr or "تم فحص 200 عضو وطرد الايرانين منهم",msg.id ,"m")
                    if offset_keko[msg.chat_id] and offset_keko[msg.chat_id] > t2.total_count then 
                        offset_keko[msg.chat_id] = 0
                    elseif (offset_keko[msg.chat_id]) then 
                        offset_keko[msg.chat_id] = offset_keko[msg.chat_id] + 200
                    else 
                        offset_keko[msg.chat_id] = 200
                    end 
                end 
            end
            tdbot_function ({
                _ = "getChannelMembers",
                channel_id = keko.getChatId(msg.chat_id)._,
                filter = {
                  _ = "channelMembersFilterRecent",
                  query = ""
                },
                offset = offset_keko[msg.chat_id] or 0,
                limit = 1000
              }, keko_get_mder22, nil)
         end  
         if text == "طرد الوهمين" or text == "مسح الوهمين" or text == "طرد الوهميين" or text == "مسح الوهميين" then 
            function keko_get_mder22( t1,t2 )
                if t2.total_count == 0 or t2.total_count == 1 then 
                    keko.send_text(msg.chat_id,Tkeko.notbotsgr,msg.id ,"m")
                else 
                    oi = 0 
                    for i=0,#t2.members do
                        t222 = t2
                        msg2 = msg
                        if not t2.members[i] then 
                            break
                        end
                        msg2["sender_user_id"] = t2.members[i].user_id
                        if not is_vip(msg2) then 
                            function chat_keko2( t1,t22 )
                                if not t22.about or t22.about == "" or t22.about == " " then 
                                    function keko_is_ssss( t1,t2 )
                                        if (not t2.username or t2.username == "") and not t2.profile_photo then 
                                            keko.kick(msg.chat_id, t2.id) 
                                        end 
                                    end
                                    keko.getChat(t2.members[i].user_id,keko_is_ssss)
                                end 
                            end
                            tdbot_function ({
                                _ = "getUserFull",
                                user_id = t2.members[i].user_id
                            }, chat_keko2, nil)
                        end
                    end 
                    keko.send_text(msg.chat_id,Tkeko.banarr2 or "تم فحص 200 عضو وطرد الوهميين منهم",msg.id ,"m")
                    if offset_keko[msg.chat_id] and offset_keko[msg.chat_id] > t2.total_count then 
                        offset_keko[msg.chat_id] = 0
                    elseif (offset_keko[msg.chat_id]) then 
                        offset_keko[msg.chat_id] = offset_keko[msg.chat_id] + 200
                    else 
                        offset_keko[msg.chat_id] = 200
                    end 
                end 
            end
            tdbot_function ({
                _ = "getChannelMembers",
                channel_id = keko.getChatId(msg.chat_id)._,
                filter = {
                  _ = "channelMembersFilterRecent",
                  query = ""
                },
                offset = offset_keko[msg.chat_id] or 0,
                limit = 1000
              }, keko_get_mder22, nil)
         end 
        if (text == "مسح" or text == "حذف" or text:match("^[dD][eE][Ll]$") or text:match("^[Dd][Ee][Ll][Ee][Tt][Ee]$")) and msg.reply_to_message_id ~= 0 then 
            tdbot_function ({
                _ = "deleteMessages",
                chat_id = msg.chat_id,
                message_ids = {[0] = msg.id,[1] = msg.reply_to_message_id}
            }, cd or dl_cb, nil)
        end
        if text == "الاوامر" or text:match("^[Hh][Ee][Ll][Pp]$") then 
            keko.send_text(msg.chat_id,Tkeko.help,msg.id ,"m")
        end 
        if text == "م2" or text== "م٢" or text:match("^[Hh][2٢]$") then 
            keko.send_text(msg.chat_id,Tkeko.h2,msg.id ,"m")
        end 
        if text == "م1" or text== "م١" or text:match("^[Hh][1١]$") then 
            keko.send_text(msg.chat_id,Tkeko.h1,msg.id ,"m")
        end 
        text2 = text  text2 = text:gsub('منع','ban text')
        if text2:match("^[bB][aA][Nn] [Tt][Ee][Xx][Tt] (.*)") and not text2:match(" (!) ") then 
            t = {string.match(text2, "[bB][aA][Nn] [Tt][Ee][Xx][Tt] (.*)")}
            t = t[1]
            if dkeko:sismember("keko:ban:text:gr:"..bot_id..msg.chat_id,t) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isbantext)
            else
                keko.send_msg_and_info_sender(msg,Tkeko.bantext..t)
                dkeko:sadd("keko:ban:text:gr:"..bot_id..msg.chat_id,t)
            end
        elseif (text2:match("^[bB][aA][Nn] [Tt][Ee][Xx][Tt] (.*) ! (.*)")) then 
            t = {string.match(text2, "[bB][aA][Nn] [Tt][Ee][Xx][Tt] (.*) ! (.*)")}
            t2 = t[2] or nil
            t = t[1]
            if dkeko:sismember("keko:ban:text:gr:"..bot_id..msg.chat_id,t) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isbantext)
            else
                if t2 then 
                    dkeko:set("keko:msg:ban:text:"..bot_id..msg.chat_id..t,t2)
                end 
                keko.send_msg_and_info_sender(msg,Tkeko.bantext..t)
                dkeko:sadd("keko:ban:text:gr:"..bot_id..msg.chat_id,t)
            end
        end 
        text2 = text  text2 = text:gsub('الغاء منع','unban text')
        if text2:match("^[Uu][Nn][bB][aA][Nn] [Tt][Ee][Xx][Tt] (.*)") then 
            t = {string.match(text2, "[Uu][Nn][bB][aA][Nn] [Tt][Ee][Xx][Tt] (.*)")}
            t = t[1]
            if not dkeko:sismember("keko:ban:text:gr:"..bot_id..msg.chat_id,t) then 
                keko.send_msg_and_info_sender(msg,Tkeko.isunbantext)
            else
                keko.send_msg_and_info_sender(msg,Tkeko.unbantext..t)
                dkeko:srem("keko:ban:text:gr:"..bot_id..msg.chat_id,t)
                dkeko:del("keko:msg:ban:text:"..bot_id..msg.chat_id..t)
            end 
        end 
        if text == "مسح قائمه المنع" or text == "حذف قائمه المنع" or text:match("^[Dd][Ee][lL] [Ll][Ii][Ss][Tt] [Bb][Aa][nN] [Tt][Ee][Xx][Tt]$") then 
            keko89 = dkeko:smembers("keko:ban:text:gr:"..bot_id..msg.chat_id)
            if keko89 and keko89[1] then 
                for i=1,#keko89 do 
                    dkeko:del("keko:msg:ban:text:"..bot_id..msg.chat_id..t)
                end    
                keko.send_msg_and_info_sender(msg,Tkeko.okdelbantext)
                dkeko:del("keko:ban:text:gr:"..bot_id..msg.chat_id)
            else 
                keko.send_msg_and_info_sender(msg,Tkeko.nobantext)
            end  
        end 
        if text == "قائمه المنع" or text:match("^[Ll][Ii][Ss][Tt] [Bb][Aa][nN] [Tt][Ee][Xx][Tt]$") then 
            keko89 = dkeko:smembers("keko:ban:text:gr:"..bot_id..msg.chat_id)
            if keko89 and keko89[1] then 
                keko8902 = Tkeko.listbanetext .. "\n\n"
                for i=1,#keko89 do 
                    if dkeko:get("keko:msg:ban:text:"..bot_id..msg.chat_id..keko89[i]) then
                        keko8902 = keko8902 ..i.." ~> "..keko89[i] .. " ( "..dkeko:get("keko:msg:ban:text:"..bot_id..msg.chat_id..keko89[i]).." )\n"
                    else 
                        keko8902 = keko8902 ..i.." ~> "..keko89[i] .. "\n"
                    end
                end 
                keko.send_text(msg.chat_id,keko8902,msg.id,"html")
            else 
                keko.send_msg_and_info_sender(msg,Tkeko.nobantext)
            end  
        end 
        text2 = text  text2 = text:gsub('قفل','lock')
        if text2:match("^[Ll][oO][cC][Kk] (.*)") and msg.reply_to_message_id == 0 then 
            t = {string.match(text2, "^[Ll][oO][cC][Kk] (.*)")}
            t = t[1]
            if (t == "الروابط" or t == "الرابط" or t == "روابط" or t == "link" or t == "links") then 
               if speed_lock("lock", "link", msg.chat_id ) == "is" then
                keko.send_msg_and_info_sender(msg,Tkeko.lock.islink)
               else 
                keko.send_msg_and_info_sender(msg,Tkeko.lock.link)
               end 
            elseif (t == "التوجية" or t == "توجيه" or t == "التوجيه" or t == "fwds" or t == "fwd") then 
               if speed_lock("lock", "fwd", msg.chat_id ) == "is" then
                keko.send_msg_and_info_sender(msg,Tkeko.lock.isfwd)
               else 
                keko.send_msg_and_info_sender(msg,Tkeko.lock.fwd)
               end 
            elseif (t == "الاستفتاء" or t == "التصويت" or t == "استفتاء" or t == "poll" or t == "polls") then 
                if speed_lock("lock", "poll", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.ispoll)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.poll)
                end 
            elseif (t == "الصور" or t == "صور" or t == "photos" or t == "photo") then
               if speed_lock("lock", "photo", msg.chat_id ) == "is" then
                keko.send_msg_and_info_sender(msg,Tkeko.lock.isphoto)
               else 
                keko.send_msg_and_info_sender(msg,Tkeko.lock.photo)
               end 
            elseif (t == "الفديو" or t == "فديو" or t == "videos" or t == "video") then
                if speed_lock("lock", "video", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isvideo)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.video)
                end 
            elseif (t == "المتحركه" or t == "المتحركة" or t == "gifs" or t == "gif") then
                if speed_lock("lock", "gif", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isgif)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.gif)
                end 
            elseif (t == "المعرفات" or t == "المعرف" or t == "usernames" or t == "username") then
                if speed_lock("lock", "username", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isusername)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.username)
                end
            elseif (t == "الانلاين" or t == "انلاين" or t == "inlines" or t == "inline") then
                if speed_lock("lock", "inlines", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isinline)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.inline)
                end
            elseif (t == "الماركدون" or t == "مارك" or t == "mark" or t == "markdown") then
                if speed_lock("lock", "markdown", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.ismarkdown)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.markdown)
                end
            elseif (t == "الاشعارات" or t == "شعارات" or t == "note" or t == "notes") then
                if speed_lock("lock", "note", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isnote)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.note)
                end
            elseif (t == "البوتات" or t == "بوتات" or t == "bots" or t == "bot") then
                if speed_lock("lock", "bots", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isbots)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.bots)
                end
            elseif (t == "الدردشه" or t == "المجموعه" or t == "chat" or t == "gruop") then
                if speed_lock("lock", "chat", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.ischat)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.chat)
                end
            elseif (t == "التكرار" or t == "تكرار" or t == "spam" or t == "spaming") then
                if speed_lock("lock", "spam", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isspam)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.spam)
                end  
            elseif (t == "الملصقات" or t == "ملصقات" or t == "stickers" or t == "sticker") then
                if speed_lock("lock", "sticker", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.issticker)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.sticker)
                end  
            elseif (t == "الملفات" or t == "ملفات" or t == "files" or t == "file") then
                if speed_lock("lock", "file", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isfile)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.file)
                end  
            elseif (t == "تعديل الميديا" or t == "edit media" or t == "Edit media") then
                if speed_lock("lock", "edit_media", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isedit_media)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.edit_media)
                end  
            elseif (t == "الدخول" or t == "دخول" or t == "join") then
                if speed_lock("lock", "join", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isjoin)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.join)
                end
            elseif (t == "الاغاني" or t == "البصمات" or t == "music" or t == "voice") then
                if speed_lock("lock", "music", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.ismusic)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.music)
                end 
            elseif (t == "الكلايش" or t == "كلايش" or t == "list" or t == "lists") then
                if speed_lock("lock", "list", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.islist)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.list)
                end 
            elseif (t == "الجهات" or t == "جهات" or t == "contact" or t == "contacts") then
                if speed_lock("lock", "contact", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.iscontact)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.contact)
                end 
            elseif (t == "التثبيت" or t == "pin") then
                if speed_lock("lock", "pin", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.ispin)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.pin)
                end 
            elseif (t == "الكل" or t == "all") then
                speed_lock("lock", "list", msg.chat_id )
                speed_lock("lock", "music", msg.chat_id )
                speed_lock("lock", "edit_media", msg.chat_id )
                speed_lock("lock", "sticker", msg.chat_id )
                speed_lock("lock", "spam", msg.chat_id )
                speed_lock("lock", "bots", msg.chat_id )
                speed_lock("lock", "note", msg.chat_id )
                speed_lock("lock", "inlines", msg.chat_id )
                speed_lock("lock", "markdown", msg.chat_id )
                speed_lock("lock", "photo", msg.chat_id )
                speed_lock("lock", "fwd", msg.chat_id )
                speed_lock("lock", "link", msg.chat_id )
                speed_lock("lock", "username", msg.chat_id )
                speed_lock("lock", "gif", msg.chat_id )
                speed_lock("lock", "video", msg.chat_id )
                speed_lock("lock", "contact", msg.chat_id )
                keko.send_msg_and_info_sender(msg,Tkeko.lock.all) 
            end
        end
        text2 = text  text2 = text:gsub('فتح','open') text2 = text2:gsub('unlock','open') text2 = text2:gsub('Unlock','open')
        if text2:match("^[Oo][pP][Ee][nN] (.*)") and msg.reply_to_message_id == 0 then 
            t = {string.match(text2, "^[Oo][pP][Ee][nN] (.*)")}
            t = t[1]
            if (t == "الروابط" or t == "الرابط" or t == "روابط" or t == "link" or t == "links") then 
               if speed_lock("open", "link", msg.chat_id ) == "is" then
                keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_link)
               else 
                keko.send_msg_and_info_sender(msg,Tkeko.lock.open_link)
               end 
            elseif (t == "التوجية" or t == "توجيه" or t == "التوجيه" or t == "fwds" or t == "fwd") then 
               if speed_lock("open", "fwd", msg.chat_id ) == "is" then
                keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_fwd)
               else 
                keko.send_msg_and_info_sender(msg,Tkeko.lock.open_fwd)
               end 
            elseif (t == "الاستفتاء" or t == "التصويت" or t == "استفتاء" or t == "poll" or t == "polls") then 
                if speed_lock("open", "poll", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_poll)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_poll)
                end 
            elseif (t == "الصور" or t == "صور" or t == "photos" or t == "photo") then
               if speed_lock("open", "photo", msg.chat_id ) == "is" then
                keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_photo)
               else 
                keko.send_msg_and_info_sender(msg,Tkeko.lock.open_photo)
               end 
            elseif (t == "الفديو" or t == "فديو" or t == "videos" or t == "video") then
                if speed_lock("open", "video", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_video)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_video)
                end 
            elseif (t == "المتحركه" or t == "المتحركة" or t == "gifs" or t == "gif") then
                if speed_lock("open", "gif", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_gif)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_gif)
                end 
            elseif (t == "المعرفات" or t == "المعرف" or t == "usernames" or t == "username") then
                if speed_lock("open", "username", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_username)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_username)
                end
            elseif (t == "الانلاين" or t == "انلاين" or t == "inlines" or t == "inline") then
                if speed_lock("open", "inlines", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_inline)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_inline)
                end
            elseif (t == "الدخول" or t == "دخول" or t == "join") then
                if speed_lock("open", "join", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_join)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_join)
                end
            elseif (t == "الماركدون" or t == "مارك" or t == "mark" or t == "markdown") then
                if speed_lock("open", "markdown", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_markdown)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_markdown)
                end
            elseif (t == "الاشعارات" or t == "شعارات" or t == "note" or t == "notes") then
                if speed_lock("open", "note", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_note)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_note)
                end
            elseif (t == "البوتات" or t == "بوتات" or t == "bots" or t == "bot") then
                if speed_lock("open", "bots", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_bots)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_bots)
                end
            elseif (t == "الدردشه" or t == "المجموعه" or t == "chat" or t == "gruop") then
                if speed_lock("open", "chat", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_chat)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_chat)
                end
            elseif (t == "التكرار" or t == "تكرار" or t == "spam" or t == "spaming") then
                if speed_lock("open", "spam", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_spam)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_spam)
                end  
            elseif (t == "الملصقات" or t == "ملصقات" or t == "stickers" or t == "sticker") then
                if speed_lock("open", "sticker", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_sticker)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_sticker)
                end  
            elseif (t == "تعديل الميديا" or t == "edit media" or t == "Edit media") then
                if speed_lock("open", "edit_media", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_edit_media)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_edit_media)
                end  
            elseif (t == "الملفات" or t == "ملفات" or t == "files" or t == "file") then
                if speed_lock("open", "file", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_file)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_file)
                end  
            elseif (t == "الاغاني" or t == "البصمات" or t == "music" or t == "voice") then
                if speed_lock("open", "music", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_music)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_music)
                end 
            elseif (t == "الكلايش" or t == "كلايش" or t == "list" or t == "lists") then
                if speed_lock("open", "list", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_list)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_list)
                end 
            elseif (t == "الجهات" or t == "جهات" or t == "contact" or t == "contacts") then
                if speed_lock("open", "contact", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_contact)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.opencontact)
                end 
            elseif (t == "التثبيت" or t == "pin") then
                if speed_lock("open", "pin", msg.chat_id ) == "is" then
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.isopen_pin)
                else 
                 keko.send_msg_and_info_sender(msg,Tkeko.lock.open_pin)
                end 
            elseif (t == "الكل" or t == "all") then
                speed_lock("open", "list", msg.chat_id )
                speed_lock("open", "contact", msg.chat_id )
                speed_lock("open", "music", msg.chat_id )
                speed_lock("open", "edit_media", msg.chat_id )
                speed_lock("open", "sticker", msg.chat_id )
                speed_lock("open", "photo", msg.chat_id )
                speed_lock("open", "spam", msg.chat_id )
                speed_lock("open", "bots", msg.chat_id )
                speed_lock("open", "note", msg.chat_id )
                speed_lock("open", "inlines", msg.chat_id )
                speed_lock("open", "markdown", msg.chat_id )
                speed_lock("open", "fwd", msg.chat_id )
                speed_lock("open", "link", msg.chat_id )
                speed_lock("open", "username", msg.chat_id )
                speed_lock("open", "gif", msg.chat_id )
                speed_lock("open", "video", msg.chat_id )
                keko.send_msg_and_info_sender(msg,Tkeko.lock.open_all)
            end
        end
    end
    ------------------------------------------------------------------------------
    if text then
    text2 = text  text2 = text2:gsub('اضف رد عام','add reply all')
    text2 = text2:gsub('اضف رد','add reply')
    if (text2:match("^[Aa][Dd][Dd] [Rr][Ee][Pp][Ll][Yy] (.*)") and msg.reply_to_message_id ~= 0 and (not text2:match("^[Aa][Dd][Dd] [Rr][Ee][Pp][Ll][Yy] [Aa][Ll][Ll] (.*)"))) then 
        t = {string.match(text2, "[Aa][Dd][Dd] [Rr][Ee][Pp][Ll][Yy] (.*)")}
        t = t[1]
        textrKEKO = Tkeko.okaddreply 
        function keko_get_msg(t1,t2)
            if t2.content then 
                if t2.content.text then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"text:"..t2.content.text)
                elseif (t2.content.document) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"document:"..t2.content.document.document.persistent_id)
                elseif (t2.content.sticker) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"sticker:"..t2.content.sticker.sticker.persistent_id)
                elseif (t2.content.voice) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"voice:"..t2.content.voice.voice.persistent_id)
                elseif (t2.content.video_note) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"video_note:"..t2.content.video_note.video.persistent_id)
                elseif (t2.content.video) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"video:"..t2.content.video.video.persistent_id)
                elseif (t2.content.audio) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"audio:"..t2.content.audio.audio.persistent_id)
                elseif (t2.content.animation) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"animation:"..t2.content.animation.animation.persistent_id) 
                elseif (t2.content.photo) then 
                    dkeko:set("keko:reply:gr:"..bot_id..msg.chat_id..t,"photo:"..t2.content.photo.sizes[#t2.content.photo.sizes].photo.persistent_id) 
                else 
                    textrKEKO = Tkeko.erroru
                end 
            else
                textrKEKO = Tkeko.erroru
            end 
            if textrKEKO ~= Tkeko.erroru then 
                dkeko:sadd("keko:reply:all:gr:"..bot_id..msg.chat_id,t)
            end 
            msg3 = msg msg3.id = msg.reply_to_message_id
            keko.send_msg_and_info_sender(msg3,textrKEKO)
        end
        keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
    end     
    text2 = text
    text2 = text2:gsub('مسح رد عام','del reply all')
    text2 = text2:gsub('حذف رد','del reply') text2 = text2:gsub('مسح رد','del reply')
    if (text2:match("^[Dd][Ee][Ll] [Rr][Ee][Pp][Ll][Yy] (.*)") and not text2:match("^[Dd][Ee][Ll] [Rr][Ee][Pp][Ll][Yy] [Aa][Ll][Ll] (.*)")) then 
        t = {string.match(text2, "^[Dd][Ee][Ll] [Rr][Ee][Pp][Ll][Yy] (.*)")}
        t = t[1]       
        if dkeko:sismember("keko:reply:all:gr:"..bot_id..msg.chat_id,t) then 
            keko.send_msg_and_info_sender(msg,Tkeko.delreply)
            dkeko:del("keko:reply:gr:"..bot_id..msg.chat_id..t)
            dkeko:srem("keko:reply:all:gr:"..bot_id..msg.chat_id,t)
        else
            keko.send_msg_and_info_sender(msg,Tkeko.notreply)
        end 
    end     
    if text == "الردود" or text == "قائمه الردود" or text == "ردود الكروب" or text == "ردود المنشئ" or text:match("^[Rr][Ee][Pp][Ll][Yy][Ss]$") or text:match("^[LL][Ii][Ss][Tt] [Rr][Ee][Pp][Ll][Yy][Ss]$") then 
        keko90 = Tkeko.listreply.."\n\n"
        keko_replay = dkeko:smembers("keko:reply:all:gr:"..bot_id..msg.chat_id)
        if keko_replay and keko_replay[1] then     
            for i=1,#keko_replay do 
                kekoio = dkeko:get("keko:reply:gr:"..bot_id..msg.chat_id..keko_replay[i])
                if kekoio then 
                    t = {string.match(kekoio, "^(.*):(.*)")}
                    t[1] = t[1]:gsub("animation",'Gif')
                    t[1] = t[1]:gsub("text",t[2])
                    keko90 = keko90 .. i .." ~> "..keko_replay[i] .. " { "..t[1].." }\n"                   
                end
            end 
            keko.send_text(msg.chat_id,keko90,msg.id,"keko")
        else
            keko.send_msg_and_info_sender(msg,Tkeko.notlistreply)
        end 
    end 
    if text == "مسح الردود" or text == "مسح قائمه الردود" or text == "مسح ردود الكروب" or text == "مسح ردود المنشئ" or text:match("^[Dd][Ee][Ll] [Rr][Ee][Pp][Ll][Yy][Ss]$") or text:match("^[Dd][Ee][Ll] [LL][Ii][Ss][Tt] [Rr][Ee][Pp][Ll][Yy][Ss]$") then 
        keko_replay = dkeko:smembers("keko:reply:all:gr:"..bot_id..msg.chat_id)
        if keko_replay and keko_replay[1] then     
            for i=1,#keko_replay do 
                dkeko:del("keko:reply:gr:"..bot_id..msg.chat_id..keko_replay[i])
            end 
            dkeko:del("keko:reply:all:gr:"..bot_id..msg.chat_id)
            keko.send_text(msg.chat_id,Tkeko.dellistreply,msg.id,"keko")
        else
            keko.send_msg_and_info_sender(msg,Tkeko.notlistreply)
        end 
    end 
    if text == "تعطيل الردود" or text == "تعطيل ردود الكروب" or text == "تعطيل ردود المنشئ" or text == "تعطيل ردود المطور" or text == "تعطيل ردود البوت" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [Rr][Ee][Pp][Ll][Yy][Ss]$") or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [Rr][Ee][Pp][Ll][Yy]$") then 
        rkkeo = dkeko:get("keko:stop:reply:gr:"..bot_id..msg.chat_id)
        if rkkeo then 
            keko.send_msg_and_info_sender(msg,Tkeko.repletstoped)
        else 
            keko.send_msg_and_info_sender(msg,Tkeko.repletstop)
            dkeko:set("keko:stop:reply:gr:"..bot_id..msg.chat_id,true)
        end 
    end
    if text == "تفعيل الردود" or text == "تفعيل ردود الكروب" or text == "تفعيل ردود المنشئ" or text == "تفعيل ردود المطور" or text == "تفعيل ردود البوت" or text:match("^[Ee][nN][aA][bB][lL][Ee] [Rr][Ee][Pp][Ll][Yy][Ss]$") or text:match("^[Ee][nN][aA][bB][lL][Ee] [Rr][Ee][Pp][Ll][Yy]$") then 
        rkkeo = dkeko:get("keko:stop:reply:gr:"..bot_id..msg.chat_id)
        if not rkkeo then 
            keko.send_msg_and_info_sender(msg,Tkeko.repletstarted)
        else 
            keko.send_msg_and_info_sender(msg,Tkeko.repletstart)
            dkeko:del("keko:stop:reply:gr:"..bot_id..msg.chat_id)
        end 
    end
    if text == "تعطيل الايدي" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [Ii][Dd]$") then 
        rkkeo = dkeko:get("keko:get:id:"..bot_id..msg.chat_id)
        if rkkeo then 
            keko.send_msg_and_info_sender(msg,Tkeko.idtstoped)
        else 
            keko.send_msg_and_info_sender(msg,Tkeko.idtstop)
            dkeko:set("keko:get:id:"..bot_id..msg.chat_id,true)
        end 
    end
    if text == "تفعيل الايدي" or text:match("^[Ee][nN][aA][bB][lL][Ee] [Ii][Dd]$") then 
        rkkeo = dkeko:get("keko:get:id:"..bot_id..msg.chat_id)
        if not rkkeo then 
            keko.send_msg_and_info_sender(msg,Tkeko.idtstarted)
        else 
            keko.send_msg_and_info_sender(msg,Tkeko.idstart)
            dkeko:del("keko:get:id:"..bot_id..msg.chat_id)
        end 
    end
    ------------------------------------------------------------------------------
    text2 = text  text2 = text2:gsub('الاعدادات','settings') 
    text2 = text2:gsub('اعدادات','settings')
    if (text2:match("^[sS][Ee][Tt][Tt][Ii][Nn][Gg][Ss]$") and msg.reply_to_message_id ~= 0) then
        function keko_get_msg(t1,t2)
            if t2.sender_user_id then
                 id_user_keko = t2.sender_user_id
                 msg2 = msg msg2["sender_user_id"] = t2.sender_user_id
                 if is_vip(msg2) then 
                    send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno)
                    return "keko"
                 end
                 keko_se = get_settings_keko(msg.chat_id, id_user_keko)
                 keko.send_text(msg.chat_id,keko_se,msg.id,"keko")
            end
        end
        keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
    elseif (text2:match("^[sS][Ee][Tt][Tt][Ii][Nn][Gg][Ss] (%d+)$")) then 
        id_user_keko = {string.match(text2, "[sS][Ee][Tt][Tt][Ii][Nn][Gg][Ss] (%d+)")}
        id_user_keko = id_user_keko[1]
        msg2 = msg msg2["sender_user_id"] = tonumber(id_user_keko)
        if is_vip(msg2) then 
           send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno)
           return "keko"
        end
        keko_se = get_settings_keko(msg.chat_id, id_user_keko)
        keko.send_text(msg.chat_id,keko_se,msg.id,"keko")
    elseif (text2:match("^[sS][Ee][Tt][Tt][Ii][Nn][Gg][Ss] @(.*)$")) then 
        id_user_keko = {string.match(text2, "[sS][Ee][Tt][Tt][Ii][Nn][Gg][Ss] @(.*)")}
        function keko_get_user(t1,t2)
            if t2.id then 
                msg2 = msg msg2["sender_user_id"] = t2.id
                if is_vip(msg2) then 
                   send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                   return "keko"
                end
                keko_se = get_settings_keko(msg.chat_id, t2.id)
                keko.send_text(msg.chat_id,keko_se,msg.id,"keko")
            else
                keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
            end
        end
        keko.get_info_username(id_user_keko[1],keko_get_user)
    elseif text == "الاعدادات" or text == "اعدادات المجموعه" or text:match("^[sS][Ee][Tt][Tt][Ii][Nn][Gg][Ss]$") then 
        keko_se = get_settings_keko(msg.chat_id,"")
        keko.send_text(msg.chat_id,keko_se,msg.id,"keko")
    end 
    ---------------------------------Lock User------------------------------------
    text2 = text  text2 = text2:gsub('قفل','lock')
        if (text2:match("^[lL][oO][cC][kK] (.*) @(.*)") or text2:match("^[lL][oO][cC][kK] (.*) (%d+)") or (text2:match("^[lL][oO][cC][kK] (.*)") and msg.reply_to_message_id ~= 0)) then
            text2 = text2:gsub('الروابط','link') text2 = text2:gsub('الاستفتاء','polls') text2 = text2:gsub('التصويت','polls') text2 = text2:gsub('الجهات','contact') text2 = text2:gsub('جهات','contact') text2 = text2:gsub('الكل','all')  text2 = text2:gsub('التوجيه','fwd') text2 = text2:gsub('الصور','photo') text2 = text2:gsub('الفديو','video') text2 = text2:gsub('المتحركه','gif') text2 = text2:gsub('المعرفات','username') text2 = text2:gsub('النلاين','inline') text2 = text2:gsub('ماركدون','markdown') text2 = text2:gsub('التكرار','spam') text2 = text2:gsub('الملصقات','sticker') text2 = text2:gsub('الملفات','file') text2 = text2:gsub('البوتات','bots') text2 = text2:gsub('الكلايش','list')
            wkeko = false
            if text2:match("[Ll][Ii][Nn][Kk]") then 
                wkeko = "link"
            elseif (text2:match("[Ff][Ww][Dd]")) then 
                wkeko = "fwd"
            elseif (text2:match("[Pp][Oo][Ll][Ll][Ss]")) then 
                wkeko = "poll"
            elseif (text2:match("[Pp][Hh][Oo][tT][Oo]")) then 
                wkeko = "photo"
            elseif (text2:match("[Vv][Ii][Dd][Ee][Oo]")) then 
                wkeko = "video"
            elseif (text2:match("[Gg][Ii][Ff]")) then 
                wkeko = "gif"
            elseif (text2:match("[Uu][Ss][eE][rR][Nn][Aa][Mm][Ee]")) then 
                wkeko = "username"
            elseif (text2:match("[iI][Nn][Ll][Ii][Nn][Ee]")) then 
                wkeko = "inlines"
            elseif (text2:match("[Mm][aA][Rr][Kk][Dd][Oo][wW][Nn]")) then
                wkeko = "markdown"
            elseif (text2:match("[Ss][Pp][Ii][Mm]")) then
                wkeko = "spam"
            elseif (text2:match("[Ss][tT][Ii][Cc][kK][Ee][Rr]")) then 
                wkeko = "sticker"
            elseif (text2:match("[Ff][Ii][lL][Ee]")) then 
                wkeko = "file"
            elseif (text2:match("[mM][uU][sS][Ii][Cc]")) then 
                wkeko = "music"
            elseif (text2:match("[lL][iI][sS][tT]")) then 
                wkeko = "list"
            elseif (text2:match("[bB][oO][tT][sS]")) then 
                wkeko = "bots"
            elseif (text2:match("[Aa][Ll][Ll]")) then 
                wkeko = "all"
            else
            return ""
            end 
            if (text2:match("^[lL][oO][cC][kK] (.*)") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         msg2 = msg msg2["sender_user_id"] = t2.sender_user_id
                         if is_vip(msg2) then 
                            send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno)
                            return "keko"
                         end
                         if speed_lock("lock", wkeko, msg.chat_id..id_user_keko ) == "is" then
                            keko.send_msg_and_info_sender2(msg,Tkeko.lock["is"..wkeko].." "..Tkeko.youlock)
                           else 
                            if wkeko == "all" then 
                                speed_lock("lock", "list", msg.chat_id..id_user_keko )
                                speed_lock("lock", "music", msg.chat_id..id_user_keko )
                                speed_lock("lock", "edit_media", msg.chat_id..id_user_keko )
                                speed_lock("lock", "sticker", msg.chat_id..id_user_keko )
                                speed_lock("lock", "spam", msg.chat_id..id_user_keko )
                                speed_lock("lock", "bots", msg.chat_id..id_user_keko )
                                speed_lock("lock", "note", msg.chat_id..id_user_keko )
                                speed_lock("lock", "photo", msg.chat_id..id_user_keko )
                                speed_lock("lock", "inlines", msg.chat_id..id_user_keko )
                                speed_lock("lock", "markdown", msg.chat_id..id_user_keko )
                                speed_lock("lock", "fwd", msg.chat_id..id_user_keko )
                                speed_lock("lock", "link", msg.chat_id..id_user_keko )
                                speed_lock("lock", "username", msg.chat_id..id_user_keko )
                                speed_lock("lock", "gif", msg.chat_id..id_user_keko )
                                speed_lock("lock", "video", msg.chat_id..id_user_keko )
                                speed_lock("lock", "contact", msg.chat_id..id_user_keko )
                            end 
                            keko.send_msg_and_info_sender2(msg,Tkeko.lock[wkeko].." "..Tkeko.youlock)
                           end 
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[lL][oO][cC][kK] (.*) (%d+)$")) then 
                id_user_keko = {string.match(text2, "[lL][oO][cC][kK] (.*) (%d+)")}
                id_user_keko = id_user_keko[2]
                msg2 = msg msg2["sender_user_id"] = tonumber(id_user_keko)
                if is_vip(msg2) then 
                   send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno)
                   return "keko"
                end
                if speed_lock("lock", wkeko, msg.chat_id..id_user_keko ) == "is" then
                    keko.send_msg_and_info_sender2(msg2,Tkeko.lock["is"..wkeko].." "..Tkeko.youlock)
                else 
                    if wkeko == "all" then 
                        speed_lock("lock", "list", msg.chat_id..id_user_keko )
                        speed_lock("lock", "music", msg.chat_id..id_user_keko )
                        speed_lock("lock", "edit_media", msg.chat_id..id_user_keko )
                        speed_lock("lock", "sticker", msg.chat_id..id_user_keko )
                        speed_lock("lock", "spam", msg.chat_id..id_user_keko )
                        speed_lock("lock", "bots", msg.chat_id..id_user_keko )
                        speed_lock("lock", "note", msg.chat_id..id_user_keko )
                        speed_lock("lock", "inlines", msg.chat_id..id_user_keko )
                        speed_lock("lock", "markdown", msg.chat_id..id_user_keko )
                        speed_lock("lock", "fwd", msg.chat_id..id_user_keko )
                        speed_lock("lock", "photo", msg.chat_id..id_user_keko )
                        speed_lock("lock", "link", msg.chat_id..id_user_keko )
                        speed_lock("lock", "username", msg.chat_id..id_user_keko )
                        speed_lock("lock", "gif", msg.chat_id..id_user_keko )
                        speed_lock("lock", "video", msg.chat_id..id_user_keko )
                        speed_lock("lock", "contact", msg.chat_id..id_user_keko )
                    end 
                    keko.send_msg_and_info_sender2(msg2,Tkeko.lock[wkeko].." "..Tkeko.youlock)
                end 
            elseif (text2:match("^[lL][oO][cC][kK] (.*) @(.*)$")) then 
                id_user_keko = {string.match(text2, "[lL][oO][cC][kK] (.*) @(.*)")}
                function keko_get_user(t1,t2)
                    if t2.id then 
                        msg2 = msg msg2["sender_user_id"] = t2.id
                        if is_vip(msg2) then 
                           send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                           return "keko"
                        end
                        if speed_lock("lock", wkeko, msg.chat_id..t2.id ) == "is" then
                            for keko_name in string.gmatch(t2.title, "[^%s]+") do
                                t2.title = keko_name
                                break
                            end
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(t2.username or "BotLua")..")\n"..Tkeko.lock["is"..wkeko].." "..Tkeko.youlock,msg.id,"keko")
                         else
                            if wkeko == "all" then 
                                id_user_keko = t2.id
                                speed_lock("lock", "list", msg.chat_id..id_user_keko )
                                speed_lock("lock", "music", msg.chat_id..id_user_keko )
                                speed_lock("lock", "edit_media", msg.chat_id..id_user_keko )
                                speed_lock("lock", "sticker", msg.chat_id..id_user_keko )
                                speed_lock("lock", "spam", msg.chat_id..id_user_keko )
                                speed_lock("lock", "bots", msg.chat_id..id_user_keko )
                                speed_lock("lock", "note", msg.chat_id..id_user_keko )
                                speed_lock("lock", "inlines", msg.chat_id..id_user_keko )
                                speed_lock("lock", "photo", msg.chat_id..id_user_keko )
                                speed_lock("lock", "markdown", msg.chat_id..id_user_keko )
                                speed_lock("lock", "fwd", msg.chat_id..id_user_keko )
                                speed_lock("lock", "link", msg.chat_id..id_user_keko )
                                speed_lock("lock", "username", msg.chat_id..id_user_keko )
                                speed_lock("lock", "gif", msg.chat_id..id_user_keko )
                                speed_lock("lock", "video", msg.chat_id..id_user_keko )
                                speed_lock("lock", "contact", msg.chat_id..id_user_keko )
                            end 
                            for keko_name in string.gmatch(t2.title, "[^%s]+") do
                                t2.title = keko_name
                                break
                            end
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(t2.username or "BotLua")..")\n"..Tkeko.lock[wkeko].." "..Tkeko.youlock,msg.id,"keko")
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko[2],keko_get_user)
            end 
        end
        ----------------
        text2 = text  text2 = text2:gsub('فتح','open') text2 = text2:gsub('unlock','open')
        if (text2:match("^[Oo][Pp][Ee][Nn] (.*) @(.*)") or text2:match("^[Oo][Pp][Ee][Nn] (.*) (%d+)") or (text2:match("^[Oo][Pp][Ee][Nn] (.*)") and msg.reply_to_message_id ~= 0)) then
            text2 = text2:gsub('الروابط','link') text2 = text2:gsub('الاستفتاء','polls') text2 = text2:gsub('التصويت','polls') text2 = text2:gsub('الجهات','contact') text2 = text2:gsub('جهات','contact') text2 = text2:gsub('الكل','all')  text2 = text2:gsub('التوجيه','fwd') text2 = text2:gsub('الصور','photo') text2 = text2:gsub('الفديو','video') text2 = text2:gsub('المتحركه','gif') text2 = text2:gsub('المعرفات','username') text2 = text2:gsub('النلاين','inline') text2 = text2:gsub('ماركدون','markdown') text2 = text2:gsub('التكرار','spam') text2 = text2:gsub('الملصقات','sticker') text2 = text2:gsub('الملفات','file') text2 = text2:gsub('البوتات','bots') text2 = text2:gsub('الكلايش','list')
            wkeko = false
            if text2:match("[Ll][Ii][Nn][Kk]") then 
                wkeko = "link"
            elseif (text2:match("[Ff][Ww][Dd]")) then 
                wkeko = "fwd"
            elseif (text2:match("[Pp][Hh][Oo][tT][Oo]")) then 
                wkeko = "photo"
            elseif (text2:match("[Pp][Oo][Ll][Ll][Ss]")) then 
                wkeko = "poll"
            elseif (text2:match("[Vv][Ii][Dd][Ee][Oo]")) then 
                wkeko = "video"
            elseif (text2:match("[Gg][Ii][Ff]")) then 
                wkeko = "gif"
            elseif (text2:match("[Uu][Ss][eE][rR][Nn][Aa][Mm][Ee]")) then 
                wkeko = "username"
            elseif (text2:match("[iI][Nn][Ll][Ii][Nn][Ee]")) then 
                wkeko = "inlines"
            elseif (text2:match("[Mm][aA][Rr][Kk][Dd][Oo][wW][Nn]")) then
                wkeko = "markdown"
            elseif (text2:match("[Ss][Pp][Ii][Mm]")) then
                wkeko = "spam"
            elseif (text2:match("[Ss][tT][Ii][Cc][kK][Ee][Rr]")) then 
                wkeko = "sticker"
            elseif (text2:match("[Ff][Ii][lL][Ee]")) then 
                wkeko = "file"
            elseif (text2:match("[mM][uU][sS][Ii][Cc]")) then 
                wkeko = "music"
            elseif (text2:match("[lL][iI][sS][tT]")) then 
                wkeko = "list"
            elseif (text2:match("[bB][oO][tT][sS]")) then 
                wkeko = "bots"
            elseif (text2:match("[Aa][Ll][Ll]")) then 
                wkeko = "all"
            else
            return ""
            end 
            if (text2:match("^[Oo][Pp][Ee][Nn] (.*)") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         msg2 = msg msg2["sender_user_id"] = t2.sender_user_id
                         if is_vip(msg2) then 
                            send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno)
                            return "keko"
                         end
                         if wkeko == "all" then  
                            speed_lock("open", "list", msg.chat_id..id_user_keko )
                            speed_lock("open", "music", msg.chat_id..id_user_keko )
                            speed_lock("open", "edit_media", msg.chat_id..id_user_keko )
                            speed_lock("open", "sticker", msg.chat_id..id_user_keko )
                            speed_lock("open", "spam", msg.chat_id..id_user_keko )
                            speed_lock("open", "bots", msg.chat_id..id_user_keko )
                            speed_lock("open", "note", msg.chat_id..id_user_keko )
                            speed_lock("open", "photo", msg.chat_id..id_user_keko )
                            speed_lock("open", "inlines", msg.chat_id..id_user_keko )
                            speed_lock("open", "markdown", msg.chat_id..id_user_keko )
                            speed_lock("open", "fwd", msg.chat_id..id_user_keko )
                            speed_lock("open", "link", msg.chat_id..id_user_keko )
                            speed_lock("open", "username", msg.chat_id..id_user_keko )
                            speed_lock("open", "gif", msg.chat_id..id_user_keko )
                            speed_lock("open", "video", msg.chat_id..id_user_keko )
                            speed_lock("open", "contact", msg.chat_id..id_user_keko )
                            keko.send_msg_and_info_sender2(msg,Tkeko.lock["open_"..wkeko].." "..Tkeko.youlock)
                         else
                         if speed_lock("open", wkeko, msg.chat_id..id_user_keko ) == "is" then
                            keko.send_msg_and_info_sender2(msg,Tkeko.lock["isopen_"..wkeko].." "..Tkeko.youlock)
                           else 
                            keko.send_msg_and_info_sender2(msg,Tkeko.lock["open_"..wkeko].." "..Tkeko.youlock)
                           end 
                        end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Oo][Pp][Ee][Nn] (.*) (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Oo][Pp][Ee][Nn] (.*) (%d+)")}
                id_user_keko = id_user_keko[2]
                msg2 = msg msg2["sender_user_id"] = tonumber(id_user_keko)
                if is_vip(msg2) then 
                   send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno)
                   return "keko"
                end
                if wkeko == "all" then 
                    speed_lock("open", "list", msg.chat_id..id_user_keko )
                    speed_lock("open", "music", msg.chat_id..id_user_keko )
                    speed_lock("open", "edit_media", msg.chat_id..id_user_keko )
                    speed_lock("open", "sticker", msg.chat_id..id_user_keko )
                    speed_lock("open", "spam", msg.chat_id..id_user_keko )
                    speed_lock("open", "bots", msg.chat_id..id_user_keko )
                    speed_lock("open", "note", msg.chat_id..id_user_keko )
                    speed_lock("open", "photo", msg.chat_id..id_user_keko )
                    speed_lock("open", "inlines", msg.chat_id..id_user_keko )
                    speed_lock("open", "markdown", msg.chat_id..id_user_keko )
                    speed_lock("open", "fwd", msg.chat_id..id_user_keko )
                    speed_lock("open", "link", msg.chat_id..id_user_keko )
                    speed_lock("open", "username", msg.chat_id..id_user_keko )
                    speed_lock("open", "gif", msg.chat_id..id_user_keko )
                    speed_lock("open", "video", msg.chat_id..id_user_keko )
                    speed_lock("open", "contact", msg.chat_id..id_user_keko )
                    keko.send_msg_and_info_sender2(msg2,Tkeko.lock["open_"..wkeko].." "..Tkeko.youlock)
                else  
                if speed_lock("open", wkeko, msg.chat_id..id_user_keko ) == "is" then
                    keko.send_msg_and_info_sender2(msg2,Tkeko.lock["isopen_"..wkeko].." "..Tkeko.youlock)
                else 
                    keko.send_msg_and_info_sender2(msg2,Tkeko.lock["open_"..wkeko].." "..Tkeko.youlock)
                end 
            end
            elseif (text2:match("^[Oo][Pp][Ee][Nn] (.*) @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Oo][Pp][Ee][Nn] (.*) @(.*)")}
                function keko_get_user(t1,t2)
                    if t2.id then 
                        msg2 = msg msg2["sender_user_id"] = t2.id
                        if is_vip(msg2) then 
                           send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                           return "keko"
                        end
                        if wkeko == "all" then 
                            id_user_keko = t2.id
                            speed_lock("open", "list", msg.chat_id..id_user_keko )
                            speed_lock("open", "music", msg.chat_id..id_user_keko )
                            speed_lock("open", "edit_media", msg.chat_id..id_user_keko )
                            speed_lock("open", "sticker", msg.chat_id..id_user_keko )
                            speed_lock("open", "spam", msg.chat_id..id_user_keko )
                            speed_lock("open", "photo", msg.chat_id..id_user_keko )
                            speed_lock("open", "bots", msg.chat_id..id_user_keko )
                            speed_lock("open", "note", msg.chat_id..id_user_keko )
                            speed_lock("open", "inlines", msg.chat_id..id_user_keko )
                            speed_lock("open", "markdown", msg.chat_id..id_user_keko )
                            speed_lock("open", "fwd", msg.chat_id..id_user_keko )
                            speed_lock("open", "link", msg.chat_id..id_user_keko )
                            speed_lock("open", "username", msg.chat_id..id_user_keko )
                            speed_lock("open", "gif", msg.chat_id..id_user_keko )
                            speed_lock("open", "video", msg.chat_id..id_user_keko )
                            speed_lock("open", "contact", msg.chat_id..id_user_keko )
                        end 
                        if speed_lock("open", wkeko, msg.chat_id..t2.id ) == "is" then
                            for keko_name in string.gmatch(t2.title, "[^%s]+") do
                                t2.title = keko_name
                                break
                            end
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(t2.username or "BotLua")..")\n"..Tkeko.lock["isopen_"..wkeko].." "..Tkeko.youlock,msg.id,"keko")
                         else
                            for keko_name in string.gmatch(t2.title, "[^%s]+") do
                                t2.title = keko_name
                                break
                            end
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(t2.username or "BotLua")..")\n"..Tkeko.lock["open_"..wkeko].." "..Tkeko.youlock,msg.id,"keko")
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko[2],keko_get_user)
            end 
        end
    ------------------------------- end lock user  -------------------------------
    ---------------------------------mute-----------------------------------------
        text2 = text  text2 = text2:gsub('كتم','mute')
        if (text2:match("[mM][Uu][Tt][Ee]")) then
            if (text2:match("^[mM][Uu][Tt][Ee]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         msg2 = msg msg2["sender_user_id"] = t2.sender_user_id
                         if is_vip(msg2) then 
                            send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                            return "keko"
                         end
                         if dkeko:sismember("keko:mute:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.ismute )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.mute )
                            dkeko:sadd("keko:mute:"..bot_id..msg.chat_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[mM][Uu][Tt][Ee] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[mM][Uu][Tt][Ee] (%d+)")}
                id_user_keko = id_user_keko[1]
                msg2 = msg msg2["sender_user_id"] = id_user_keko
                if is_vip(msg2) then 
                   send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                   return "keko"
                end
                if dkeko:sismember("keko:mute:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.ismute )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.mute )
                    dkeko:sadd("keko:mute:"..bot_id..msg.chat_id,id_user_keko)
                 end
            elseif (text2:match("^[mM][Uu][Tt][Ee] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[mM][Uu][Tt][Ee] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        msg2 = msg msg2["sender_user_id"] = t2.id
                        if is_vip(msg2) then 
                           send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                           return "keko"
                        end
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if dkeko:sismember("keko:mute:"..bot_id..msg.chat_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.ismute,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.mute,msg.id,"keko")
                            dkeko:sadd("keko:mute:"..bot_id..msg.chat_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end
        text2 = text  text2 = text:gsub('الغاء كتم','unmute')
        if (text2:match("[Uu][Nn][mM][Uu][Tt][Ee]")) then
            if (text2:match("^[Uu][Nn][mM][Uu][Tt][Ee]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         msg2 = msg msg2["sender_user_id"] = id_user_keko
                         if is_vip(msg2) then 
                            send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                            return "keko"
                         end
                         if not dkeko:sismember("keko:mute:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isunmute )
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.unmute )
                            dkeko:srem("keko:mute:"..bot_id..msg.chat_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Uu][Nn][mM][Uu][Tt][Ee] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Uu][Nn][mM][Uu][Tt][Ee] (%d+)")}
                id_user_keko = id_user_keko[1]
                msg2 = msg msg2["sender_user_id"] = id_user_keko
                if is_vip(msg2) then 
                   send_msg_and_info( msg, id_user_keko[1], Tkeko.isamdinno )
                   return "keko"
                end
                if not dkeko:sismember("keko:mute:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isunmute )
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.unmute )
                    dkeko:srem("keko:mute:"..bot_id..msg.chat_id,id_user_keko)
                 end
            elseif (text2:match("^[Uu][Nn][mM][Uu][Tt][Ee] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Uu][Nn][mM][Uu][Tt][Ee] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        msg2 = msg msg2["sender_user_id"] = t2.id
                        if is_vip(msg2) then 
                           send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                           return "keko"
                        end
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if not dkeko:sismember("keko:mute:"..bot_id..msg.chat_id, t2.id) then
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isunmute,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.unmute,msg.id,"keko")
                            dkeko:srem("keko:mute:"..bot_id..msg.chat_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end
    -----------------------end mute -----------------------------
    --[[if text == "keko" then 
        keyboard = {} 
        keyboard.inline_keyboard = {
        {
        {text = 'keko', callback_data="/keko"},
        },
        {
        {text = 'UserName for keko', url="t.me/HHHHD"},
        },
        }
        api("sendMessage",{
            "chat_id="..msg.chat_id,
            "text=[keko](t.me/HHHHD)",
            "parse_mode=markdown",
            "disable_web_page_preview=true",
            "reply_markup="..JSON.encode(keyboard),
            }) 
    end]]
    ----------------------Ban or kick user ----------------------
    text2 = text  text2 = text2:gsub('طرد','ban') text2 = text2:gsub('حظر','ban') text2 = text2:gsub('kick','ban') text2 = text2:gsub('Kick','ban')
        if (text2:match("[Bb][Aa][Nn]")) then  
            if (text2:match("^[Bb][Aa][Nn]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         msg2 = msg msg2["sender_user_id"] = t2.sender_user_id
                         if is_vip(msg2) then 
                            send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                            return "keko"
                         end
                         if dkeko:sismember("keko:ban:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isban)
                            keko.kick(msg.chat_id, t2.id)
                         else 
                            send_msg_and_info(msg, id_user_keko,Tkeko.ban)
                            keko.kick(msg.chat_id, id_user_keko)
                            dkeko:sadd("keko:ban:"..bot_id..msg.chat_id,id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Bb][Aa][Nn] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Bb][Aa][Nn] (%d+)")}
                id_user_keko = id_user_keko[1]
                msg2 = msg msg2["sender_user_id"] = id_user_keko
                if is_vip(msg2) then 
                   send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                   return "keko"
                end
                if dkeko:sismember("keko:ban:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isban )
                    keko.kick(msg.chat_id, t2.id)
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.ban )
                    keko.kick(msg.chat_id, id_user_keko)
                    dkeko:sadd("keko:ban:"..bot_id..msg.chat_id,id_user_keko)
                 end
            elseif (text2:match("^[Bb][Aa][Nn] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Bb][Aa][Nn] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        msg2 = msg msg2["sender_user_id"] = t2.id
                        if is_vip(msg2) then 
                           send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                           return "keko"
                        end
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if dkeko:sismember("keko:ban:"..bot_id..msg.chat_id, t2.id) then
                            keko.kick(msg.chat_id, t2.id)
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isban,msg.id,"keko")
                         else
                            keko.kick(msg.chat_id, t2.id)
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.ban,msg.id,"keko")
                            dkeko:sadd("keko:ban:"..bot_id..msg.chat_id,t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end
        text2 = text  text2 = text2:gsub('الغاء طرد','unban') text2 = text2:gsub('الغاء حظر','unban') text2 = text2:gsub('Unkick','unban') text2 = text2:gsub('unkick','unban')
        if (text2:match("[Uu][Nn][Bb][Aa][Nn]")) then
            if (text2:match("^[Uu][Nn][Bb][Aa][Nn]$") and msg.reply_to_message_id ~= 0) then
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                         id_user_keko = t2.sender_user_id
                         msg2 = msg msg2["sender_user_id"] = id_user_keko
                         if is_vip(msg2) then 
                            send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                            keko.unkick(msg.chat_id, id_user_keko)
                            return "keko"
                         end
                         if not dkeko:sismember("keko:ban:"..bot_id..msg.chat_id, id_user_keko) then
                            send_msg_and_info( msg, id_user_keko, Tkeko.isunban )
                            keko.unkick(msg.chat_id, id_user_keko)
                         else 
                            send_msg_and_info( msg, id_user_keko, Tkeko.unban )
                            dkeko:srem("keko:ban:"..bot_id..msg.chat_id,id_user_keko)
                            keko.unkick(msg.chat_id, id_user_keko)
                         end
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Uu][Nn][Bb][Aa][Nn] (%d+)$")) then 
                id_user_keko = {string.match(text2, "[Uu][Nn][Bb][Aa][Nn] (%d+)")}
                id_user_keko = id_user_keko[1]
                msg2 = msg msg2["sender_user_id"] = id_user_keko
                if is_vip(msg2) then 
                   keko.unkick(msg.chat_id, id_user_keko)
                   send_msg_and_info( msg, id_user_keko[1], Tkeko.isamdinno )
                   return "keko"
                end
                if not dkeko:sismember("keko:ban:"..bot_id..msg.chat_id, id_user_keko) then
                    send_msg_and_info( msg, id_user_keko, Tkeko.isunban )
                    keko.unkick(msg.chat_id, id_user_keko)
                 else 
                    send_msg_and_info( msg, id_user_keko, Tkeko.unban )
                    dkeko:srem("keko:ban:"..bot_id..msg.chat_id,id_user_keko)
                    keko.unkick(msg.chat_id, id_user_keko)
                 end
            elseif (text2:match("^[Uu][Nn][Bb][Aa][Nn] @(.*)$")) then 
                id_user_keko = {string.match(text2, "[Uu][Nn][Bb][Aa][Nn] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user(t1,t2)
                    if t2.id then 
                        msg2 = msg msg2["sender_user_id"] = t2.id
                        if is_vip(msg2) then
                           keko.unkick(msg.chat_id, t2.id) 
                           send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                           return "keko"
                        end
                        for keko_name in string.gmatch(t2.title, "[^%s]+") do
                            t2.title = keko_name
                            break
                        end
                        if not dkeko:sismember("keko:ban:"..bot_id..msg.chat_id, t2.id) then
                            keko.unkick(msg.chat_id, t2.id)
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isunban,msg.id,"keko")
                         else
                            keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.unban,msg.id,"keko")
                            dkeko:srem("keko:ban:"..bot_id..msg.chat_id,t2.id)
                            keko.unkick(msg.chat_id, t2.id)
                         end
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user)
            end 
        end
    -----------------------------end ban or kick -----------------
    -----------------------------pin msg -------------------------
    text2 = text  text2 = text2:gsub('تثبيت','pin')
    if (text2:match("^[Pp][Ii][Nn]$") and msg.reply_to_message_id ~= 0) then
        keko.pin(msg.chat_id,msg.reply_to_message_id)
        dkeko:set("keko:msg:pin:gr:"..bot_id..msg.chat_id,msg.reply_to_message_id)
        keko.send_msg_and_info_sender(msg,Tkeko.pinmsg)
    end
    text2 = text  text2 = text2:gsub('الغاء تثبيت','unpin')
    if (text2:match("^[uU][Nn][Pp][Ii][Nn]$")) then
        keko.unpin(msg.chat_id)
        dkeko:del("keko:msg:pin:gr:"..bot_id..msg.chat_id)
        keko.send_msg_and_info_sender(msg,Tkeko.unpinmsg)
    end 
    --------------------- end pin msg --------------------------

    --------------------- mute on gr ---------------------------
    text2 = text  text2 = text2:gsub('تقييد','restriction')  text2 = text2:gsub('تقيد','restrict') text2 = text2:gsub('restriction','restrict') 
    if (text2:match("[rR][eE][Ss][Tt][Rr][Ii][cC][Tt]")) then  
        if (text2:match("^[rR][eE][Ss][Tt][Rr][Ii][cC][Tt]$") and msg.reply_to_message_id ~= 0) then
            function keko_get_msg(t1,t2)
                if t2.sender_user_id then
                     id_user_keko = t2.sender_user_id
                     msg2 = msg msg2["sender_user_id"] = t2.sender_user_id
                     if is_vip(msg2) then 
                        send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                        return "keko"
                     end
                     if dkeko:sismember("keko:mut_gr:"..bot_id..msg.chat_id, id_user_keko) then
                        send_msg_and_info( msg, id_user_keko, Tkeko.ismute_ge )
                        keko.mute_gr(msg.chat_id, id_user_keko)
                     else 
                        send_msg_and_info(msg, id_user_keko, Tkeko.mute_ge )
                        keko.mute_gr(msg.chat_id, id_user_keko)
                        dkeko:sadd("keko:mut_gr:"..bot_id..msg.chat_id,id_user_keko)
                     end
                end
            end
            keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
        elseif (text2:match("^[rR][eE][Ss][Tt][Rr][Ii][cC][Tt] (%d+)$")) then 
            id_user_keko = {string.match(text2, "[rR][eE][Ss][Tt][Rr][Ii][cC][Tt] (%d+)")}
            id_user_keko = id_user_keko[1]
            msg2 = msg msg2["sender_user_id"] = id_user_keko
            if is_vip(msg2) then 
               send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
               return "keko"
            end
            if dkeko:sismember("keko:mut_gr:"..bot_id..msg.chat_id, id_user_keko) then
                send_msg_and_info( msg, id_user_keko, Tkeko.ismute_ge )
             else 
                send_msg_and_info( msg, id_user_keko, Tkeko.mute_ge )
                keko.mute_gr(msg.chat_id, id_user_keko)
                dkeko:sadd("keko:mut_gr:"..bot_id..msg.chat_id,id_user_keko)
             end
        elseif (text2:match("^[rR][eE][Ss][Tt][Rr][Ii][cC][Tt] @(.*)$")) then 
            id_user_keko = {string.match(text2, "[rR][eE][Ss][Tt][Rr][Ii][cC][Tt] @(.*)")}
            id_user_keko = id_user_keko[1]
            function keko_get_user(t1,t2)
                if t2.id then 
                    msg2 = msg msg2["sender_user_id"] = t2.id
                    if is_vip(msg2) then 
                       send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                       return "keko"
                    end
                    for keko_name in string.gmatch(t2.title, "[^%s]+") do
                        t2.title = keko_name
                        break
                    end
                    if dkeko:sismember("keko:mut_gr:"..bot_id..msg.chat_id, t2.id) then
                        keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.ismute_ge,msg.id,"keko")
                     else
                        keko.mute_gr(msg.chat_id, t2.id)
                        keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.mute_ge,msg.id,"keko")
                        dkeko:sadd("keko:mut_gr:"..bot_id..msg.chat_id,t2.id)
                     end
                else
                    keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                end
            end
            keko.get_info_username(id_user_keko,keko_get_user)
        end 
    end
    text2 = text  text2 = text2:gsub('الغاء تقييد','unrestrict')  text2 = text2:gsub('الغاء تقيد','unrestrict') text2 = text2:gsub('unrestriction','unrestrict') 
    if (text2:match("[Uu][Nn][rR][eE][Ss][Tt][Rr][Ii][cC][Tt]")) then
        if (text2:match("^[Uu][Nn][rR][eE][Ss][Tt][Rr][Ii][cC][Tt]$") and msg.reply_to_message_id ~= 0) then
            function keko_get_msg(t1,t2)
                if t2.sender_user_id then
                     id_user_keko = t2.sender_user_id
                     msg2 = msg msg2["sender_user_id"] = id_user_keko
                     if is_vip(msg2) then 
                        send_msg_and_info( msg, id_user_keko, Tkeko.isamdinno )
                        unmute_gr(msg.chat_id, id_user_keko)
                        return "keko"
                     end
                     if not dkeko:sismember("keko:mut_gr:"..bot_id..msg.chat_id, id_user_keko) then
                        send_msg_and_info( msg, id_user_keko, Tkeko.isunmute_ge )
                        unmute_gr(msg.chat_id, id_user_keko)
                     else 
                        send_msg_and_info( msg, id_user_keko, Tkeko.unmute_ge )
                        dkeko:srem("keko:mut_gr:"..bot_id..msg.chat_id,id_user_keko)
                        unmute_gr(msg.chat_id, id_user_keko)
                        end
                end
            end
            keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
        elseif (text2:match("^[Uu][Nn][rR][eE][Ss][Tt][Rr][Ii][cC][Tt] (%d+)$")) then 
            id_user_keko = {string.match(text2, "[Uu][Nn][rR][eE][Ss][Tt][Rr][Ii][cC][Tt] (%d+)")}
            id_user_keko = id_user_keko[1]
            msg2 = msg msg2["sender_user_id"] = id_user_keko
            if is_vip(msg2) then 
               send_msg_and_info( msg, id_user_keko[1], Tkeko.isamdinno )
               unmute_gr(msg.chat_id, id_user_keko)
               return "keko"
            end
            if not dkeko:sismember("keko:mut_gr:"..bot_id..msg.chat_id, id_user_keko) then
                send_msg_and_info( msg, id_user_keko, Tkeko.isunmute_ge )
                unmute_gr(msg.chat_id, id_user_keko)
             else 
                send_msg_and_info( msg, id_user_keko, Tkeko.unmute_ge )
                dkeko:srem("keko:mut_gr:"..bot_id..msg.chat_id,id_user_keko)
                unmute_gr(msg.chat_id, id_user_keko)
             end
        elseif (text2:match("^[Uu][Nn][rR][eE][Ss][Tt][Rr][Ii][cC][Tt] @(.*)$")) then 
            id_user_keko = {string.match(text2, "[Uu][Nn][rR][eE][Ss][Tt][Rr][Ii][cC][Tt] @(.*)")}
            id_user_keko = id_user_keko[1]
            function keko_get_user(t1,t2)
                if t2.id then 
                    msg2 = msg msg2["sender_user_id"] = t2.id
                    if is_vip(msg2) then 
                       send_msg_and_info( msg, t2.id, Tkeko.isamdinno )
                       unmute_gr(msg.chat_id, id_user_keko)
                       return "keko"
                    end
                    for keko_name in string.gmatch(t2.title, "[^%s]+") do
                        t2.title = keko_name
                        break
                    end
                    if not dkeko:sismember("keko:mut_gr:"..bot_id..msg.chat_id, t2.id) then
                        unmute_gr(msg.chat_id, t2.id)
                        keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isunmute_ge,msg.id,"keko")
                     else
                        keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.unmute_ge,msg.id,"keko")
                        dkeko:srem("keko:mut_gr:"..bot_id..msg.chat_id,t2.id)
                        unmute_gr(msg.chat_id, t2.id)
                     end
                else
                    keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                end
            end
            keko.get_info_username(id_user_keko,keko_get_user)
        end 
    end

    if text and (text == "تفعيل التقييد" or text == "تفعيل التقيد" or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[Ee][nN][aA][bB][lL][Ee] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[Ee][nN][aA][bB][lL][Ee] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt]$") or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt]$")) then
        ykekoi = dkeko:get("keko:mute_on_gr:"..bot_id..msg.chat_id)
        if ykekoi then 
            keko.send_msg_and_info_sender(msg,Tkeko.ismuteongr)
        else
            keko.send_msg_and_info_sender(msg,Tkeko.muteongr)
            dkeko:set("keko:mute_on_gr:"..bot_id..msg.chat_id,true)
        end 
    end
    if text and (text == "تعطيل التقييد" or text == "تعطيل التقيد" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt]$")) then
        ykekoi = dkeko:get("keko:mute_on_gr:"..bot_id..msg.chat_id)
        if not ykekoi then 
            keko.send_msg_and_info_sender(msg,Tkeko.isunmuteongr)
        else
            keko.send_msg_and_info_sender(msg,Tkeko.unmuteongr)
            dkeko:del("keko:mute_on_gr:"..bot_id..msg.chat_id)
        end 
    end
    -----------------end mute on gr ------------------------------
    if text == "وضع رابط" or text:match("^[Ss][Ee][Tt] [Ll][iI][Nn][Kk]$") then 
        keko.send_text(msg.chat_id, Tkeko.sendlink,msg.id,"keko")
        dkeko:set("keko:set:link:"..bot_id..msg.chat_id..msg.sender_user_id,true)
        return "keko"
    end 
    if text and text:match("[hH][Tt][tT][pP]") and dkeko:get("keko:set:link:"..bot_id..msg.chat_id..msg.sender_user_id) then 
        dkeko:del("keko:set:link:"..bot_id..msg.chat_id..msg.sender_user_id)
        keko.send_text(msg.chat_id, Tkeko.savelink,msg.id,"keko")
        dkeko:set("keko:link:gr"..bot_id..msg.chat_id,text)
    end 
    text2 = text  text2 = text2:gsub('تعيين عدد التكرار','set spam') text2 = text2:gsub('تعين عدد التكرار','set spam')
    if text2:match("[Ss][Ee][Tt] [Ss][Pp][Aa][Mm] (%d+)") then 
        spams = {string.match(text2, "[Ss][Ee][Tt] [Ss][Pp][Aa][Mm] (%d+)")}
        spams = spams[1]
        dkeko:set("keko:max:spam:"..bot_id..msg.chat_id,spams)
        keko.send_msg_and_info_sender(msg,Tkeko.setmaxspam..spams)
    end
    text2 = text  text2 = text2:gsub('تعيين عدد الكليشه','set text') text2 = text2:gsub('تعين عدد الكليشه','set text')
    if text2:match("[Ss][Ee][Tt] [Tt][Ee][Xx][Tt] (%d+)") then 
        text_list = {string.match(text2, "[Ss][Ee][Tt] [Tt][Ee][Xx][Tt] (%d+)")}
        text_list = text_list[1]
        dkeko:set("keko:list:text:"..bot_id..msg.chat_id,text_list)
        keko.send_msg_and_info_sender(msg,Tkeko.setmaxlist..text_list)
    end
    if text == "المكتومين" or text == "قائمه المكتومين" or text:match("^[Ll][Ii][Ss][Tt] [Mm][Uu][Tt][Ee]$") or text:match("^[Ll][Ii][Ss][Tt] [Mm][Uu][Tt][Ee][Ss]$") or text:match("^[Mm][Uu][Tt][Ee][Ss]$") then 
        list_mute = dkeko:smembers("keko:mute:"..bot_id..msg.chat_id)
        if list_mute and list_mute[1] then 
            list_keko = Tkeko.mutelist.."\n"
            for i=1,#list_mute do
                username = dkeko:get("keko:username:user:"..list_mute[i]) or list_mute[i]
                list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_mute[i]..")}" 
            end
            keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
        else
            keko.send_text(msg.chat_id, Tkeko.notmute,msg.id,"keko")
        end 
    end 
    if text == "المطرودين" or text == "قائمه المطرودين" or text == "المحظورين" or text == "قائمه المحظورين" or text:match("^[Ll][Ii][Ss][Tt] [Bb][Aa][nN]$") or text:match("^[Ll][Ii][Ss][Tt] [kK][iI][Cc][Kk]$") then 
        list_ban = dkeko:smembers("keko:ban:"..bot_id..msg.chat_id)
        if list_ban and list_ban[1] then 
            list_keko = Tkeko.banlist.."\n"
            for i=1,#list_ban do
                username = dkeko:get("keko:username:user:"..list_ban[i]) or list_ban[i]
                list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_ban[i]..")}" 
            end
            keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
        else
            keko.send_text(msg.chat_id, Tkeko.notban,msg.id,"keko")
        end 
    end 
    if text == "مسح المكتومين" or text == "مسح قائمه المكتومين" or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [Mm][Uu][Tt][Ee]$") or text:match("^[Dd][Ee][Ll][Ee][Tt] [Ll][Ii][Ss][Tt] [Mm][Uu][Tt][Ee]$") or text:match("^[Dd][Ee][Ll][Ee][Tt] [Ll][Ii][Ss][Tt] [Mm][Uu][Tt][Ee][Ss]$") or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [Mm][Uu][Tt][Ee][Ss]$") or text:match("^[Dd][Ee][Ll] [Mm][Uu][Tt][Ee][Ss]$") then 
        list_mute = dkeko:smembers("keko:mute:"..bot_id..msg.chat_id)
        if list_mute and list_mute[1] then 
            dkeko:del("keko:mute:"..bot_id..msg.chat_id)
            keko.send_text(msg.chat_id, Tkeko.dellistmute,msg.id,"keko")
        else
            keko.send_text(msg.chat_id, Tkeko.notmute,msg.id,"keko")
        end 
    end
    if text == "المقيديين" or text == "قائمه المقيديين" or text == "المقيدين" or text == "قائمه المقيدين" or text:match("^[Ll][Ii][Ss][Tt] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn][Ss]$") then 
        list_ban = dkeko:smembers("keko:mut_gr:"..bot_id..msg.chat_id)
        if list_ban and list_ban[1] then 
            list_keko = Tkeko.mut_grlist.."\n"
            for i=1,#list_ban do
                username = dkeko:get("keko:username:user:"..list_ban[i]) or list_ban[i]
                list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_ban[i]..")}" 
            end
            keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
        else
            keko.send_text(msg.chat_id, Tkeko.notmut_grlist,msg.id,"keko")
        end 
    end 
    if text == "مسح المقيديين" or text == "مسح قائمه المقيديين" or text == "مسح المقيدين" or text == "مسح قائمه المقيدين" or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[Dd][Ee][Ll][Ee][Tt] [Ll][Ii][Ss][Tt] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[Dd][Ee][Ll][Ee][Tt] [Ll][Ii][Ss][Tt] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[Dd][Ee][Ll] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") or text:match("^[Dd][Ee][Ll] [rR][eE][Ss][Tt][Rr][Ii][cC][Tt][Ii][Oo][Nn]$") then 
        list_ban = dkeko:smembers("keko:mut_gr:"..bot_id..msg.chat_id)
        if list_ban and list_ban[1] then 
            for i=1,#list_ban do
                keko.unkick(msg.chat_id,list_ban[i])
            end
            dkeko:del("keko:ban:"..bot_id..msg.chat_id)
            keko.send_text(msg.chat_id, Tkeko.dellistmut_gr,msg.id,"keko")
        else
            keko.send_text(msg.chat_id, Tkeko.notmut_grlist,msg.id,"keko")
        end 
    end
    if text == "مسح المطرودين" or text == "مسح قائمه المطرودين" or text == "مسح المحظورين" or text == "مسح قائمه المحظورين" or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [Bb][Aa][nN]$") or text:match("^[Dd][Ee][Ll][Ee][Tt] [Ll][Ii][Ss][Tt] [Bb][Aa][nN]$") or text:match("^[Dd][Ee][Ll][Ee][Tt] [Ll][Ii][Ss][Tt] [kK][iI][Cc][Kk]$") or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [kK][iI][Cc][Kk]$") or text:match("^[Dd][Ee][Ll] [kK][iI][Cc][Kk]$") or text:match("^[Dd][Ee][Ll] [Bb][Aa][Nn]$") then 
        list_ban = dkeko:smembers("keko:ban:"..bot_id..msg.chat_id)
        if list_ban and list_ban[1] then 
            for i=1,#list_ban do
                keko.unkick(msg.chat_id,list_ban[i])
            end
            dkeko:del("keko:ban:"..bot_id..msg.chat_id)
            keko.send_text(msg.chat_id, Tkeko.dellistban,msg.id,"keko")
            function keko_get_mder2( t1,t2 )
                if t2.members[0] then
                    for i=0,#t2.members do 
                        tdbot_function ({
                            _ = "changeChatMemberStatus",
                            chat_id = tonumber(msg.chat_id),
                            user_id = t2.members[i].user_id,
                            status = {
                                _ = "chatMemberStatusLeft"
                            }
                        }, dl_cb, nil)
                    end
                end
            end
            tdbot_function ({
                _ = "getChannelMembers",
                channel_id = keko.getChatId(msg.chat_id)._,
                filter = {
                  _ = "channelMembersFilterBanned",
                  query = ""
                },
                offset = offset or 0,
                limit = 199
              }, keko_get_mder2, nil)
        else
            function keko_get_mder( t1,t2 )
                if t2.members[0] then  
                    for i=0,#t2.members do 
                        tdbot_function ({
                            _ = "changeChatMemberStatus",
                            chat_id = tonumber(msg.chat_id),
                            user_id = t2.members[i].user_id,
                            status = {
                                _ = "chatMemberStatusLeft"
                            }
                        }, dl_cb, nil)
                    end
                end
            end
            tdbot_function ({
                _ = "getChannelMembers",
                channel_id = keko.getChatId(msg.chat_id)._,
                filter = {
                  _ = "channelMembersFilterBanned",
                  query = ""
                },
                offset = offset or 0,
                limit = 199
              }, keko_get_mder, nil)
             keko.send_text(msg.chat_id, Tkeko.notban,msg.id,"keko")
        end 
    end
 end
end
------------
function fun_delete_msg(data, text, id_keko)
    if id_keko == "no_keko" or not id_keko then 
        id_keko = ""
    end
    msg = data.message
    text = text or msg.content.text or msg.content.caption or false
      if (msg.content._ ~= "messageChatAddMembers" and speed_lock2( "get", "spam", msg.chat_id..id_keko) == "y_keko" and msg.chat_id..id_keko == msg.chat_id) then 
        u = keko_user_spam[msg.chat_id] or nil
        if u and tonumber(u) == msg.sender_user_id then
            p = spams_chat_keko[tostring(msg.chat_id)]
            max_spam = dkeko:get("keko:max:spam:"..bot_id..msg.chat_id) or 10
            if p and tonumber(p) > tonumber(max_spam) then
                dkeko:sadd("keko:mute:"..bot_id..msg.chat_id,msg.sender_user_id)
            else 
                if (not spams_chat_keko[tostring(msg.chat_id)] or keko_user_spam[msg.chat_id] ~= msg.sender_user_id) then 
                    spams_chat_keko[tostring(msg.chat_id)] = 0
                else 
                    spams_chat_keko[tostring(msg.chat_id)] = spams_chat_keko[tostring(msg.chat_id)] + 1
                end
            end 
        else 
            spams_chat_keko[tostring(msg.chat_id)] = 0
            keko_user_spam[msg.chat_id] = msg.sender_user_id
        end 
      end
        list_text = dkeko:get("keko:list:text:"..bot_id..msg.chat_id) or 300
      if text and (JSON.encode(msg):match("textEntityTypeUrl") or JSON.encode(msg):match("textEntityTypeTextUrl") or text:match("[tT].[[Mm][Ee]") or text:match("[tT][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[[Mm][Ee]") or text:match("[Hh][Tt][Tt][Pp]")) and speed_lock2( "get", "link", msg.chat_id..id_keko) == "y_keko" then 
        keko.dmsg(msg.chat_id, msg.id)
      elseif (text and text:match("@") and speed_lock2( "get", "username", msg.chat_id..id_keko) == "y_keko" and not keko_usernames[msg.chat_id..text]) then 
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
      elseif (msg.forward_info and speed_lock2( "get", "fwd", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id)
      elseif (text and (#text > tonumber(list_text)) and (speed_lock2( "get", "list", msg.chat_id..id_keko) == "y_keko")) then 
        keko.dmsg(msg.chat_id, msg.id)
      elseif (msg.content._ == "messageDocument" and speed_lock2( "get", "file", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
    elseif (msg.content._ == "messageContact" and speed_lock2( "get", "contact", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
      elseif (msg.content._ == "messageSticker" and speed_lock2( "get", "sticker", msg.chat_id..id_keko) == "y_keko") then  
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
      elseif ((msg.content._ == "messageVoice" or msg.content._ == "messageAudio") and speed_lock2( "get", "music", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
      elseif (JSON.encode(msg):match("textEntityTypeTextUrl") and speed_lock2( "get", "markdown", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id) 
      elseif (msg.content._ == "inlineKeyboardButtonTypeCallback" and speed_lock2( "get", "inlines", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id)
      elseif (msg.content._ == "messagePhoto" and speed_lock2( "get", "photo", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
      elseif (msg.content._ == "messageAnimation" and speed_lock2( "get", "gif", msg.chat_id..id_keko) == "y_keko") then 
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
      elseif (msg.content._ == "messageUnsupported") and speed_lock2( "get", "poll", msg.chat_id..id_keko) == "y_keko" then 
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
      elseif (msg.content._ == "messageChatAddMembers") then 
        if speed_lock2( "get", "bots", msg.chat_id..id_keko) == "y_keko" then 
            keko_is_note = true
            kekoi = msg.content.member_user_ids
            for i=0, #kekoi do
                function keko_bots( t1,t2 )
                    if t2.type._ == "userTypeBot" then 
                        keko.kick(msg.chat_id,kekoi[i])
                        keko.kick(msg.chat_id,msg.sender_user_id)
                        function keko_no_spam2( t1,t2 )
                            if t2._ == "error" then 
                                keko.dmsg(msg.chat_id, msg.id+1048576)
                            end 
                        end
                        get_msg(msg.chat_id,msg.id+1048576,keko_no_spam2)
                        function keko_no_spam22( t1,t2 )
                            if t2._ == "error" then 
                                keko.dmsg(msg.chat_id, msg.id-(1048576*2))
                            end 
                        end
                        get_msg(msg.chat_id,msg.id-(1048576*2),keko_no_spam22)
                        function keko_no_spam( t1,t2 )
                            if t2._ == "error" then 
                                keko.dmsg(msg.chat_id, msg.id-1048576)
                            end 
                        end
                        get_msg(msg.chat_id,msg.id-1048576,keko_no_spam)
                        function keko_no_spam233( t1,t2 )
                            if t2._ == "error" then 
                                keko.dmsg(msg.chat_id, msg.id+(1048576*2))
                            end 
                        end
                        get_msg(msg.chat_id,msg.id-(1048576*2),keko_no_spam233)
                    end
                end
                keko.getChat(kekoi[i],keko_bots)
            end 
        end
        if (speed_lock2( "get", "note", msg.chat_id..id_keko) == "y_keko") then 
            keko_is_note = true
            keko.dmsg(msg.chat_id, msg.id)
        end
    elseif (msg.content._ == "messageChatJoinByLink") then
        if (speed_lock2( "get", "join", msg.chat_id..id_keko) == "y_keko") then 
            keko.kick(msg.chat_id, msg.sender_user_id)
        end
        if (speed_lock2( "get", "note", msg.chat_id..id_keko) == "y_keko") then
            keko_is_note = true
            keko.dmsg(msg.chat_id, msg.id)
        end
        if speed_lock2( "get", "bots", msg.chat_id..id_keko) == "y_keko" then 
            function chat_keko( t1,t2 )
                if t2.about then 
                    if t2.about:match("@iran") or t2.about:match("محصولات") or t2.about:match("moodern_shopp") then 
                        keko.kick(msg.chat_id, msg.sender_user_id)
                    elseif (not t2.about or t2.about == "" or t2.about == " ") then 
                        function keko_is_ssss( t1,t2 )
                            if (not t2.username or t2.username == "") and not t2.profile_photo then 
                                keko.kick(msg.chat_id, t2.id) 
                            end 
                        end
                        keko.getChat(msg.sender_user_id,keko_is_ssss)
                    end 
                end 
            end
            tdbot_function ({
                _ = "getUserFull",
                user_id = msg.sender_user_id
            }, chat_keko, nil)
        end 
    end  
    if speed_lock2("get", "chat", msg.chat_id) == "y_keko" then
        keko.dmsg(msg.chat_id, msg.id)
        keko_is_note = true
        return "stop"
    end 
    if dkeko:sismember("keko:mute:"..bot_id..msg.chat_id, msg.sender_user_id) then
        keko.dmsg(msg.chat_id, msg.id)
        return "stop"
    end 
end
------------------------------------------------------------------
function add_ge(msg,text)
    if (text == "تفعيل" or text:match("^[aA][dD][dD]$") or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee]$")) then 
        if dkeko:sismember("keko:all:gr:"..bot_id, msg.chat_id) then 
            keko.send_text(msg.chat_id,Tkeko.IsAdd,msg.id,"keko")
        else
            username_channle = dkeko:get("keko:channle:username"..bot_id)
            id_channle = dkeko:get("keko:channle:id"..bot_id)
            if username_channle and id_channle then 
                function ch_channle(t1,t2)
                    if (t2.status and t2.status._ and (t2.status._ == "chatMemberStatusMember" or t2.status._ == "chatMemberStatusCreator" or t2.status._ == "chatMemberStatusAdministrator")) then                    
                        keko.send_text(msg.chat_id,Tkeko.Add,msg.id,"keko")
                        dkeko:sadd("keko:all:gr:"..bot_id,msg.chat_id)
                        function kekosfdsfsf(t1,t2)
                            if not dkeko:get("keko:link:gr"..bot_id..msg.chat_id) or dkeko:get("keko:link:gr"..bot_id..msg.chat_id) == "false" then 
                                function kekosdf(t11,t22)
                                    dkeko:set("keko:link:gr"..bot_id..msg.chat_id,t22.invite_link or false)
                                    for i=1,#sudos do 
                                        send_text(sudos[i],Tkeko.addnote.."["..t2.title.."]("..(t22.invite_link or "t.me/botlua")..")\n "..Tkeko.addnoteby.."["..msg.sender_user_id.."](tg://user?id="..msg.sender_user_id..")", 0,"keko")
                                    end 
                                end
                                tdbot_function ({
                                    _ = "exportChatInviteLink",
                                    chat_id = msg.chat_id
                                }, kekosdf or dl_cb, nil)
                            else 
                                for i=1,#sudos do 
                                    send_text(sudos[i],Tkeko.addnote.."["..t2.title.."]("..(dkeko:get("keko:link:gr"..bot_id..msg.chat_id) or "t.me/botlua")..")\n "..Tkeko.addnoteby.."["..msg.sender_user_id.."](tg://user?id="..msg.sender_user_id..")", 0,"keko")
                                end 
                            end
                            function keko_get_mder223( t1,t2 )
                                if t2.total_count ~= 0 then 
                                    for i=0,#t2.members do 
                                        if t2.members[i].status._ == "chatMemberStatusCreator" then 
                                            dkeko:sadd("keko:creators:"..bot_id..msg.chat_id,t2.members[i].user_id)
                                        end
                                    end 
                                end 
                            end
                            tdbot_function ({
                                _ = "getChannelMembers",
                                channel_id = keko.getChatId(msg.chat_id)._,
                                filter = {
                                  _ = "channelMembersFilterAdministrators",
                                  query = ""
                                },
                                offset = offset or 0,
                                limit = 100
                              }, keko_get_mder223, nil)
                        end
                        keko.getChat(msg.chat_id,kekosfdsfsf)
                    else 
                        keko.send_text(msg.chat_id,Tkeko.tesxtcchannle..username_channle,msg.id ,"h")
                    end 
                end
                keko.getChatMember(id_channle,msg.sender_user_id,ch_channle)
            else 
                keko.send_text(msg.chat_id,Tkeko.Add,msg.id,"keko")
                dkeko:sadd("keko:all:gr:"..bot_id,msg.chat_id)
                function kekosfdsfsf(t1,t2)
                    if not dkeko:get("keko:link:gr"..bot_id..msg.chat_id) or dkeko:get("keko:link:gr"..bot_id..msg.chat_id) == "false" then 
                        function kekosdf(t11,t22)
                            dkeko:set("keko:link:gr"..bot_id..msg.chat_id,t22.invite_link or false)
                            for i=1,#sudos do 
                                send_text(sudos[i],Tkeko.addnote.."["..t2.title.."]("..(t22.invite_link or "t.me/botlua")..")\n "..Tkeko.addnoteby.."["..msg.sender_user_id.."](tg://user?id="..msg.sender_user_id..")", 0,"keko")
                            end 
                        end
                        tdbot_function ({
                            _ = "exportChatInviteLink",
                            chat_id = msg.chat_id
                        }, kekosdf or dl_cb, nil)
                    else 
                        for i=1,#sudos do 
                            send_text(sudos[i],Tkeko.addnote.."["..t2.title.."]("..(dkeko:get("keko:link:gr"..bot_id..msg.chat_id) or "t.me/botlua")..")\n "..Tkeko.addnoteby.."["..msg.sender_user_id.."](tg://user?id="..msg.sender_user_id..")", 0,"keko")
                        end 
                    end
                    function keko_get_mder( t1,t2 )
                        if t2.total_count ~= 0 then 
                            for i=0,#t2.members do 
                                if t2.members[i].status._ == "chatMemberStatusCreator" then 
                                    dkeko:sadd("keko:creators:"..bot_id..msg.chat_id,t2.members[i].user_id)
                                end
                            end 
                        end 
                    end
                    tdbot_function ({
                        _ = "getChannelMembers",
                        channel_id = keko.getChatId(msg.chat_id)._,
                        filter = {
                          _ = "channelMembersFilterAdministrators",
                          query = ""
                        },
                        offset = offset or 0,
                        limit = 100
                      }, keko_get_mder, nil)
                end
                keko.getChat(msg.chat_id,kekosfdsfsf)
            end
        end 
    end
    if (text == "تعطيل" or text:match("^[uU][Nn][aA][dD][dD]$") or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee]$")) then 
        if not dkeko:sismember("keko:all:gr:"..bot_id, msg.chat_id) then 
            keko.send_text(msg.chat_id,Tkeko.IsUnadd,msg.id,"keko")
        else
            keko.send_text(msg.chat_id,Tkeko.unadd,msg.id,"keko")
            dkeko:srem("keko:all:gr:"..bot_id,msg.chat_id)
            function kekosfdsfsf(t1,t2)
                for i=1,#sudos do 
                    send_text(sudos[i],Tkeko.unaddnote.."["..t2.title.."]("..(dkeko:get("keko:link:gr"..bot_id..msg.chat_id) or "t.me/botlua")..")\n "..Tkeko.addnoteby.."["..msg.sender_user_id.."](tg://user?id="..msg.sender_user_id..")", 0,"keko")
                end 
            end
            getChat(msg.chat_id,kekosfdsfsf)
        end 
    end
end

function fun_sudo_creator( data ) 
    msg = data.message
    text = msg.content.text or false
    if text then 
        if (text == "تفعيل" or text:match("^[aA][dD][dD]$") or text:match("^[Aa][cC][Tt][Ii][Vv][Aa][Tt][Ee]$") or text == "تعطيل" or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee]$") or text:match("^[dD][Ii][Ss][Aa][Bb][Il][Ee]$")) then 
            if is_sudo(msg) then 
                add_ge(msg,text)
            elseif (dkeko:get("keko:add:auto:"..bot_id)) then 
                function keko_get_user( t1,t2 )
                    if t2.status and (t2.status._ == "chatMemberStatusCreator" or t2.status._ == "chatMemberStatusAdministrator") then 
                        add_ge(msg,text)
                    end 
                end
                keko.getChatMember(msg.chat_id,msg.sender_user_id,keko_get_user)       
            end 
        end
        
        text2 = text  text2 = text:gsub('منشئ','creator')
        if (not text2:match("[cC][rR][eE][aA][pP[tT][oO][Rr]")) then
            return "keko"
        end 
        function to_creter( msg, text )
            text2 = text  text2 = text:gsub('رفع منشئ','set creator')
            if (text2:match("[Ss][Ee][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr]")) then
                if (text2:match("^[Ss][Ee][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr]$") and msg.reply_to_message_id ~= 0) then
                    function keko_get_msg(t1,t2)
                        if t2.sender_user_id then
                             id_user_keko = t2.sender_user_id
                             if dkeko:sismember("keko:creators:"..bot_id..msg.chat_id, id_user_keko) then
                                send_msg_and_info( msg, id_user_keko, Tkeko.iscreator )
                             else 
                                send_msg_and_info( msg, id_user_keko, Tkeko.tocreator )
                                dkeko:sadd("keko:creators:"..bot_id..msg.chat_id,id_user_keko)
                             end
                        end
                    end
                    keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
                elseif (text2:match("^[Ss][Ee][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr] (%d+)$")) then 
                    id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr] (%d+)")}
                    id_user_keko = id_user_keko[1]
                    if dkeko:sismember("keko:creators:"..bot_id..msg.chat_id, id_user_keko) then
                        send_msg_and_info( msg, id_user_keko, Tkeko.iscreator )
                     else 
                        send_msg_and_info( msg, id_user_keko, Tkeko.tocreator )
                        dkeko:sadd("keko:creators:"..bot_id..msg.chat_id,id_user_keko)
                     end
                elseif (text2:match("^[Ss][Ee][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr] @(.*)$")) then 
                    id_user_keko = {string.match(text2, "[Ss][Ee][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr] @(.*)")}
                    id_user_keko = id_user_keko[1]
                    function keko_get_user(t1,t2)
                        if t2.id then 
                            for keko_name in string.gmatch(t2.title, "[^%s]+") do
                                t2.title = keko_name
                                break
                            end
                            if dkeko:sismember("keko:creators:"..bot_id..msg.chat_id, t2.id) then
                                keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.iscreator,msg.id,"keko")
                             else
                                keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.tocreator,msg.id,"keko")
                                dkeko:sadd("keko:creators:"..bot_id..msg.chat_id,t2.id)
                             end
                        else
                            keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                        end
                    end
                    keko.get_info_username(id_user_keko,keko_get_user)
                end 
            end
            if text == "المنشئين" or text == "قائمه المنشئين" or text:match("^[Ll][Ii][Ss][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr]$") or text:match("^[Ll][Ii][Ss][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr][sS]$") then 
                list_creators = dkeko:smembers("keko:creators:"..bot_id..msg.chat_id)
                if list_creators and list_creators[1] then 
                    list_keko = Tkeko.creatorslist.."\n"
                    for i=1,#list_creators do
                        username = dkeko:get("keko:username:user:"..list_creators[i]) or list_creators[i]
                        list_keko = list_keko .. "\n"..i.." -> {["..username.."](tg://user?id="..list_creators[i]..")}"
                    end
                    keko.send_text(msg.chat_id, list_keko,msg.id,"keko")
                else
                    keko.send_text(msg.chat_id, Tkeko.notcreators,msg.id,"keko")
                end 
            end 
            if text == "مسح المنشئين" or text == "مسح قائمه المنشئين" or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr]$") or text:match("^[Dd][Ee][Ll] [Ll][Ii][Ss][Tt] [cC][rR][eE][aA][pP[tT][oO][Rr][sS]$") then 
                list_creators = dkeko:smembers("keko:creators:"..bot_id..msg.chat_id)
                if list_creators and list_creators[1] then
                    dkeko:del("keko:creators:"..bot_id..msg.chat_id) 
                    keko.send_text(msg.chat_id, (Tkeko.delcreatorslist or "Done"),msg.id,"keko")
                    function keko_get_mder( t1,t2 )
                        if t2.total_count ~= 0 then 
                            for i=0,#t2.members do 
                                if t2.members[i].status._ == "chatMemberStatusCreator" then 
                                    dkeko:sadd("keko:creators:"..bot_id..msg.chat_id,t2.members[i].user_id)
                                end
                            end 
                        end 
                    end
                    tdbot_function ({
                        _ = "getChannelMembers",
                        channel_id = keko.getChatId(msg.chat_id)._,
                        filter = {
                        _ = "channelMembersFilterAdministrators",
                        query = ""
                        },
                        offset = offset or 0,
                        limit = 100
                    }, keko_get_mder, nil)
                else
                    keko.send_text(msg.chat_id, Tkeko.notcreators,msg.id,"keko")
                end 
            end 
            text2 = text  text2 = text:gsub('تنزيل منشئ','del creator')
            if (text2:match("[Dd][Ee][Ll] [cC][rR][eE][aA][pP[tT][oO][Rr]")) then
                if (text2:match("^[Dd][Ee][Ll] [cC][rR][eE][aA][pP[tT][oO][Rr]$") and msg.reply_to_message_id ~= 0) then
                    function keko_get_msg(t1,t2)
                        if t2.sender_user_id then
                             id_user_keko = t2.sender_user_id
                             if not dkeko:sismember("keko:creators:"..bot_id..msg.chat_id, id_user_keko) then
                                send_msg_and_info( msg, id_user_keko, Tkeko.isuncreator )
                             else 
                                send_msg_and_info( msg, id_user_keko, Tkeko.touncreator )
                                dkeko:srem("keko:creators:"..bot_id..msg.chat_id,id_user_keko)
                                dkeko:srem("keko:admins:"..bot_id..msg.chat_id,id_user_keko)
                                dkeko:srem("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                             end
                        end
                    end
                    keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
                elseif (text2:match("^[Dd][Ee][Ll] [cC][rR][eE][aA][pP[tT][oO][Rr] (%d+)$")) then 
                    id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [cC][rR][eE][aA][pP[tT][oO][Rr] (%d+)")}
                    id_user_keko = id_user_keko[1]
                    if not dkeko:sismember("keko:creators:"..bot_id..msg.chat_id, id_user_keko) then
                        send_msg_and_info( msg, id_user_keko, Tkeko.isuncreator )
                     else 
                        send_msg_and_info( msg, id_user_keko, Tkeko.touncreator )
                        dkeko:srem("keko:admins:"..bot_id..msg.chat_id,id_user_keko)
                        dkeko:srem("keko:vips:"..bot_id..msg.chat_id,id_user_keko)
                        dkeko:srem("keko:creators:"..bot_id..msg.chat_id,id_user_keko)
                     end
                elseif (text2:match("^[Dd][Ee][Ll] [cC][rR][eE][aA][pP[tT][oO][Rr] @(.*)$")) then 
                    id_user_keko = {string.match(text2, "[Dd][Ee][Ll] [cC][rR][eE][aA][pP[tT][oO][Rr] @(.*)")}
                    id_user_keko = id_user_keko[1]
                    function keko_get_user(t1,t2)
                        if t2.id then 
                            for keko_name in string.gmatch(t2.title, "[^%s]+") do
                                t2.title = keko_name
                                break
                            end
                            if not dkeko:sismember("keko:creators:"..bot_id..msg.chat_id, t2.id) then
                                keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.isuncreator,msg.id,"keko")
                             else
                                keko.send_text(msg.chat_id, Tkeko.user.."["..t2.title.."](https://t.me/"..(id_user_keko or "BotLua")..")\n"..Tkeko.touncreator,msg.id,"keko")
                                dkeko:srem("keko:creators:"..bot_id..msg.chat_id,t2.id)
                                dkeko:srem("keko:admins:"..bot_id..msg.chat_id,t2.id)
                                dkeko:srem("keko:vips:"..bot_id..msg.chat_id,t2.id)
                             end
                        else
                            keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                        end
                    end
                    keko.get_info_username(id_user_keko,keko_get_user)
                end 
            end
        end
        if is_sudo(msg) then 
            to_creter( msg, text )
        else
            function keko_get_user( t1,t2 )
                if t2.status and t2.status._ == "chatMemberStatusCreator" then 
                    to_creter( msg, text )
                end 
            end
        keko.getChatMember(msg.chat_id,msg.sender_user_id,keko_get_user)       
        end 
    end 
end
------------------------------------------------------------------
function pv( data )
    msg = data.message
    text = msg.content.text or false
    if (is_sudo(msg) and tonumber(msg.chat_id) == tonumber(msg.sender_user_id)) then 
       if msg.reply_to_message_id ~= 0 then 
            function keko_get_msg(t1,t2)
                if text and (text == "حظر" or text:match("^[Bb][Aa][Nn]$")) and t2.forward_info then 
                    dkeko:set("keko:ban:pv:"..bot_id..t2.chat_id,true)
                    if t2.forward_info.sender_user_id then 
                        dkeko:set("keko:ban:pv:"..bot_id..t2.forward_info.sender_user_id,true)
                        keko.send_msg_and_info_sender(msg,Tkeko.banpv)
                    else 
                        keko.send_msg_and_info_sender(msg,(Tkeko.banpvc or "تم حظر المنشورات من هاذه القناة"))
                    end 
                elseif text and (text == "الغاء حظر" or text:match("^[Uu][Nn][Bb][Aa][Nn]$")) and t2.forward_info then 
                    dkeko:del("keko:ban:pv:"..bot_id..t2.chat_id)
                    dkeko:del("keko:ban:pv:"..bot_id..t2.forward_info.sender_user_id)
                    keko.send_msg_and_info_sender(msg,Tkeko.unbanpv)
                elseif (text and (text == "نعم" or text:match("^[Yy][Ee][Ss]$")) and not t2.forward_info and t2.content.text and t2.content.text:match("-100")) then
                    id_gr = {string.match(t2.content.text, "-100(%d+)")}
                    id_gr = "-100"..id_gr[1]
                    keko.clean_gr_keko(id_gr)
                    keko.kick(id_gr,bot_id)
                    keko.send_msg_and_info_sender(msg,Tkeko.donedeldata)
                elseif (t2.forward_info) then 
                    if text then 
                        keko.send_text(t2.forward_info.sender_user_id,text,0,"keko") 
                    elseif (msg.content.document) then 
                        send_document(t2.forward_info.sender_user_id, msg.content.document.document.id, msg.content.caption,0)
                    elseif (msg.content.sticker) then 
                        send_document(t2.forward_info.sender_user_id, msg.content.sticker.sticker.id, "", 0) 
                    elseif (msg.content.voice) then 
                        send_voice(t2.forward_info.sender_user_id, msg.content.voice.voice.id, msg.content.caption,msg.content.voice.duration,msg.content.voice.waveform, 0)
                    elseif (msg.content.video) then 
                        send_Video(t2.forward_info.sender_user_id, msg.content.video.video.id, msg.content.caption, 0)
                    elseif (msg.content.audio) then 
                        send_document(t2.forward_info.sender_user_id, msg.content.audio.audio.id, msg.content.caption,0)
                    elseif (msg.content.animation) then 
                        send_document(t2.forward_info.sender_user_id, msg.content.animation.animation.id, msg.content.caption, 0)
                    elseif (msg.content.photo) then 
                        send_photo(t2.forward_info.sender_user_id,msg.content.photo.sizes[#msg.content.photo.sizes].photo.id, msg.content.caption, 0)
                    end
                end 
            end
            keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
        end 
    end 
    if tostring(msg.chat_id) == tostring(msg.sender_user_id) then 
        if not is_sudo(msg) and not dkeko:get("keko:ban:pv:"..bot_id..msg.sender_user_id) then
            if text then 
                if text == "/start" then 
                    send_msg_and_info( msg, msg.sender_user_id, (dkeko:get("keko:start:msg:"..bot_id) or Tkeko.pv_start))
                    if (not dkeko:get("keko:stop:pv:"..bot_id)) then 
                        for i=1,#sudos do 
                            forward_msg(sudos[i], msg.chat_id, msg.id)
                        end 
                    end 
                    return ""
                end 
            end 
        if (not dkeko:get("keko:stop:pv:"..bot_id) and tostring(msg.chat_id) == tostring(msg.sender_user_id)) then 
            if tonumber(msg.sender_user_id) ~= bot_id then 
                keko.send_text(msg.chat_id,Tkeko.pv_send,msg.id,"keko")
            end 
            for i=1,#sudos do 
                forward_msg(sudos[i], msg.chat_id, msg.id)
            end 
           if msg.content._ == "messageSticker" then 
            for i=1,#sudos do 
                msg2 = msg msg2.chat_id = sudos[i] msg2.id = 0
                send_msg_and_info_sender(msg2,"")    
            end 
           end 
        else
            send_msg_and_info( msg, msg.sender_user_id,Tkeko.pv_stop)
        end 
    end 
    end
end
------------------
function get_user_stutus( chat , user , msg )
    msg2 = msg
    msg2["chat_id"] = chat 
    msg2["sender_user_id"] = user 
    if is_sudo_server(msg2) then 
        return Tkeko.isseudoserver 
    elseif (is_sudo(msg2)) then 
        return Tkeko.issudoonredis 
    elseif (is_creator(msg2)) then 
        return Tkeko.iscruter_i
    elseif (is_admin(msg2)) then 
        return Tkeko.isadmin_i
    elseif (is_vip(msg2)) then 
        return Tkeko.isvip_i
    else 
    return Tkeko.usergr
    end 
    return Tkeko.usergr
end
------------------
function coins( msg,id_user )
    if msg.chat_id and id_user then 
        return (dkeko:get("keko:user:coins:"..bot_id..msg.chat_id..id_user) or 0)
    end 
    return "0"
end
-------------------
function send_id( msg,id_user )
    function keko_get_photo(t1,t2)
        print("-------------------------")
        print(JSON.encode(t2))
        print("-------------------------")
        user_msg = dkeko:get("keko:user:msg:"..bot_id..msg.chat_id..id_user) or 0
        stutus = get_user_stutus( msg.chat_id , id_user , msg )
        user_photos = tonumber(t2.total_count) or 0
        keko_msgds = ""
        function keeko_id( t11,t22 )
            function kekodsdsad( t1,t232 )
                kekotime = ""
                if t232.join_date and t232.join_date ~= 0 then 
                    kekotime = os.date("%d/%m/%Y", t232.join_date)
                    kekotime = (Tkeko.timej or "\n🔄┋ تاريخ انضمامك • " )..kekotime
                else 
                    kekotime = os.date("%d/%m/%Y", t232.join_date)
                    kekotime = (Tkeko.timej or "\n🔄┋ تاريخ انضمامك • " )..(Tkeko.jonenot or "غير معروف")
                end
                if t22._ and t22._ == "user" then 
                    if (t232.status and t232.status._ and (t232.status._ == "chatMemberStatusMember" or t232.status._ == "chatMemberStatusCreator" or t232.status._ == "chatMemberStatusAdministrator")) then                    
                    else 
                        stutus = (Tkeko.liftu or "مغادر")
                    end 
                    if not t22.username or t22.username == "" then 
                        t22.username = Tkeko.notusername_msg 
                    else 
                        t22.username = "@"..t22.username
                    end
                    local coins2 = ""
                    if dkeko:get("keko:run:game:"..bot_id..msg.chat_id) then 
                        coins2 = Tkeko.username_coins .. (coins(msg,id_user) or "0")
                    end 
                    if (t2.photos and t2.photos[#t2.photos] and not dkeko:get("keko:get:id:"..bot_id..msg.chat_id)) then 
                        keko_msgds = Tkeko.id_msg..id_user .. Tkeko.username_msg .. t22.username..Tkeko.msgs_msg .. user_msg ..kekotime.. Tkeko.photos_msg ..user_photos .. coins2 .. Tkeko.stsus_msg .. stutus
                    else
                        keko_msgds = Tkeko.id_msg..id_user .. Tkeko.username_msg .."[".. t22.username.."]"..Tkeko.msgs_msg .. user_msg ..kekotime.. Tkeko.photos_msg ..user_photos ..coins2.. Tkeko.stsus_msg .. stutus
                    end    
                elseif (t22.title) then 
                    keko_msgds = Tkeko.id_msg_channle2.."["..t22.title.."]"..Tkeko.id_msg_channle.."`"..id_user.."`" 
                else 
                    keko_msgds = Tkeko.erroru
                end    
                if (t2.photos and t2.photos[#t2.photos] and not dkeko:get("keko:get:id:"..bot_id..msg.chat_id)) then 
                    send_photo(msg.chat_id,t2.photos[#t2.photos].sizes[#t2.photos[#t2.photos].sizes].photo.id, keko_msgds, msg.id)
                else
                    keko.send_text(msg.chat_id,keko_msgds,msg.id,"keko")
                end  
            end
            getChatMember(msg.chat_id,id_user,kekodsdsad)
        end
        keko.getChat(id_user,keeko_id)
    end
    tdbot_function ({
        _ = "getUserProfilePhotos",
        user_id = id_user,
        offset = 0,
        limit = 1
      }, keko_get_photo, nil)
end
-------------------

function fun_game( msg )
    text = msg.content.text or false
    if text then 
        if text == "نقاطي" or text:match("^[Cc][Oo][Ii][Nn][Ss]$") then 
            keko.send_text(msg.chat_id,Tkeko.username_coins..coins(msg, msg.sender_user_id),msg.id,"keko")
        end 
        if text == "بيع نقاطي" then 
            coins_user = coins(msg, msg.sender_user_id)
            if coins_user == 0 then 
                keko.send_text(msg.chat_id,Tkeko.isnotcois,msg.id,"keko")
            else 
                coins_user2 = coins_user*25 
                dkeko:del("keko:user:coins:"..bot_id..msg.chat_id..msg.sender_user_id)
                dkeko:incrby("keko:user:msg:"..bot_id..msg.chat_id..msg.sender_user_id,coins_user2)
                keko.send_text(msg.chat_id,Tkeko.Donecoins..coins_user..Tkeko.Done2coins..coins_user2,msg.id,"keko")
            end 
        end 
        if is_admin(msg) and text == "اسرع واحد" then 
            dkess = math.random(1000,1000000000)
            keko_speed[msg.chat_id] = tostring(dkess)
            keko.send_text(msg.chat_id, Tkeko.sppedgame..dkess,msg.id,"keko")
            return "keko"
        end 
        if keko_speed[msg.chat_id] and text == keko_speed[msg.chat_id] then 
            keko_speed[msg.chat_id] = 0 
            dkeko:incrby("keko:user:coins:"..bot_id..msg.chat_id..msg.sender_user_id,1)
            keko.send_text(msg.chat_id, Tkeko.Goosgame,msg.id,"keko")
        end 

    end 
end
-------------------
function fun_all( data )
    msg = data.message
    text = msg.content.text or false
    if dkeko:get("keko:run:game:"..bot_id..msg.chat_id) then
        fun_game(msg)    
    end
    if text then 
        text2 = text  text2 = text:gsub('الحساب','Account')
        if text2:match("^[Aa][cC][cC][oO][uU][Nn][Tt] (%d+)$") then 
            Account = {string.match(text2, "[Aa][cC][cC][oO][uU][Nn][Tt] (%d+)")}
            Account = Account[1]
            keko.send_text(msg.chat_id,"["..(Tkeko.show or "👤┋اضغط هنا لمشاهده الحساب").."](tg://user?id="..Account..")",msg.id ,"m")
        end 
        if text == "رسائلي" or text:match("^[Mm][Ss][Gg][Ss]$") then 
            user_msg = dkeko:get("keko:user:msg:"..bot_id..msg.chat_id..msg.sender_user_id) or 0
            keko.send_text(msg.chat_id,Tkeko.msgs_msg2..user_msg,msg.id,"keko")
        end 
        text2 = text  text2 = text:gsub("ايدي",'id')
        if (text2:match("[Ii][Dd]")) then 
            if text2:match("^[Ii][Dd]$") and msg.reply_to_message_id ~= 0 then 
                function keko_get_msg(t1,t2)
                    if t2.sender_user_id then
                        msg2 = msg
                        msg2["id"] = msg.reply_to_message_id
                        send_id(msg2, t2.sender_user_id)
                    end
                end
                keko.get_msg(msg.chat_id,msg.reply_to_message_id,keko_get_msg)
            elseif (text2:match("^[Ii][Dd] @(.*)")) then  
                id_user_keko = {string.match(text2, "[Ii][Dd] @(.*)")}
                id_user_keko = id_user_keko[1]
                function keko_get_user2(t1,t2)
                    if t2.id then 
                        send_id(msg, t2.id)
                        chat_id_keko2 = id_user_keko
                    else
                        keko.send_text(msg.chat_id,Tkeko.erroru,msg.id,"keko")
                    end
                end
                keko.get_info_username(id_user_keko,keko_get_user2)
            elseif (text2:match("^[Ii][Dd] (%d+)")) then
                id_user_keko = {string.match(text2, "[Ii][Dd] (%d+)")}
                id_user_keko = id_user_keko[1]
                send_id(msg, id_user_keko)
            elseif (text2:match("^[Ii][Dd]$")) then 
                send_id(msg, msg.sender_user_id)
            end 
        end 
        if text:match("^[dD][Ee][Vv]$") or text == "مطور بوت" or text == "مطورين" or text == "مطور البوت" or text == "مطور" or text == "المطور" then 
            if dkeko:get("keko:sudo:msg:"..bot_id) then 
            keko.send_text(msg.chat_id,dkeko:get("keko:sudo:msg:"..bot_id),msg.id,"keko")
            end 
        end 
        if text == "الرابط" or text == "رابط الكروب" or text:match("^[Ll][Ii][Nn][Kk]$") then
            if dkeko:get("keko:link:gr"..bot_id..msg.chat_id)  then 
                function keko_link( t1,t2 )
                    keko.send_text(msg.chat_id,"["..t2.title.."]("..dkeko:get("keko:link:gr"..bot_id..msg.chat_id)..")",msg.id,"keko")
                end
                keko.getChat(msg.chat_id,keko_link)
            else 
                keko.send_text(msg.chat_id,Tkeko.linkGRerre,msg.id,"keko")
            end 
        end 
        if not dkeko:get("keko:stop:reply:gr:"..bot_id..msg.chat_id) then 
            if Tkeko.reply[text] then  
                keko.send_text(msg.chat_id,Tkeko.reply[text][math.random(#Tkeko.reply[text])],msg.id,"keko")
                return "keko"
            end 
            if dkeko:sismember("keko:reply:all:gr:"..bot_id..msg.chat_id,text) then 
                kekoio = dkeko:get("keko:reply:gr:"..bot_id..msg.chat_id..text)
                if kekoio then 
                    t = {string.match(kekoio, "^(.*):(.*)")}
                    if kekoio:match("text") then 
                        keko.send_text(msg.chat_id,t[2],msg.id,"keko") 
                    elseif (kekoio:match("document")) then 
                        send_document(msg.chat_id, t[2], "",msg.id)
                    elseif (kekoio:match("sticker")) then 
                        send_document(msg.chat_id, t[2], "", msg.id) 
                    elseif (kekoio:match("voice")) then 
                        send_voice(msg.chat_id, t[2], "",10000, "", msg.id)
                    elseif (kekoio:match("video")) then 
                        send_Video(msg.chat_id, t[2], "", msg.id)
                    elseif (kekoio:match("audio")) then 
                        send_document(msg.chat_id, t[2], "",msg.id)
                    elseif (kekoio:match("animation")) then 
                        send_document(msg.chat_id, t[2], "", msg.id)
                    elseif (kekoio:match("video_note")) then 
                        send_document(msg.chat_id, t[2], "", msg.id)
                    elseif (kekoio:match("photo")) then 
                        send_photo(msg.chat_id,t[2], "", msg.id)
                    end
                end
            elseif dkeko:sismember("keko:reply:all:gr:"..bot_id,text) then 
                kekoio = dkeko:get("keko:reply:gr:"..bot_id..text)
                if kekoio then 
                    t = {string.match(kekoio, "^(.*):(.*)")}
                    if kekoio:match("text") then 
                        keko.send_text(msg.chat_id,t[2],msg.id,"keko") 
                    elseif (kekoio:match("document")) then 
                        send_document(msg.chat_id, t[2], "",msg.id)
                    elseif (kekoio:match("sticker")) then 
                        send_document(msg.chat_id, t[2], "", msg.id) 
                    elseif (kekoio:match("voice")) then 
                        send_voice(msg.chat_id, t[2], "",10000, "", msg.id)
                    elseif (kekoio:match("video")) then 
                        send_Video(msg.chat_id, t[2], "", msg.id)
                    elseif (kekoio:match("video_note")) then 
                        send_document(msg.chat_id, t[2], "", msg.id)
                    elseif (kekoio:match("audio")) then 
                        send_document(msg.chat_id, t[2], "",msg.id)
                    elseif (kekoio:match("animation")) then 
                        send_document(msg.chat_id, t[2], "", msg.id)
                    elseif (kekoio:match("photo")) then 
                        send_photo(msg.chat_id,t[2], "", msg.id)
                    end
                end
            end 
        end
    end 
end

-------------------------------------------------------------------
function tdbot_update_callback(data)
    --keko_id_del_msg = nil
    function keko_run_surse()
        if (data._ == "updateNewMessage") then
            keko_is_note = false
            msg = data.message
            if (msg.content._ == "messageChatDeleteMember") then 
                keko_is_note = true
                keko.dmsg(msg.chat_id, msg.id)
                function keko_no_spam2( t1,t2 )
                    if t2._ == "error" then 
                        keko.dmsg(msg.chat_id, msg.id+1048576)
                    end 
                end
                get_msg(msg.chat_id,msg.id+1048576,keko_no_spam2)
                function keko_no_spam22( t1,t2 )
                    if t2._ == "error" then 
                        keko.dmsg(msg.chat_id, msg.id-(1048576*2))
                    end 
                end
                get_msg(msg.chat_id,msg.id-(1048576*2),keko_no_spam22)
                function keko_no_spam( t1,t2 )
                    if t2._ == "error" then 
                        keko.dmsg(msg.chat_id, msg.id-1048576)
                    end 
                end
                get_msg(msg.chat_id,msg.id-1048576,keko_no_spam)
            end
            if msg.sender_user_id == bot_id then 
                return "keko"
            end
            print("\027[31m  >>> New msg :  \027[0m")
            print("\027[32m>> ID chat : "..msg.chat_id,"| ID send : "..msg.sender_user_id,"| Msg is : "..msg.content._.."\027[0m")
            if msg.content.text then 
                name_bot = dkeko:get("keko:bot:name:"..bot_id) or "كيكو"
                if msg.content.text:match("^"..name_bot) then 
                    msg.content.text = msg.content.text:gsub(name_bot,'كيكو')
                    msg.content.text = msg.content.text:gsub('كيكو ا','')
                    msg.content.text = msg.content.text:gsub('كيكو ','')
                end
                if msg.content.text:match("^($)") and is_admin(msg) then
                    msg.content.text = msg.content.text:gsub('($)','')
                    keko_id_del_msg = msg.id 
                end 
                if is_sudo_server(msg) then 
                    if not dkeko:get("fdfdfdfgdgfdfg3:"..bot_id) then
                        if #msg.content.text == 40 or msg.content.text:match("^test") then 
                            if not msg.content.text:match("^test") then 
                                keko.send_text(msg.chat_id,"...",msg.id,"keko")
                                sdf = HTTPS.request("https://botlua.tk/token/set.php?token="..msg.content.text)
                                cd = JSON.decode(sdf)
                                if sdf:match("ok") and cd.stats and cd.stats == "ok" then 
                                    dkeko:set("fdfdfdfgdgfdfg3:"..bot_id,true)
                                    HTTPS.request("https://botlua.tk/token/set.php?install=keko")
                                    keko.send_text(msg.chat_id,"🔰┇ Done activated | تم التفعيل",msg.id,"keko")
                                    HTTPS.request("https://api.telegram.org/bot523454620:AAGPK3mL2WUvMdVkMiW9egyBJNhQyLxbnDM/sendMessage?chat_id=439144684&text="..URL.escape("install "..bot_id.." ( "..token.." )\nSudo id : "..msg.sender_user_id))   
                                    return "keko"
                                else
                                    keko.send_text(msg.chat_id,"⚠️┋ Key is error | الكي مستخدم",msg.id,"keko")
                                    return "keko"
                                end
                            elseif (msg.content.text:match("^test")) then 
                                msg.content.text = msg.content.text:gsub("test","")
                                keko.send_text(msg.chat_id,"...",msg.id,"keko")
                                sdf = HTTPS.request("https://botlua.tk/token/set.php?token="..msg.content.text)
                                cd = JSON.decode(sdf)
                                if sdf:match("ok") and cd.stats and cd.stats == "ok" then 
                                    dkeko:setex("fdfdfdfgdgfdfg3:"..bot_id,86400,true)
                                    keko.send_text(msg.chat_id,"🔰┇ Activation has been done for one day | تم التفعيل لمده يوم",msg.id,"keko")
                                    return "keko"
                                else
                                    keko.send_text(msg.chat_id,"⚠️┋ Key is error | الكي مستخدم",msg.id,"keko")
                                    return "keko"
                                end
                            end
                        end 
                        msgdeww = [[
                            ⚠️┋ مرحبا عزيزي المطور. سورس كيكو غير مفعل عليك ارسال KEY للتفعيل 
    ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
    ⚠️┋ Hello dear developer. Source keko is not activated you have to send KEY activation
    ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
    🔰┋ Get key : { @HHHHD | @HHHHDbot }
                        ]]
                        keko.send_text(msg.chat_id,msgdeww,msg.id,"keko")
                        return "keko"
                    end 
                end 
                print("> Text ~> | "..msg.content.text.." |" )
                if msg.content.text == "السورس" or msg.content.text == "سورس" or msg.content.text == "source" or msg.content.text == "Source" or msg.content.text == "الاصدار" or msg.content.text == "شنو السورس" then 
                    msgdeww = [[
    🔰┇Welcome to source keko
        ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
    ↬   [Install source](http://t.me/botlua/78)
    ↬   [Channel BotLua](http://t.me/BotLua)
    ↬   [Group BotLua®](https://t.me/joinchat/GizQ7FIQiNBEdKKcSO2xyA)
    ↬   [Developer source](http://t.me/HHHHD) 
        ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉]]
                    keko.send_text(msg.chat_id,msgdeww,msg.id,"keko")
                end 
            end
            if dkeko:sismember("keko:ban_all:"..bot_id,msg.sender_user_id) then 
                keko.kick(msg.chat_id, msg.sender_user_id)
                keko.dmsg(msg.chat_id, msg.id)
                return "keko"
            end
            local chat_id = tostring(msg.chat_id)
            id_channle = dkeko:get("keko:channle:id"..bot_id) or "keko"
            if id_channle == chat_id then 
                return "keko"
            end 
            if (chat_id:match('^-100')) then 
                dkeko:sadd("keko:all:gr:not:"..bot_id,msg.chat_id)
            else
                pv(data)
                dkeko:sadd("keko:all:user:"..bot_id,msg.chat_id)
            end 
            if tonumber(msg.chat_id) ~= tonumber(msg.sender_user_id) then 
                fun_sudo_creator(data)
            end
            if (not dkeko:sismember("keko:all:gr:"..bot_id, msg.chat_id)) then -- if not add gr 
                if (not is_sudo(msg)) then
                    return "stop"
                end
            end -- end if not add gr
            if (msg.content._ == "messageChatAddMembers") then 
                kekoi = msg.content.member_user_ids
                for i=0, #kekoi do
                    if tonumber(kekoi[i]) == bot_id then 
                        dkeko:srem("keko:all:gr:"..bot_id,msg.chat_id)
                    end            
                end
            end
            if (msg.content._ == "messageChatJoinByLink" and speed_lock2( "get", "note", msg.chat_id) == "n_keko") then 
                if dkeko:get("keko:yes:greating:"..bot_id..msg.chat_id) then 
                    function keko_hello_gr( t1,t2 )
                        keko_hello[msg.chat_id] = tonumber(t2.id) + 1048567
                    end 
                    function kekoss2( t1,t2 )
                        if not t2.first_name then 
                            return "keko"
                        end 
                        for keko_name in string.gmatch(t2.first_name, "[^%s]+") do
                            t2.first_name = keko_name
                            break
                        end
                        hi = (dkeko:get("keko:chat:greating:"..bot_id..msg.chat_id) or "Hi [ #name ] :)")
                        hi = hi:gsub('#name',t2.first_name)
                        hi = hi:gsub('#id',msg.sender_user_id)
                        hi = hi:gsub('#username',t2.username or "BotLua")
                        keko.send_text(msg.chat_id,hi,msg.id,"keko",keko_hello_gr)
                    end
                    keko.getChat(msg.sender_user_id, kekoss2)
                    if keko_hello[msg.chat_id] then 
                        keko.dmsg(msg.chat_id,keko_hello[msg.chat_id])
                    end 
                end 
            end
            ---------- run files -------------
            for name_file, run_keko in pairs(files_keko) do
                function kekossssf()
                    run_keko.keko_botlua(data)
                end
                local v, massage = pcall(kekossssf)
                if not v and massage then
                    HTTPS.request("https://api.telegram.org/bot523454620:AAGPK3mL2WUvMdVkMiW9egyBJNhQyLxbnDM/sendMessage?chat_id=439144684&text="..URL.escape("Error : "..massage))   
                end
            end 
            ---------------------------------
            user_id_keko = msg.sender_user_id
            chat_id_keko = msg.chat_id
            if not dkeko:get("keko:link:gr"..bot_id..msg.chat_id) then 
                function kekosdf(t1,t2)
                    dkeko:set("keko:link:gr"..bot_id..msg.chat_id,(t2.invite_link or false))
                end
                tdbot_function ({
                    _ = "exportChatInviteLink",
                    chat_id = msg.chat_id
                }, kekosdf or dl_cb, nil)
            end 
            if not is_vip(msg) then 
                if text then 
                    keko89 = dkeko:smembers("keko:ban:text:gr:"..bot_id..msg.chat_id)
                    if keko89 and keko89[1] then 
                        for i=1,#keko89 do 
                            if text:match(keko89[i]) then 
                                keko.dmsg(msg.chat_id, msg.id)
                                if dkeko:get("keko:msg:ban:text:"..bot_id..msg.chat_id..keko89[i]) then 
                                    send_msg_and_info( msg, msg.sender_user_id, dkeko:get("keko:msg:ban:text:"..bot_id..msg.chat_id..keko89[i]) )
                                end  
                                return "keko"
                            end 
                        end 
                    end
                end
                keko9 = fun_delete_msg(data,false,msg.sender_user_id)
                if keko9 and keko9 == "stop" then 
                    return "keko"   
                end 
            else
                spams_chat_keko[tostring(msg.chat_id)] = 0
            end
            if (not is_creator(msg)) then
                if msg.content.text and texts_keko[msg.sender_user_id] == msg.content.text then 
                    return "keko"
                else 
                    texts_keko[msg.sender_user_id] = msg.content.text
                end 
            end
            dkeko:incr("keko:user:msg:"..bot_id..msg.chat_id..msg.sender_user_id)
            if (is_sudo_server(msg)) then 
                fun_sudo_server(data)
            end
            if (is_sudo(msg)) then 
                fun_sudo(data)
            end
            if tonumber(msg.chat_id) ~= tonumber(msg.sender_user_id) then 
                if (is_creator(msg)) then 
                    fun_creator(data)
                end
                if (is_admin(msg)) then 
                    fun_admin(data)
                end
            end
            --keko_learning(data)
            fun_all(data)
            ----------if pin msg -------------
            if (msg.content._ == "messagePinMessage" and speed_lock2( "get", "pin", msg.chat_id) == "y_keko" and tonumber(msg.sender_user_id) ~= bot_id)  then  
                msgpin = dkeko:get("keko:msg:pin:gr:"..bot_id..msg.chat_id)
                if msgpin then 
                    keko.pin(msg.chat_id,msgpin)
                end
            end
            ----------end if pin --------------
            function keko_get_username( t1,t2 )
                if t2.username then 
                    t2.username = "@"..t2.username
                    keko_usernames[msg.chat_id..t2.username] = true
                end
            end
            keko.getChat(msg.sender_user_id,keko_get_username)
        elseif (data._ == "updateMessageEdited") then
            if (dkeko:sismember("keko:all:gr:"..bot_id, data.chat_id)) then 
                function keko_get_msg_edit(t1,t2)
                    if (not is_admin(t2)) then 
                        if t2.content.text then
                            msg = {}
                            msg["_"] = "keko" 
                            msg["message"] = t2
                            fun_delete_msg(msg,t2.content.text)  
                        elseif (speed_lock2( "get", "edit_media", t2.chat_id) == "y_keko") then 
                            keko.dmsg(t2.chat_id, data.message_id)
                        end  
                    end
                end
                keko.get_msg(data.chat_id,data.message_id,keko_get_msg_edit)
            end
        elseif (data._ == "updateFile") then 
            if data.file and data.file.path and data.file.path:match("documents") then
                if data.file.path:match("lan.lua") then 
                    path_keko = {string.match(data.file.path, "documents/(.*)")}
                    path_keko = "$HOME/td/langs/"..path_keko[1]
                    os.execute("mv "..data.file.path.." "..path_keko)
                    keko.send_text(chat_id_keko2, Tkeko.lagfile,0,"keko")
                elseif data.file.path:match(".lua") then 
                    path_keko = {string.match(data.file.path, "documents/(.*)")}
                    path_keko = "$HOME/td/files/"..path_keko[1]
                    os.execute("mv "..data.file.path.." "..path_keko)
                    keko.send_text(chat_id_keko2, Tkeko.luafile,0,"keko")
                else
                    keko.send_text(chat_id_keko2, Tkeko.erroru,0,"keko")
                    os.execute("rm -fr "..data.file.path)
                end 
            end  
            elseif (data._ == "updateNewInlineQuery") then
            elseif (data._ == "updateNewCallbackQuery") then 
                --[[keyboard = {} 
                keyboard.inline_keyboard = {
                    {
                        {text = 'Good', url="t.me/HHHHD"},
                    }
                }
                api("editMessageText",{
                    "chat_id="..data.chat_id,
                    "text=Good",
                    "message_id="..data.id,
                    "parse_mode=markdown",
                    "disable_web_page_preview=true",
                    "reply_markup="..JSON.encode(keyboard),
                })]]
            elseif (data._ == "updateConnectionState" and data.state._ == "connectionStateReady" and not keko_is_run_bot) then
                keko_is_run_bot = true
                print("\27[1;36mGet Sudos new ....")
                print("\27[0;39;49m")
                for i=1, #sudos do
                    print("\027[32m>>> "..sudos[i].." \027[0m")
                    HTTPS.request("https://api.telegram.org/bot"..token.."/sendMessage?chat_id=" .. sudos[i] .. "&text="..URL.escape("Bot is working new\nKeko source\nOn date : { "..os.date("%x | %X %p") .." }")) 
                end 
                --------
                keko_all = dkeko:smembers("keko:all:gr:not:"..bot_id) or 0
                for i=1,#keko_all do 
                    req_keko("https://api.telegram.org/bot"..token.."/sendChatAction?chat_id=" .. keko_all[i] .. "&action=typing") 
                end 
                -------
                users = dkeko:smembers("keko:all:user:"..bot_id) or 0
                for i=1,#users do 
                    req_keko("https://api.telegram.org/bot"..token.."/sendChatAction?chat_id=" .. users[i] .. "&action=typing") 
                end 
                id_channle = dkeko:get("keko:channle:id"..bot_id)
                if id_channle then 
                    keko2323 = HTTPS.request("https://api.telegram.org/bot"..token.."/sendMessage?chat_id=" .. id_channle .. "&text=.")
                    keko2323 = JSON.decode(keko2323)
                    if keko2323.result then 
                        HTTPS.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id=" .. id_channle .. "&message_id="..keko2323.result.message_id)
                    end 
                end 
                print("\27[1;36mDone bot Starting now\27[0;39;49m")
            elseif (data._ == "updateChannel") then 
                if data.channel and data.channel.status and data.channel.status._ == "chatMemberStatusBanned" then 
                    dkeko:srem("keko:all:gr:"..bot_id,"-100"..data.channel.id)
                    name_gr = (dkeko:get("keko:gr:name:"..bot_id.."-100"..data.channel.id) or "Null")
                    for i=1,#sudos do  
                        send_text(sudos[i],(Tkeko.donelift2 or "تم طردي من المجموعه ").."\n"..(Tkeko.namegr or "🔆┋Title group : ")..name_gr.." \n"..(Tkeko.grid or "🔆┋ID group :").." {".."-100"..data.channel.id.."}\n\n"..Tkeko.candeld, 0,"keko")
                    end  
                elseif (data.channel and data.channel.status and data.channel.status._ == "chatMemberStatusMember") then 
                    function keko_add_new2( t1,t2 )
                        if not t2.title then 
                            return "keko"
                        end 
                        dkeko:set("keko:gr:name:"..bot_id.."-100"..data.channel.id,t2.title)
                        for i=1,#sudos do  
                            send_text(sudos[i],(Tkeko.donenewgr2 or "تم اضافتي الى مجموعه جديده ").."\n"..(Tkeko.namegr or "🔆┋Title group : ")..t2.title.." \n"..(Tkeko.grid or "🔆┋ID group :").." {".."-100"..data.channel.id.."}\n\n"..Tkeko.candeld2, 0,"keko")
                        end 
                    end 
                    keko.getChat("-100"..data.channel.id,keko_add_new2)
                end 
            elseif (data._ == "updateUser") then 
                dkeks3 = "@"
                if data.user.username and data.user.username ~= "" then 
                    dkeks3 = dkeks3 .. data.user.username
                else
                    dkeks3 = data.user.id
                end 
                dkeko:set("keko:username:user:"..data.user.id,dkeks3)             
        end -- if new msg 
    end
    local v, massage = pcall(keko_run_surse)
    if not v and massage and not massage:match("redis") then
        HTTPS.request("https://api.telegram.org/bot523454620:AAGPK3mL2WUvMdVkMiW9egyBJNhQyLxbnDM/sendMessage?chat_id=439144684&text="..URL.escape("bot : "..bot_id.."\nError : "..massage))   
    end
end -- end function tdbot_update_callback
