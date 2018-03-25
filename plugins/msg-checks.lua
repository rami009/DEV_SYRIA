-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local TIME_CHECK = 1
 
if not redis:get(rami..'autodeltime') then
	redis:setex(rami..'autodeltime', 86400 , true)
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
	 run_bash("rm -rf ./data/photos/*")
end
 
if msg.to.type == "channel" and msg.adduser and msg.adduser == tonumber(our_id) then

if not redis:get(rami..'extimeadd'..msg.to.id) then
redis:setex(rami..'extimeadd'..msg.to.id, 300 , true)
local msg_welcom = [[❖￤ مـرحبآ آنآ بوت آسـمـي ]]..bot_name..[[ 🎖
❖￤ آختصـآصـي حمـآيهہ‏‏ آلمـجمـوعآت
❖￤ مـن آلسـبآم وآلتوجيهہ‏‏ وآلتگرآر وآلخ...
❖￤ مـعرف آلمـطـور  : ]]..sudouser:gsub([[\_]],'_')..[[ 🌿
👨🏽‍🔧]]
 return tdcli.sendPhoto(msg.to.id, msg.id, 0, 1, nil, './data/photo/rambo.jpg', msg_welcom)
end

if not redis:get(rami..'group:add'..msg.to.id) and not redis:get(rami..'extimeadd'..msg.to.id) and not is_sudo(msg) then
tdcli.sendMessage(msg.to.id, 0, 1, '🚸¦ لا يمكنكم تفعيل البوت 📛\n❖￤ فقط المطور يستطيع يفعل : '..sudouser.. ' 🍃\n🚷¦ سوف اغادر بااي 🚶', 1, 'md')
botrem(msg)
end
end




if msg.photo_ then

if redis:get(rami..'photo:group'..msg.from.id) then
redis:del(rami..'photo:group'..msg.from.id)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli.changeChatPhoto(msg.to.id, photo_id)
sleep(0.3)
tdcli.sendMessage(msg.to.id, msg.id_,1, '❖￤ تم تغيير صـورهہ‏‏ آلمـجمـوعهہ 🌿', 1, 'html')
end

if msg.photo_ and redis:get(rami..'welcom_ph:witting'..msg.from.id) then
redis:del(rami..'welcom_ph:witting'..msg.from.id)
if msg.content_.photo_.sizes_[2] then
tdcli.downloadFile(msg.content_.photo_.sizes_[2].photo_.id_, dl_cb, nil)
else
return tdcli.sendMessage(msg.to.id, msg.id_,1, '❖￤ حدث خطا حاول ارسالها مره اخرها 🌿', 1, 'html')
end
sleep(0.5)
if file_exi(msg.content_.photo_.id_..'_(1).jpg', tcpath..'/data/photo') then
os.rename(tcpath..'/data/photo/'..msg.content_.photo_.id_..'_(1).jpg', './data/photo/rambo.jpg')
else
os.rename(tcpath..'/data/photo/'..msg.content_.photo_.id_..'.jpg', './data/photo/rambo.jpg')
end
tdcli.sendMessage(msg.to.id, msg.id_,1, '❖￤ تم تغيير صـورهہ‏‏ آلترحيب للبوت 🌿', 1, 'html')
end
end

