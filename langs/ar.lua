local Tkeko = {}
-------------------------------------
Tkeko.BY = "⚠️┋ للمزيد من الملفات : @BotLua"
-------------------------------------
Tkeko.IsAdd = "⚠️┋المجموعه مفعله سابقا"
Tkeko.Add = "☑️┋تم تفعيل المجموعه بنجاح"
Tkeko.IsUnadd = "⚠️┋المجموعه معطله سابقا"
Tkeko.unadd = "🚫┋تم تعطيل المجموعه"
Tkeko.iscreator = "🔆┋بالفعل منشئ"
Tkeko.tocreator = "🔆┋تم رفعه منشئ"
Tkeko.isuncreator = "🔆┋بالفعل تم تنزيله من المنشئين"
Tkeko.touncreator = "🔆┋تم تنزيله من المنشئين"
Tkeko.issudo = "✅┋بالفعل مطور" 
Tkeko.isaddfile = "✅┋الملف مفعل مسبقا"
Tkeko.isunaddfile = "🗂┋الملف معطل مسبقا"
Tkeko.okaddreply = "🔊┋تم اضافه الرد بنجاح"
Tkeko.notreply = "🔇┋لا يوجد هكذا رد"
Tkeko.delreply = "🗑┋تم حذف الرد"
Tkeko.listreply = "📄┋قائمه ردود الكروب : "
Tkeko.repletstoped = "🔇┋الردود معطله مسبقا"
Tkeko.repletstop = "🔇┋تم تعطيل الردود بنجاح"
Tkeko.repletstart = "🔊┋تم تفعيل الردود بنجاح"
Tkeko.repletstarted = "🔊┋الردود مفعله مسبقا"
Tkeko.leave = "🔖┋تم مغادره المجموعه"
------------------------------
Tkeko.help = [[
📌┇هناكـ {5} اوامر لعرضها
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🔐┇م1  ← آوآمر آلحمايه 

📍┇م2 ← آوآمر آلآدمنيه

📝┇م3 ← آوآمر آلمنشئ

⚒┇م4 ← آوآمر المطور 

🔧┇م5 ← اوامر المطور الاساسي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
]]

Tkeko.h1 = [[
    
📮┇ اوامر حمايه المجموعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🔖┇قفل/فتح + الاوامر الادناه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🔖┇الروابط
🔖┇ المعرف
🔖┇التاك
🔖┇الشارحه
🔖┇التعديل
🔖┇التثبيت
🔖┇ المتحركه
🔖┇الملفات
🔖┇الصور
🔖┇الملصقات
🔖┇الفيديو
🔖┇ الانلاين
🔖┇الدردشه
🔖┇ التوجيه
🔖┇الاغاني
🔖┇الصوت
🔖┇الجهات
🔖┇الاشعارات
🔖┇الماركدون
🔖┇البوتات
🔖┇العربيه
🔖┇الانكليزية
🔖┇الميديا
🔖┇التكرار
🔖┇الكلايش

┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
]]

Tkeko.h2 = [[
📮┇ اوامر الادمنيه 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🚫┇كتم [ رد , معرف ، ايدي ]
🚫┇حظر [ رد , معرف ، ايدي ]
🚫┇تقييد [ رد , معرف ، ايدي ]

⛔️┇الغاء كتم [ رد , معرف ، ايدي ]
⛔️┇الغاء حظر [ رد , معرف ، ايدي ]
⛔️┇الغاء تقييد [ رد , معرف ، ايدي ]

📖┇المكتومين  
📖┇المحظورين 
📖┇المقيديين 
📖┇الردود 

🗑┇مسح المكتومين  
🗑┇مسح المحظورين 
🗑┇مسح المقيديين
🗑┇مسح الدردود 

📜┇اضف رد الكلمه [ رد على النص او الميديا ]
🗑┇حذف رد الكلمه 


📃┇الاعدادات 
🗒┇الاعدادات بالرد او معرف او ايدي

🔏┇منع كلمه / الغاء منع الكلمه 

⚙️┇تعطيل / تفعيل الردود 
⚙️┇تعطيل / تفعيل الايدي
⚙️┇تعطيل / تفعيل التقيد 

🔗┇وضع رابط 
📝┇تعين عدد التكرار العدد
📝┇تعين عدد الكليشه العدد
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
]]

