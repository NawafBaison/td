
function keko_botlua(data)
    if data then 
        msg = data.message
        text = msg.content.text or false 
        if text and text == "keko" then 
            keko.send_text(msg.chat_id,"Hi keko",msg.id,"keko")
        end
    end
end
return {
    keko_botlua = keko_botlua
}