if msg.forward_info_ and redis:get(rami..'fwd:'..msg.from.id) then
redis:del(rami..'fwd:'..msg.from.id)
local pv = redis:smembers(rami..'users')
local groups = redis:smembers(rami..'group:ids')
for i = 1, #pv do
tdcli.forwardMessages(pv[i],msg.to.id, {[0] = msg.id}, 0)
end
for i = 1, #groups do
tdcli.sendMessage(groups[i], 0, 0, check_markdown(msg.text), 0)			
end
tdcli.sendMessage(msg.to.id, 0, 0,'❖￤ تم اذاعه التوجيه الى `'..#groups..'` مجموعات 🍃', 0)			
tdcli.sendMessage(msg.to.id, 0, 0,'❖￤ تم اذاعه التوجيه الى `'..redis:scard(rami..'users')..'` من المشتركين 👍🏿', 0)
tdcli.forwardMessages(SUDO,msg.to.id, {[0] = msg.id}, 0)
end

if msg.to.type == "channel" and redis:get(rami..'group:add'..msg.to.id) then
redis:incr(rami..'msgs:'..msg.from.id..':'..msg.to.id)  -- ريدز تسجيل عدد رسائل الاعضاء
------------------------------------------------------
if msg.from.username then usernamex = "@"..msg.from.username else usernamex = "ما مسوي  😹💔" end
------------------------
local function check_newmember(arg, data)
if data.username_ then user_name = '@'..data.username_ else user_name = data.first_name_ end
if data.type_.ID == "UserTypeBot" then -- حصانه التحقق من البوتات المضافه
if not is_owner(arg.msg) and redis:get(rami..'lock_bots_by_kick'..msg.to.id) then --- طرد البوت مع الي ضافه
kick_user(data.id_, arg.chat_id)
kick_user(arg.user_id, arg.chat_id)
sleep(1)
tdcli.sendMessage(arg.chat_id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..arg.user_id..'</code>\n<b>❖￤ العضو :</b> '..usernamex..'\n<b>❖￤ البوت :</b> '..user_name..'\n❖￤ ممنوع اضافه البوتات ✋🏿\n🚯¦ تم طرد البوت مع ال ضاف البوت', 0, "html")    
elseif not is_owner(arg.msg) and redis:get(rami..'lock_bots'..msg.to.id) then
kick_user(data.id_, arg.chat_id)
if redis:get(rami..'lock_woring'..msg.to.id) then
tdcli.sendMessage(arg.chat_id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..arg.user_id..'</code>\n<b>❖￤ العضو :</b> '..usernamex..'\n<b>❖￤ البوت :</b> '..user_name..'\n❖￤ ممنوع اضافه البوتات ✋🏿\n🚯¦ تم طرد البوت ', 0, "html")    
end end end
-------------------------
if is_banned(data.id_, arg.chat_id) then
tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔* ('..data.id_..')*\n❖￤ _ محظور سابقا وتم طرده ✓_', 0, "md")
kick_user(data.id_, arg.chat_id)
end
if is_gbanned(data.id_) then
tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔* ('..data.id_..')*\n❖￤ _ محظور عام تم طرده ✓_', 0, "md")
kick_user(data.id_, arg.chat_id)
end
end
if msg.adduser then
tdcli_function ({ID = "GetUser",user_id_ = msg.adduser}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
end
if msg.joinuser then
tdcli_function ({ID = "GetUser",user_id_ = msg.joinuser}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
end
------------------------------------------------------------------------------------    
if msg.adduser or msg.joinuser or msg.deluser then -- قفل الاشعارات
if redis:get(rami..'mute_tgservice'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
end
end
if msg.adduser and redis:get(rami..'welcome:get'..msg.to.id) then
local adduserx = tonumber(redis:get(rami..'user:'..user..':msgs') or 0)
if adduserx > 3 then
redis:del(rami..'welcome:get'..msg.to.id)
end
redis:setex(rami..'user:'..user..':msgs', 3, adduserx+1)
end
 
if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and msg.from.id ~= our_id then -- للاعضاء فقط
if redis:get(rami..'lock_flood'..msg.to.id) and not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and not msg.adduser and msg.from.id ~= our_id then
local msgs = (redis:get(rami..'user:'..user..':msgs') or 0)
local NUM_MSG_MAX = (redis:get(rami..'num_msg_max'..msg.to.id) or 5)
if tonumber(msgs) > tonumber(NUM_MSG_MAX) then
if msg.from.username then
user_name = "@"..check_markdown(msg.from.username)
else
user_name = check_markdown(msg.from.first_name)
end
if redis:get(rami..'sender:'..user..':flood') then
return
else
del_msg(chat, msg.id)
kick_user(user, chat)
tdcli.sendMessage(chat, msg.id, 0, "❖￤العضو  ⇔  "..user_name.."\n ❖￤الايدي  ⇔ `["..user.."]`\n ❖￤_  عذرا ممنوع التكرار في هذه المجموعه لقد تم طردك ✓_\n", 0, "md")
redis:setex(rami..'sender:'..user..':flood', 30, true)
end
end
redis:setex(rami..'user:'..user..':msgs', TIME_CHECK, msgs+1)
end
if msg and is_silent_user(msg.from.id, msg.to.id) then -- الكتم
del_msg(chat, tonumber(msg.id))
end
if msg.text and redis:get(rami..'mute_text'..msg.to.id) then --قفل الدردشه
del_msg(chat, tonumber(msg.id))
end
if msg.forward_info_ and redis:get(rami..'mute_forward'..msg.to.id) then -- قفل التوجيه
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع اعادة التوجيه  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif tonumber(msg.via_bot_user_id_) ~= 0 and redis:get(rami..'mute_inline'..msg.to.id) then -- قفل الانلاين
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا الانلاين مقفول  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.media.caption then -- الرسايل الي بالكابشن
if (msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.caption:match(".[Pp][Ee]")) and redis:get(rami..'lock_link'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الروابط  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif (msg.media.caption:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.caption:match("[Hh][Tt][Tt][Pp]://") or msg.media.caption:match("[Ww][Ww][Ww].") or msg.media.caption:match(".[Cc][Oo][Mm]")) and redis:get(rami..'lock_webpage'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال روابط الويب  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.media.caption:match("@") and redis:get(rami..'lock_username'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال التاك او المعرف  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif is_filter(msg, msg.media.caption) then
del_msg(chat, tonumber(msg.id))
end
elseif msg.text then -- رسايل فقط
local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
local max_chars = 2000
local max_len =  2000
if (string.len(msg.text) > max_len or ctrl_chars > max_chars) and redis:get(rami..'lock_spam'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ ممنوع ارسال الكليشه والا سوف تجبرني على طردك  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.text == "[unsupported]" and redis:get(rami..'mute_video'..msg.to.id) then -- قفل الفيديو
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الفيديو كام 🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif (msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text:match(".[Pp][Ee]")) and redis:get(rami..'lock_link'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ ممنوع ارسال الروابط  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Cc][Oo][Mm]")) and redis:get(rami..'lock_webpage'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ ممنوع ارسال روابط الويب   🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif  msg.text:match("#") and redis:get(rami..'lock_tag'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ ممنوع ارسال التاك  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif is_filter(msg, msg.text) then
del_msg(chat, tonumber(msg.id))
elseif msg.text:match("@")  and redis:get(rami..'lock_username'..msg.to.id) then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ ممنوع ارسال المعرف   🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif is_filter(msg, msg.text) then
del_msg(chat, tonumber(msg.id))
end
elseif msg.edited and redis:get(rami..'lock_edit'..msg.to.id) then -- قفل التعديل
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذراً ممنوع التعديل تم المسح 🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.photo_ and redis:get(rami..'mute_photo'..msg.to.id)  then -- قفب الصور
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الصور  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.video_ and redis:get(rami..'mute_video'..msg.to.id) then -- قفل الفيديو
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الفيديو  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.document_ and redis:get(rami..'mute_document'..msg.to.id) then -- قفل الملفات
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الملفات  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.sticker_ and redis:get(rami..'mute_sticker'..msg.to.id) then --قفل الملصقات
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الملصقات  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.animation_ and redis:get(rami..'mute_gif'..msg.to.id) then -- قفل المتحركه
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الصور المتحركه  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.contact_ and redis:get(rami..'mute_contact'..msg.to.id) then -- قفل الجهات
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال جهات الاتصال  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.location_ and redis:get(rami..'mute_location'..msg.to.id) then -- قفل الموقع
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الموقع  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.voice_ and redis:get(rami..'mute_voice'..msg.to.id) then -- قفل البصمات
del_msg(chat, tonumber(msg.id))
 if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال البصمات  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.game_ and redis:get(rami..'mute_game'..msg.to.id) then -- قفل الالعاب
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع لعب الالعاب  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.audio_ and redis:get(rami..'mute_audio'..msg.to.id) then -- قفل الصوت
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا ممنوع ارسال الصور  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.content_ and msg.reply_markup_ and  msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and redis:get(rami..'mute_keyboard'..msg.to.id) then -- كيبورد
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ عذرا الكيبورد مقفول  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")    
end
elseif msg.content_.entities_ and msg.content_.entities_[0] then
if msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic" then
del_msg(chat, tonumber(msg.id))
if redis:get(rami..'lock_woring'..msg.to.id) then
local msgx = "❖￤ ممنوع ارسال الماركدوان  🛠"
tdcli.sendMessage(msg.to.id, 0, 1, '<b>❖￤ الاسم :</b> <code>'..(msg.from.first_name or '')..'\n</code><b>❖￤ الايدي :</b> <code>'..msg.from.id..'</code>\n<b>❖￤ المعرف :</b> '..usernamex..'\n'..msgx, 0, "html")
end end end end end end
return {patterns = {},pre_process = pre_process}

-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