Tkeko.h3 = [[ 
🔘┇وضع :- مع الاوامر ادناه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🌄┇وضع صوره بالرد عل صوره 

⌨️┇وضع وصف الوصف 
📚┇وضع اسم الاسم 

🗑┇تنظيف العدد

♦️┇رفع ادمن / تنزيل ادمن ( رد , ايدي , معرف )
♦️┇رفع ادمن بالكروب / تنزيل ادمن بالكروب ( رد , ايدي , معرف )

🗒┇الادمنيه
🗑┇مسح الادمنيه 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
]]

Tkeko.h4 = [[
🔘┇اوامر المطور 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🔍┇تفعيل / تعطيل
⛓┇مغادره 
♦️┇رفع منشئ / تنزيل منشئ
📖┇المنشئين 
🗑┇مسح المنشئين 

📕┇اضف رد عام الكلمه ( بالرد عل نص او ميديا )
🗑┇مسح رد عام الكلمه 
📝┇ردود العام 
🗑┇مسح ردود العام
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
]]

Tkeko.h5 = [[
🔘┇اوامر المطور الاساسي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
⚙️┇رست او تحديث 

♦️┇تفعيل / تعطيل التواصل 
♦️┇تفعيل / تعطيل الوضع الخدمي 
♦️┇تفعيل / تعطيل الشتراك

📂┇رفع ملف ( بالرد على الملف )
📂┇تفعيل ملف اسم الملف 
📂┇تعطيل ملف اسم الملف
📂┇مسح ملف اسم الملف 
📂┇جلب ملف اسم الملف 
📂┇ملفات اللغات 
📂┇ملفات الاضافيه 

📎┇تعين start الراسله 
📝┇تعين كليشه المطور الكليشه 

🖇┇روابط الكروبات 
📈┇عدد الكروبات او عدد الخاص 


🎤┇اذاعه بالرد على المنشور  ( للكل )
🎤┇اذاعه خاص بالرد على المنشور ( للمشتركين )
🎤┇اذاعه للكروبات بالرد على المنشور ( للكروبات )

🎤┇اذاعه بالتثبيت بالرد على المنشور ( اذاعه + تثبيت للمنشور بالكروب )
🎤┇اذاعه توجيه بالرد على المنشور 


⛓┇رفع مطور / تنزيل مطور ( رد , ايدي , معرف )
📜┇المطورين 
🗑┇مسح المطورين 

🚫┇حظر عام / الغاء حظر عام ( رد , ايدي , معرف )
📜┇المحظورين عام 
🗑┇مسح المحظورين عام
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
]]

------------------------------
Tkeko.idtstoped = "🚫┋الايدي معطل مسبقا"
Tkeko.idtstop = "🚫┋تم تعطيل الايدي بنجاح"
Tkeko.idstart = "✔️┋تم تفعيل الايدي بنجاح"
Tkeko.idtstarted = "✔️┋الايدي مفعل مسبقا"
Tkeko.isseudoserver = "مطور اساسي \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
Tkeko.issudoonredis = "مطور\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
Tkeko.iscruter_i = "منشئ\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
Tkeko.isadmin_i = "ادمن\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
Tkeko.usergr = "عضو فقط\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
Tkeko.photos_msg = "\n🏞¦ عدد الصور •  "
Tkeko.id_msg = "\n🎟¦ ايديــك •  "
Tkeko.username_msg = "\n🎭¦ مـعرفك •"
Tkeko.notusername_msg = "ليس لديه معرف"
Tkeko.stsus_msg = "\n📌¦ موقعـك • "
Tkeko.msgs_msg = "\n💌¦ رسائلك • "
Tkeko.msgs_msg2= "💌¦ رسائلك • : "
Tkeko.id_msg_channle = "\n🆔¦ايدي القناة"
Tkeko.id_msg_channle2 = "📢¦القناة : "
Tkeko.send_new_username = "📩¦ارسال الان معرف قناتك "
Tkeko.channleis = "🚫¦الاشتراك معطل سابقا"
Tkeko.channleok = "🚫¦تم تعطيل الاشتراك"
Tkeko.tesxtcchannle = "🔊¦شترك هنا : "
Tkeko.users = "⚪️¦عدد المستخدمين : "
Tkeko.addnote = "✔️¦تم تفعيل المجموعه بنجاح "
Tkeko.unaddnote = "✖️¦تم تعطيل المجموعه : "
Tkeko.addnoteby = "👤¦بواسطه : "
Tkeko.creatorslist = "📄¦قائمه المنشئين :"
Tkeko.notcreators = "🗒¦لا يوجد منشئين" 
Tkeko.isauto = "✔️¦الوضع الخدمي مفعل سابقا"
Tkeko.auto = "✔️¦تم تفعيل الوضع الخدمي"
Tkeko.isunauto = "✖️¦الوضع الخدمي مفعل سابقا" 
Tkeko.unauto = "✖️¦تم تعطيل الوضع الخدمي"
Tkeko.okSetSter = "✉️¦تم تعين رساله : "
Tkeko.notban_all = "🚫¦لا يوجد قائمه محظورين عام"
Tkeko.ban_alllist = "✏️¦قائمه المحظرين عام : "
Tkeko.del_list_ban_all = "🗑¦تم حذف قائمه المحظورين عام"
Tkeko.botNotAdmin = "📢¦البوت ليس ادمن في القناة"
Tkeko.botAdmin = "📢¦تم تفعيل الاشتراك الاجباري"
Tkeko.isban_all = "🚫¦محظور عام مسبقا"
Tkeko.toban_all = "🚫¦تم حظره من المجموعات البوت"
Tkeko.isunban_all = "📄¦غير محظور مسبقا" 
Tkeko.tounban_all = "✔️¦ تم الغاء حظره عام"
------------------------------
Tkeko.listreplyall = "📄¦قائمه ردود العامه : "
Tkeko.notlistreplyall = "❗️¦لا يوجد ردود في البوت"
Tkeko.dellistreplyall = "🗑¦تم مسح قائمه ردود العامه"
Tkeko.notlistreply = "❗️¦لا يوجد ردود في المجموعه"
Tkeko.dellistreply = "🗑¦تم مسح قائمه ردود الكروب"
Tkeko.filenot = "‼️¦الملف لا يدعم سورس كيكو"
Tkeko.addfileonf = "☑️¦تم تفعيل الملف الاضافي بنجاح"
Tkeko.addfilelang = "☑️¦تم تفعيل ملف الغه بنجاح"
Tkeko.unaddfileonf = "☑️¦تم تعطيل الملف الاضافي بنجاح"
Tkeko.unaddfilelang = "☑️¦تم تعطيل ملف الغه بنجاح"
Tkeko.banpv = "✔️¦تم حظر المستخدم من التواصل"
Tkeko.okDellang = "🗑¦تم حذف ملف من مجلد { langs }"
Tkeko.notokDellang = "⁉️┋لا يوجد هكذا ملف في مجلد { langs }"
Tkeko.okDelfile = "🗑¦تم حذف ملف من مجلد { files }"
Tkeko.notokDelfile = "⁉️¦لا يوجد هكذا ملف في مجلد { files }"
Tkeko.unbanpv = "❗️¦تم الغاء حظر المستخدم من التواصل"
Tkeko.bantext = "☑️¦تم منع كلمه : "
Tkeko.isbantext = "⁉️¦الكلمه ممنوعه مسبقا"
Tkeko.okdelbantext = "🗑¦تم مسح قائمه الكلمات الممنوعه"
Tkeko.nobantext = "❕¦لا يوجد كلمات ممنوعه"
Tkeko.listbanetext = "📄¦قائمه الكلمات الممنوعه : "
Tkeko.unbantext = "✔️¦تم الغاء منع كلمه : "
Tkeko.isunbantext = "❗️¦تم الغاء منع الكلمه مسبقا"
Tkeko.isstoppv = "🚫¦التواصل معطل سابقا"
Tkeko.stoppv = "🚫¦تم تعطيل التواصل"
Tkeko.isunstoppv = "📩¦التواصل مفعل سابقا" 
Tkeko.unstoppv = "🚫¦تم تعطيل التواصل"
Tkeko.lagfile = "🗂¦تم رفع ملف الغه الى مجلد { langs }"
Tkeko.luafile = "🗂¦تم رفع الملف الاضافي الى مجلد { files }"
Tkeko.listfilelng = "📄¦قائمه ملفات اللغات : "
Tkeko.listfilelngad = "✔️مفعل"
Tkeko.notfile = "🚫¦لا يوجد ملفات"
Tkeko.listfilmore = "🗂¦قائمه الملفات الاضافيه : "
Tkeko.listfilmoread = "✔️مفعل"
Tkeko.witupdate = "🗂¦جاري رفع الملف"
Tkeko.tosudo = "✔️¦تم رفعه مطور"
Tkeko.isunsudo = "🔻¦بالفعل تم تنزيله من المطورين"
Tkeko.tounsudo = "🔻¦تم تنزيله من المطورين"
Tkeko.isadmin = "☑️¦بالفعل ادمن"
Tkeko.toadmin = "☑️¦تم رفعه ادمن"
Tkeko.isunadmin = "☑️¦بالفعل تم تنزيله من الادمنيه"
Tkeko.tounadmin = "☑️¦تم تنزيله من الادمنيه"
Tkeko.notsudo = "📜¦لا يوجد مطورين"
Tkeko.linkGR = "📮¦رابط المجموعه : "
Tkeko.mut_grlist = "📄¦قائمه المقيديين : "
Tkeko.dellistmut_gr = "🗑¦تم حذف قائمه المقيديين"
Tkeko.notmut_grlist = "📜¦لا يوجد مقيديين"
Tkeko.linkGRerre = "◻️¦ارسل وضع رابط"
Tkeko.sendlink = "📩¦ارسال الرابط الان" 
Tkeko.pv_stop = "❕¦تم تعطيل التواصل مع المطور"
Tkeko.pv_start = "🌐¦مرحبا بك في بوت حمايه \n\n📨┋ارسال ماتريد وسارسله الى المطور"
Tkeko.pv_send = "📩¦تم ارسال رسالتك الى المطور"
Tkeko.savelink = "📌¦تم حفظ الرابط"
Tkeko.sudolist = "📄¦قائمه المطورين : "
Tkeko.del_list_sudo = "🗑¦تم حذف قائمه المطورين"
Tkeko.isban = "☑️¦محظور بالفعل"
Tkeko.ban = "☑️¦تم حظره من المجموعه"
Tkeko.unban = "☑️¦تم الغاء حظره من المجموعه"
Tkeko.isunban = "🚫¦غير محظور مسبقا"
Tkeko.dellistban = "🗑¦تم حذف قائمه المحظورين"
Tkeko.deleteadmin = "🗑¦تم حذف قائمه الادمنيه" 
Tkeko.isdeleteadmin = "📈¦لا يوجد ادمنيه"
Tkeko.banlist = "📛¦قائمه المحظورين : "
Tkeko.notban = "🚫¦لا يوجد محظورين"
Tkeko.dc = "📢¦تم عمل اذاعه للمنشور بشكل مباشر"
Tkeko.dcfwd = "📢¦تم عمل اذاعه للمنشور بشكل توجيه"
Tkeko.clean = "🗑¦تم تنظيف : "
Tkeko.notclean = "لا يمكنك تنظيف اكثر من 1000🚫¦رساله"
Tkeko.setphoto = "🔄¦تم تحديث صوره المجموعه بنجاح"
Tkeko.setchattitle = "🔄¦تم تحديث اسم المجموعه بنجاح"
Tkeko.changeDescription = "🔄¦تم تحديث وصف المجموعه بنجاح"
Tkeko.all_add_gr = "📻¦عدد الكروبات المفعله : "
Tkeko.all_gr = "📻¦عدد الكروبات الكلي : "
Tkeko.all_gr_not_add = "🚫¦عدد الكروبات الغير مفعله : "
Tkeko.ismute_ge = "☑️¦مقيد بالفعل"
Tkeko.mute_ge = "☑️¦تم تقييده من المجموعه"
Tkeko.unmute_ge = "☑️¦تم الغاء تقييده من المجموعه"
Tkeko.isunmute_ge = "🚫¦غير مقيد مسبقا"
Tkeko.dellistmute_ge = "🗑¦تم حذف قائمه المقيدين"
Tkeko.mute_gelist = "📄¦قائمه المقيدين : "
Tkeko.notmute_ge = "❕¦لا يوجد مقيدين"
Tkeko.ismute = "🔇¦مكتوم بالفعل"
Tkeko.mute = "🔇¦تم كتمه من البوت"
Tkeko.isunmute = "☑️¦غير مكتوم مسبقا"
Tkeko.unmute = "☑️¦تم الغاء كتمه في البوت"
Tkeko.isamdinno = "🚫¦لا يمكنك عمل ذلك في المدراء"
Tkeko.setmaxspam = "🔃¦تم تعيين عدد التكرار : "
Tkeko.setmaxlist = "📑¦تم تعيين عدد احرف الكلايش : "
Tkeko.user = "👤¦العضو ← "
Tkeko.erroru = "⚠️¦حدث خطأ"
Tkeko.notmute = "🚫¦لا يوجد مكتومين"
Tkeko.mutelist = "📃¦قائمه المكتومين : "
Tkeko.adminlist = "📃¦قائمه الادمنيه : "
Tkeko.unpinmsg = "📮¦تم الغاء التثبيت"
Tkeko.pinmsg = "📮¦تم تثبيت الرساله"
Tkeko.dellistmute = "🗑¦تم حذف قائمه المكتومين"
Tkeko.user_send = "👤¦بواسطه : "
Tkeko.muteongr = "☑️¦تم تفعيل التقييد"
Tkeko.ismuteongr = "☑️¦التقييد مفعل سابقا"
Tkeko.isunmuteongr = "☑️¦التقييد معطل سابقا"
Tkeko.unmuteongr = "☑️¦تم تعطيل التقييد"
Tkeko.youlock = "عليه" 

Tkeko.settings = {
text = "🔧┋اعدادات المجموعه : ",
    text2 = "🔧┋اعدادات الشخص في المجموعه : ",
    open = " مفتوح ✔️ \n",
    lock = " مقفول ✖️ \n" ,
    fwd = "التوجيه┇",
    link = "الروابط┇",
    chat = "الدردشه┇",
    username = "المعرفات┇",
    list = "الكلايش┇",
    file = "الملفات┇",
    sticker = "الملصقات┇",
    music = "الصوتيات┇",
    markdown = "الماركدون┇",
    inlines = "الانلاين┇",
    photo = "الصور┇",
    bots = "اضافه البوتات┇",
    gif = "المتحركه┇",
    note = "الاشعارات┇",
    join = "الدخول للمجموعه┇",
    spam = "التكرار┇",
    all = "الكل┇",
    pin = "التثبيت┇",
} 

Tkeko.lock = { 
       link = "☑️¦تم قفل الروابط",
    islink = "☑️¦الروابط مقفوله مسبقا",
    open_link = "☑️¦تم فتح الروابط", 
    isopen_link = "☑️¦الروابط مفتوحه مسبقا",
    ----------
    pin = "🖇¦تم قفل التثبيت",
    ispin = "🖇¦التثبيت مقفول مسبقا",
    open_pin = "🖇¦تم فتح التثبيت", 
    isopen_pin = "🖇¦التثبيت مفتوح مسبقا",
    ----------
    join = "☑️¦تم قفل الانضمام للمجموعه",
    isjoin = "☑️¦الانضمام للمجموعه مقفول مسبقا",
    open_join = "☑️¦تم فتح الانضمام للمجموعه", 
    isopen_join = "☑️¦الانضمام للمجموعه مفتوح مسبقا",
    ---------- 
    edit_media = "📺¦تم قفل تعديل الميديا",
    isedit_media = "📺¦تعديل الميديا مقفول مسبقا",
    open_edit_media = "📺¦تم فتح تعديل الميديا", 
    isopen_edit_media = "📺¦تعديل الميديا مفتوح مسبقا",
    ----------
    fwd = "↪️¦تم قفل التوجيه",
    isfwd = "↪️¦التوجيه مقفول مسبقا",
    open_fwd = "↪️¦تم فتح التوجيه", 
    isopen_fwd = "↪️¦التوجيه مفتوح مسبقا",
    ----------
    photo = "📸¦تم قفل الصور",
    isphoto = "📸¦الصور مقفوله مسبقا",
    open_photo = "📸¦تم فتح الصور", 
    isopen_photo = "📸¦الصور مفتوحه مسبقا",
    ----------
    video = "🎞¦تم قفل الفديو",
    isvideo = "🎞¦الفديوهات مقفوله مسبقا",
    open_video = "🎞¦تم فتح الفديو", 
    isopen_video = "🎞¦الفديوهات مفتوحه مسبقا",
    ----------
    gif = "📽¦تم قفل المتحركه",
    isgif = "📽¦المتحركه مقفوله مسبقا",
    open_gif = "📽¦تم فتح المتحركه", 
    isopen_gif = "📽¦المتحركه مفتوحه مسبقا",
    ----------
    username = "🔘¦تم قفل المعرفات",
    isusername = "🔘¦المعرفات مقفوله مسبقا",
    open_username = "🔘¦تم فتح المعرفات", 
    isopen_username = "🔘¦المعرفات مفتوحه مسبقا",
    ----------
    inline = "📤¦تم قفل الانلاين",
    isinline = "📤¦الانلاين مقفول مسبقا",
    open_inline = "📤¦تم فتح الانلاين", 
    isopen_inline = "📤¦الانلاين مفتوح مسبقا", 
    ----------
    markdown = "📛¦تم قفل الماركدون",
    ismarkdown = "📛¦الماركدون مقفول مسبقا",
    open_markdown = "📛¦تم فتح الماركدون", 
    isopen_markdown = "📛¦الماركدون مفتوح مسبقا",  
    ----------
    note = "‼️¦تم قفل الاشعارات",
    isnote = "‼️¦الاشعارات مقفول مسبقا",
    open_note = "‼️¦تم فتح الاشعارات", 
    isopen_note = "‼️¦الاشعارات مفتوح مسبقا",
    ----------
    bots = "🤖¦تم قفل البوتات",
    isbots = "🤖¦البوتات مقفوله مسبقا",
    open_bots = "🤖¦تم فتح البوتات", 
    isopen_bots = "🤖¦البوتات مفتوحه مسبقا",
    ----------
    chat = "🌐¦تم قفل الدردشه",
    ischat = "🌐¦الدردشه مقفوله مسبقا",
    open_chat = "🌐¦تم فتح الدردشه", 
    isopen_chat = "🌐¦الدردشه مفتوحه مسبقا",
    ----------
    spam = "🔃¦تم قفل التكرار",
    isspam = "🔃¦التكرار مقفول مسبقا",
    open_spam = "🔃¦تم فتح التكرار", 
    isopen_spam = "🔃¦التكرار مفتوح مسبقا",
    ----------
    sticker = "🔖¦تم قفل الملصقات",
    issticker = "🔖¦الملصقات مقفوله مسبقا",
    open_sticker = "🔖¦تم فتح الملصقات", 
    isopen_sticker = "🔖¦الملصقات مفتوحه مسبقا",
    ----------    
    file = "🗂¦تم قفل الملفات",
    isfile = "🗂¦الملفات مقفوله مسبقا",
    open_file = "🗂¦تم فتح الملفات", 
    isopen_file = "🗂¦الملفات مفتوحه مسبقا",
    ----------    
    music = "🎧¦تم قفل الصوتيات",
    ismusic = "🎧¦الصوتيات مقفوله مسبقا",
    open_music = "🎧¦تم فتح الصوتيات", 
    isopen_music = "🎧¦الصوتيات مفتوحه مسبقا",
    ----------    
    list = "📑¦تم قفل الكلايش",
    islist = "📑¦الكلايش مقفوله مسبقا",
    open_list = "📑¦تم فتح الكلايش", 
    isopen_list = "📑¦الكلايش مفتوحه مسبقا",       
    ----------    
    all = "🎚¦تم قفل الكل",
    isall = "🎚¦الكل مقفول مسبقا",
    open_all = "🎚¦تم فتح الكل", 
    isopen_all = "🎚¦الكل مفتوح مسبقا",    
}
-------------------------------------
return Tkeko
