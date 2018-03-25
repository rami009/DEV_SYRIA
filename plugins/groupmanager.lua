-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

local function syria(msg, matches)
if msg.to.type ~= 'pv' then
if matches[1] == "تفعيل" and not matches[2] then 
return modadd(msg)
end
if matches[1] == "تعطيل" and not matches[2] then
return modrem(msg)
end
if  redis:get(rami..'group:add'..msg.to.id) then  -- حصانه اذا كانت المجموعه مفعله

if matches[1] == "ايدي" then
if not matches[2] and not msg.reply_id then
if redis:get(rami..'lock_id'..msg.to.id) then
local function getpro(arg, data)
if data.photos_[0] then
if we_sudo(msg) then
rank = 'المطور الاساسي 🛠'
elseif is_sudo(msg) then rank = 'المطور مالتي 😻'
elseif is_owner(msg) then rank = 'مدير المجموعه 😽'
elseif is_sudo(msg) then rank = 'اداري في البوت 😼'
elseif is_mod(msg) then rank = 'ادمن في البوت 😺'
elseif is_whitelist(msg.from.id,msg.to.id)  then rank = 'عضو مميز 🎖'
else rank = 'فقط عضو 😹'
end
if msg.from.username then userxn = "@"..msg.from.username else userxn = "لا يتوفر" end
local msgs = tonumber(redis:get(rami..'msgs:'..msg.from.id..':'..msg.to.id) or 0)
tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'❖￤ اسمك : '..namecut(msg.from.first_name)..'\n❖￤ معرفك : '..userxn..'\n❖￤ ايديك : '..msg.from.id..'\n❖￤ رتبتك : '..rank..' \n📬¦ عدد رسائلك : ['..msgs..'] رساله \n',dl_cb,nil)
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "❖￤ لا يوجد صوره في بروفايلك ...!\n\n *❖￤ ايدي المجموعه :* `"..msg.to.id.."`\n*❖￤ ايديك :* `"..msg.from.id.."`", 1, 'md')
end
end
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.from.id,offset_ = 0,limit_ = 1}, getpro, nil)
else
return '`'..msg.from.id..'`'
end
end
if msg.reply_id and not matches[2] then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="iduser"})
end
if matches[2] then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="iduser"})
end
end
if matches[1] == "تثبيت" and is_mod(msg) and msg.reply_id then
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
return "❖￤ _مرحبآ عزيزي_\n❖￤ _ تم تثبيت الرساله_ ✓"
end
if matches[1] == "الغاء التثبيت" and is_mod(msg) then
tdcli.unpinChannelMessage(msg.to.id)
return "❖￤ _مرحبآ عزيزي_\n❖￤ _ تم الغاء تثبيت الرساله_ ✓"
end
if matches[1] == "رفع عضو مميز" and is_mod(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setwhitelist"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setwhitelist"})
end
end
if matches[1] == "تنزيل عضو مميز" and is_mod(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remwhitelist"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remwhitelist"})
end
end
if matches[1] == "رفع المدير" and is_sudo(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
end
end
if matches[1] == "تنزيل المدير" and is_sudo(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"}) 
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
end
end
if matches[1] == "رفع ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
end
end
if matches[1] == "تنزيل ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
end
end
if matches[1] == "قفل" then
if matches[2] == "الروابط" then
return lock_link(msg)
end
if matches[2] == "التاك" then
return lock_tag(msg)
end
if matches[2] == "المعرفات" then
return lock_username(msg)
end
if matches[2] == "التعديل" then
return lock_edit(msg)
end
if matches[2] == "الكلايش" then
return lock_spam(msg)
end
if matches[2] == "التكرار" then
return lock_flood(msg)
end
if matches[2] == "البوتات" then
return lock_bots(msg)
end
if matches[2] == "البوتات بالطرد" then
return lock_bots_by_kick(msg)
end
if matches[2] == "الماركداون" then
return lock_markdown(msg)
end
if matches[2] == "الويب" then
return lock_webpage(msg)
end
if matches[2] == "الثبيت" and is_owner(msg) then
return lock_pin(msg)
end
end
if matches[1] == "فتح" and is_mod(msg) then
if matches[2] == "الروابط" then
return unlock_link(msg)
end
if matches[2] == "التاك" then
return unlock_tag(msg)
end
if matches[2] == "المعرفات" then
return unlock_username(msg)
end
if matches[2] == "التعديل" then
return unlock_edit(msg)
end
if matches[2] == "الكلايش" then
return unlock_spam(msg)
end
if matches[2] == "التكرار" then
return unlock_flood(msg)
end
if matches[2] == "البوتات" then
return unlock_bots(msg)
end
if matches[2] == "البوتات بالطرد" then
return unlock_bots_by_kick(msg)
end
if matches[2] == "الماركداون" then
return unlock_markdown(msg)
end
if matches[2] == "الويب" then
return unlock_webpage(msg)
end
end
if matches[1] == "قفل" and is_mod(msg) then
if matches[2] == "الكل" then
local close_all ={
mute_gif(msg),mute_photo(msg),mute_audio(msg),mute_voice(msg),mute_sticker(msg),mute_forward(msg),mute_contact(msg),mute_location(msg),mute_document(msg),mute_inline(msg),lock_link(msg),lock_tag(msg),lock_edit(msg),lock_spam(msg),lock_bots(msg),lock_webpage(msg),mute_video(msg),
}
local text =  '❖￤ _مرحبا عزيزي_ \n❖￤ _تم قفل الكل _ ✓'
tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return close_all
end
if matches[2] == "الوسائط" then
local close_all ={
mute_gif(msg),mute_photo(msg),mute_audio(msg),mute_voice(msg),mute_sticker(msg),mute_video(msg),
}
local text =  '❖￤ _مرحبا عزيزي_ \n❖￤ _تم قفل الوسائط _ ✓'
tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return close_all
end
if matches[2] == "المتحركه" then
return mute_gif(msg)
end
if matches[2] == "الدردشه" then
return mute_text(msg)
end
if matches[2] == "الصور" then
return mute_photo(msg)
end
if matches[2] == "الفيديو" then
return mute_video(msg)
end
if matches[2] == "البصمات" then
return mute_audio(msg)
end
if matches[2] == "الصوت" then
return mute_voice(msg)
end
if matches[2] == "الملصقات" then
return mute_sticker(msg)
end
if matches[2] == "الجهات" then
return mute_contact(msg)
end
if matches[2] == "التوجيه" then
return mute_forward(msg)
end
if matches[2] == "الموقع" then
return mute_location(msg)
end
if matches[2] == "الملفات" then
return mute_document(msg)
end
if matches[2] == "الاشعارات" then
return mute_tgservice(msg)
end
if matches[2] == "الانلاين" then
return mute_inline(msg)
end
if matches[2] == "الالعاب" then
return mute_game(msg)
end
if matches[2] == "الكيبورد" then
return mute_keyboard(msg)
end
end
if matches[1] == "فتح" and is_mod(msg) then
if matches[2] == "الكل" then
local open_all ={
unmute_gif(msg),unmute_photo(msg),unmute_audio(msg),unmute_voice(msg),unmute_sticker(msg),unmute_forward(msg),unmute_contact(msg),unmute_location(msg),unmute_document(msg),unlock_link(msg),unlock_tag(msg),unlock_edit(msg),unlock_spam(msg),unlock_bots(msg),unlock_webpage(msg),unmute_video(msg),unmute_inline(msg)
}

local text =  '❖￤ _مرحبا عزيزي_ \n❖￤ _تم فتح الكل _ ✓' 
tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return open_all
end
if matches[2] == "الوسائط" then
local open_all ={
unmute_gif(msg),unmute_photo(msg),unmute_audio(msg),unmute_voice(msg),unmute_sticker(msg),unmute_video(msg),
}

local text =  '❖￤ _مرحبا عزيزي_ \n❖￤ _تم فتح الوسائط _ ✓' 
tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return open_all
end
if matches[2] == "المتحركه" then
return unmute_gif(msg)
end
if matches[2] == "الدردشه" then
return unmute_text(msg)
end
if matches[2] == "الصور" then
return unmute_photo(msg)
end
if matches[2] == "الفيديو" then
return unmute_video(msg)
end
if matches[2] == "البصمات" then
return unmute_audio(msg)
end
if matches[2] == "الصوت" then
return unmute_voice(msg)
end
if matches[2] == "الملصقات" then
return unmute_sticker(msg)
end
if matches[2] == "الجهات" then
return unmute_contact(msg)
end
if matches[2] == "التوجيه" then
return unmute_forward(msg)
end
if matches[2] == "الموقع" then
return unmute_location(msg)
end
if matches[2] == "الملفات" then
return unmute_document(msg)
end
if matches[2] == "الاشعارات" then
return unmute_tgservice(msg)
end
if matches[2] == "الانلاين" then
return unmute_inline(msg)
end
if matches[2] == "الالعاب" then
return unmute_game(msg)
end
if matches[2] == "الكيبورد" then
return unmute_keyboard(msg)
end
end
if matches[1] == "المجموعه" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)

ginfo = "❖￤ _معلومات المجموعه :_\n❖￤ _عدد الادمنيه _*["..data.administrator_count_.."]*\n❖￤ _عدد الاعضاء _*["..data.member_count_.."]*\n❖￤ _عدد المطرودين _*["..data.kicked_count_.."]*\n❖￤ _ايدي المجموعه _*["..data.channel_.id_.."]*"

tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == "ضع رابط" and is_owner(msg) then
redis:setex(rami..'waiting_link'..msg.from.id, 300,true)
return "❖￤ _مرحبآ عزيزي_\n❖￤ _رجائا ارسل الرابط الآن _🔃"
end
if matches[1] == "الرابط" then
if not redis:get(rami..'linkgp'..msg.to.id) then
return "❖￤ _اوه 🙀 لا يوجد هنا رابط_\n❖￤ _رجائا اكتب [ضع رابط]_🔃"
end
return tdcli.sendMessage(msg.to.id, msg.id, 1, "<b>❖￤رابـط الـمـجـمـوعه 🌿 🛠</b>\n"..redis:get(rami..'linkgp'..msg.to.id), 1, 'html')
end
if matches[1] == "الرابط خاص" and is_mod(msg) then
if not redis:get(rami..'linkgp'..msg.to.id) then
return "❖￤ _اوه 🙀 لا يوجد هنا رابط_\n❖￤ _رجائا اكتب [ضع رابط]_🔃"
end
tdcli.sendMessage(msg.from.id, 0, 1, "<code>❖￤رابـط الـمـجـمـوعه 🌿 🛠\n❖￤"..msg.to.title.." :\n\n</code>"..redis:get(rami..'linkgp'..msg.to.id)..'\n', 1, 'html')
return "❖￤ _مرحبآ عزيزي_\n❖￤ _تم ارسال الرابط خاص لك _🔃"
end
if matches[1] == "ضع القوانين" and is_mod(msg) then
redis:setex(rami..'rulse:witting'..msg.from.id,300,true)
return '📭¦ حسنآ عزيزي  ✋🏿\n❖￤ الان ارسل القوانين  للمجموعه 🍃'
end
if matches[1] == "القوانين" then
if not redis:get(rami..'rulse:msg'..msg.to.id) then
rules = "❖￤ _مرحبأ عزيري_ 👋🏻 _القوانين كلآتي_ 👇🏻\n❖￤ _ممنوع نشر الروابط_ \n❖￤ _ممنوع التكلم او نشر صور اباحيه_ \n❖￤ _ممنوع  اعاده توجيه_ \n❖￤ _ممنوع التكلم بلطائفيه_ \n❖￤ _الرجاء احترام المدراء والادمنيه _😅\n❖￤ _تابع _@TH3VICTORY 💤"
else
rules = "*❖￤القوانين :*\n"..redis:get(rami..'rulse:msg'..msg.to.id)
end
return rules
end
if matches[1] == "ضع تكرار" and is_mod(msg) then
if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
return "❖￤ _حدود التكرار ,  يجب ان تكون ما بين _ *[2-50]*"
end
redis:set(rami..'flood'..msg.to.id,matches[2]) 
return "❖￤_ تم وضع التكرار :_ *[ "..matches[2].." ]*"
end
if matches[1] == "مسح" and is_owner(msg) then
if matches[2] == "الادمنيه" then
local list = redis:smembers(rami..'admins:'..msg.to.id)
if #list==0 then 
return "❖￤ _اوه ☢ هنالك خطأ_ 🚸\n❖￤ _عذرا لا يوجد ادمنيه ليتم مسحهم_ ✓"
end
redis:del(rami..'admins:'..msg.to.id)
return "❖￤ _مرحبآ عزيزي_ \n❖￤ _تم حذف الادمنيه بنجاح_ ✓"
end
if matches[2] == "قائمه المنع" then
local list = redis:smembers(rami..'klmamn3'..msg.to.id)
if #list == 0 then
return "❖￤ _عذرا لا توجد كلمات ممنوعه ليتم حذفها_ ✓"
end
redis:del(rami..'klmamn3'..msg.to.id)
return "❖￤ _مرحبآ عزيزي_ \n❖￤ _تم حذف الكلمات الممنوعه بنجاح_ ✓"
end
if matches[2] == "القوانين" then
if not redis:get(rami..'rulse:msg'..msg.to.id) then
return "❖￤ _اوه ☢ هنالك خطأ_ 🚸\n❖￤ _عذرا لا يوجد قوانين ليتم مسحه_ ✓"
end
redis:del(rami..'rulse:msg'..msg.to.id)
return "❖￤ _مرحبآ عزيزي_ \n❖￤ _تم حذف القوانين بنجاح_ ✓"
end
if matches[2] == "الترحيب"  then
if not redis:get(rami..'welcome:msg'..msg.to.id) then
return "❖￤ _اوه ☢ هنالك خطأ_ 🚸\n❖￤ _عذرا لا يوجد ترحيب ليتم مسحه_ ✓"
end
redis:del(rami..'welcome:msg'..msg.to.id)
return "❖￤ _مرحبآ عزيزي_ \n❖￤ _تم حذف الترحيب بنجاح_ ✓"
end
end 
if matches[1] == "مسح" and is_sudo(msg) then
if matches[2] == "المدراء" then
if #redis:smembers(rami..'owners:'..msg.to.id) ==0 then
return "❖￤ _اوبس ☢ هنالك خطأ_ 🚸\n❖￤ _عذرا لا يوجد مدراء ليتم مسحهم_ ✓"
end
redis:del('owners:'..msg.to.id)
return "❖￤ _مرحبآ عزيزي_ \n❖￤ _تم حذف المدراء بنجاح_ ✓"
end
end
if matches[1] == "ضع اسم" and is_mod(msg) then
redis:setex(rami..'name:witting'..msg.from.id,300,true)
return "📭¦ حسنآ عزيزي  ✋🏿\n❖￤ الان ارسل الاسم  للمجموعه 🍃"
end
if matches[1] == "ضع صوره" and is_mod(msg) then
if msg.reply_id  then
function photomsg(arg, data)
function photoinfo(arg,data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then 
photo_id = data.content_.photo_.sizes_[3].photo_.persistent_id_
else
photo_id = data.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli.changeChatPhoto(msg.to.id, photo_id)
sleep(0.8)
tdcli.sendMessage(msg.to.id, msg.id_,1, '❖￤ تم تغيير صـورهہ‏‏ آلمـجمـوعهہ 🌿', 1, 'html')
end
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, photoinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, photomsg, nil)
else
redis:setex(rami..'photo:group'..msg.from.id,300,true)
return '📭¦ حسنآ عزيزي 🍁\n❖￤ الان قم بارسال الصوره  🛠'
end
end
if matches[1] == "ضع وصف" and is_mod(msg) then
redis:setex(rami..'about:witting'..msg.from.id,300,true) 
return "📭¦ حسنآ عزيزي  ✋🏿\n❖￤ الان ارسل الوصف  للمجموعه 🍃"
end
if matches[1] == "منع" and is_mod(msg) then
return filter_word(msg, matches[2])
end
if matches[1] == "الغاء منع" and is_mod(msg) then
return unfilter_word(msg, matches[2])
end
if matches[1] == "قائمه المنع" and is_mod(msg) then
return filter_list(msg)
end
if matches[1] == "الحمايه" then
settingsall(msg)
end
if matches[1] == "الاعدادات" then
settings(msg)
end
if matches[1] == "الوسائط" then
media(msg)
end
if matches[1] == "الادمنيه" and is_mod(msg) then
return modlist(msg)
end
if matches[1] == "المدراء" and is_owner(msg) then
return ownerlist(msg)
end
if matches[1] == "الاعضاء المميزين" and is_mod(msg) then
return whitelist(msg)
end
if matches[1] == "طرد البوتات" and is_owner(msg) then
function delbots(arg, data)
local deleted = 0 
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then

kick_user(v.user_id_, msg.to.id)
deleted = deleted + 1 
end
end
if deleted == 0 then
tdcli.sendMessage(msg.to.id, msg.id, 1, '❖￤ لا يوجد بوتات في المجموعه 🛠', 1, 'md')
else
tdcli.sendMessage(msg.to.id, msg.id, 1, '❖￤ تم طرد [<code>'..deleted..'</code>] بوت من المجموعه 🛠', 1, 'html')
end
end
tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, delbots, nil)
end
if matches[1] == 'طرد الكل' and is_sudo(msg) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end

  function m(arg, data) 
    for k, v in pairs(data.members_) do 
	if v.user_id_ ~= our_id and not is_sudo1(v.user_id_)  then
      kick_user(v.user_id_, msg.to.id) 
	  end
 end 
    tdcli.sendMessage(msg.to.id, msg.id, 1, '📛┇  _طردتهم الــك حبي_ 🛠', 1, 'md') 
  end 
  tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,offset_ = 0,limit_ = 80}, m, nil)
  end 
if matches[1] == "كشف البوتات" and is_owner(msg) then
function kshf(arg, data)
local i = 0
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then

i = i + 1
end
end
if i == 0 then
tdcli.sendMessage(msg.to.id, msg.id, 1, '❖￤ لا يوجد بوتات في المجموعه 🛠', 1, 'md')
else
tdcli.sendMessage(msg.to.id, msg.id, 1, '❖￤ عدد البوتات الموجوده [<code>'..i..'</code>] بوت 🛠',1, 'html')
end
end
tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 100, kshf, nil)
end
if matches[1] == 'طرد المحذوف' then 
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end

function userdel(arg, data) 
for k, v in pairs(data.members_) do 
local function infousers(arg, data)
if not data.first_name_  then 
kick_user(data.id_,arg.group) 
end 
end
tdcli_function ({ID = "GetUser",user_id_ = v.user_id_}, infousers, {group=arg.group})
end 
end 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,offset_ = 0,limit_ = 100}, userdel, {group=msg.to.id})
tdcli.sendMessage(msg.to.id, msg.id, 1, '❖￤ تم طـرد آلحسـآبآت آلمـحذوفهہ‏‏ 🌿', 1, 'md') 
end 
--------------------- Welcome -----------------------
if matches[1] == "تفعيل" and is_mod(msg) then
if matches[2] == "الردود" then
return unlock_replay(msg)
end
if matches[2] == "البوت خدمي" then
return unlock_service(msg)
end
if matches[2] == "الاذاعه" and is_sudo(msg) then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
return unlock_brod(msg)
end
if matches[2] == "الايدي" then
if redis:get(rami..'lock_id'..msg.to.id) then
return "❖￤ _مرحبا عزيزي_\n❖￤ _امر الايدي شغال بالفعل_ ✓"
else
redis:set(rami..'lock_id'..msg.to.id,true) 
return "❖￤ _مرحبا عزيزي_\n❖￤ _تم تفعيل امر الايدي_ ✓"
end
end
if matches[2] == "الترحيب" then
if redis:get(rami..'welcome:get'..msg.to.id) then
return "❖￤ _مرحبا عزيزي_\n❖￤ _تفعيل الترحيب مفعل مسبقاً_ ✓"
else
redis:set(rami..'welcome:get'..msg.to.id,true) 
return "❖￤ _مرحبا عزيزي_\n❖￤ _تم تفعيل الترحيب_ ✓"
end
end
if matches[2] == "التحذير" then
if redis:get(rami..'lock_woring'..msg.to.id) then
return "❖￤ _مرحبا عزيزي_\n❖￤ _تفعيل التحذير مفعل مسبقاً_ ✓"
else
redis:set(rami..'lock_woring'..msg.to.id,true)
return "❖￤ _مرحبا عزيزي_\n❖￤ _تم تفعيل التحذير_ ✓"
end end end
-------------------
if matches[1] == "تعطيل" and is_mod(msg) then
if matches[2] == "الردود" then
return lock_replay(msg)
end
if matches[2] == "البوت خدمي" then
return lock_service(msg)
end
if matches[2] == "الاذاعه" and is_sudo(msg) then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
return lock_brod(msg)
end
if matches[2] == "الايدي" then
if not redis:get(rami..'lock_id'..msg.to.id) then
return "❖￤ _مرحبا عزيزي_\n❖￤ _الايدي بالتأكيد معطل_ ✓"
else
redis:del(rami..'lock_id'..msg.to.id)
return "❖￤ _مرحبا عزيزي_\n❖￤ _تم تعطيل امر الايدي_ ✓"
end
end
if matches[2] == "الترحيب" then
if not redis:get(rami..'welcome:get'..msg.to.id) then
return "❖￤ _مرحبا عزيزي_\n❖￤ _الترحيب بالتأكيد معطل_ ✓"
else
redis:del(rami..'welcome:get'..msg.to.id)
return "❖￤ _مرحبا عزيزي_\n❖￤ _تم تعطيل الترحيب_ ✓"
end
end
if matches[2] == "التحذير" then
if not redis:get(rami..'lock_woring'..msg.to.id) then
return "❖￤ _مرحبا عزيزي_\n❖￤ _التحذير بالتأكيد معطل_ ✓"
else
redis:del(rami..'lock_woring'..msg.to.id)
return "❖￤ _مرحبا عزيزي_\n❖￤ _تم تعطيل التحذير_ ✓"
end end end
if matches[1] == "ضع الترحيب" and is_mod(msg) then
redis:set(rami..'welcom:witting'..msg.from.id,true)
return "📭¦ حسنآ عزيزي  ✋🏿\n❖￤ ارسل كليشه الترحيب الان 🍃"
end
if matches[1] == "الترحيب"  and is_mod(msg) then
if redis:get(rami..'welcome:msg'..msg.to.id)  then
return redis:get(rami..'welcome:msg'..msg.to.id)
else
return "❖￤ مرحباً عزيزي\n❖￤ نورت المجموعه \n❖￤ تابع : @TH3VICTORY \n💂🏼‍♀️"
end
end
if matches[1] == "رفع الادمنيه" and is_owner(msg) then
set_config(msg)
end
if matches[1] == "كشف"  then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="whois"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="whois"})
end
end

end -- نهايه حصانه اذا كان المجموعه مفعله




if matches[1] == 'اذاعه عام بالتوجيه' and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(rami..'lock_brod') then 
return "❖￤ هذا الامر للمطور الاساسي فقط  🛠" 
end
redis:setex(rami..'fwd:'..msg.from.id,300, true)
return "📭¦ _حسنآ الان ارسل التوجيه للاذاعه _🍃\n"
end

if matches[1] == 'اذاعه عام' and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(rami..'lock_brod') then 
return "❖￤ هذا الامر للمطور الاساسي فقط  🛠" 
end
redis:setex(rami..'fwd:all'..msg.from.id,300, true)
return "📭¦ _حسنآ الان ارسل الكليشه للاذاعه عام _🍃\n"
end

if matches[1] == 'اذاعه خاص' and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(rami..'lock_brod') then 
return "❖￤ هذا الامر للمطور الاساسي فقط  🛠" 
end
redis:setex(rami..'fwd:pv'..msg.from.id,300, true)
return "📭¦ _حسنآ الان ارسل الكليشه للاذاعه خاص _🍃\n"	
end

if matches[1] == 'اذاعه' and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(rami..'lock_brod') then 
return "❖￤ هذا الامر للمطور الاساسي فقط  🛠" 
end
redis:setex(rami..'fwd:groups'..msg.from.id,300, true)
return "📭¦ _حسنآ الان ارسل الكليشه للاذاعه للمجموعات _🍃\n"	
end

----------------- استقبال الرسائل ---------------
if msg.text then
if (msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")) and redis:get(rami..'waiting_link'..msg.from.id) and is_owner(msg) then  -- استقبال الرابط
redis:set(rami..'linkgp'..msg.to.id,msg.text)
return "❖￤ _شكرأ لك 😻_\n❖￤ _تم حفظ الرابط بنجاح _✓"
end
----------------------------------------------------
if redis:get(rami..'welcom:witting'..msg.from.id) then -- استقبال كليشه الترحيب
redis:del(rami..'welcom:witting'..msg.from.id)
redis:set(rami..'welcome:msg'..msg.to.id,check_markdown(msg.text))
return "❖￤ _تم وضع الترحيب بنجاح كلاتي 👋🏻_\n*"..check_markdown(msg.text).."*\n\n❖￤ _ملاحظه تستطيع_\n❖￤ _اضهار القوانين بواسطه _ ➣ *{rules}*  \n❖￤ _ اضهار الاسم بواسطه_ ➣ *{name}*\n❖￤ _ اضهار المعرف بواسطه_ ➣ *{username}*"
end
--------------------------------------------------------------------
if redis:get(rami..'rulse:witting'..msg.from.id) then --- استقبال القوانين
redis:del(rami..'rulse:witting'..msg.from.id)
redis:set(rami..'rulse:msg'..msg.to.id,check_markdown(msg.text))
return '❖￤ _مرحبآ عزيزي_\n❖￤ _تم حفظ القوانين بنجاح_✓\n❖￤ _اكتب [ القوانين ] لعرضها 📬_'
end
----------------------------------------------------------
if redis:get(rami..'name:witting'..msg.from.id) then --- استقبال الوصف
redis:del(rami..'name:witting'..msg.from.id)
tdcli.changeChatTitle(msg.to.id, msg.text, dl_cb, nil)
return "📭¦ تم تغير اسم المجموعه  ✋🏿\n❖￤ الان اسمه `"..check_markdown(msg.text).."` 🍃"
end
--------------------------------------------------------------
if redis:get(rami..'about:witting'..msg.from.id) then --- استقبال الوصف
redis:del(rami..'about:witting'..msg.from.id)
if msg.to.type == "channel" then
tdcli.changeChannelAbout(msg.to.id, msg.text, dl_cb, nil)
end
return "❖￤ _تم وضع الوصف بنجاح_✓"
end
--------------------------------------------------------------------
if redis:get(rami..'fwd:all'..msg.from.id) then ---- استقبال رساله الاذاعه عام
redis:del(rami..'fwd:all'..msg.from.id)
local pv = redis:smembers(rami..'users')  
local groups = redis:smembers(rami..'group:ids')
for i = 1, #pv do
tdcli.sendMessage(pv[i], 0, 0, check_markdown(msg.text), 0)			
end
for i = 1, #groups do
tdcli.sendMessage(groups[i], 0, 0, check_markdown(msg.text), 0)			
end
tdcli.sendMessage(msg.to.id, 0, 0, '❖￤ تم اذاعه الى `'..#groups..'` مجموعات 🍃', 0)			
tdcli.sendMessage(msg.to.id, 0, 0,'❖￤ تم اذاعه الى `'..redis:scard(rami..'users')..'` من المشتركين 👍🏿', 0)
end
---------------------------------------------------------------------------------
if redis:get(rami..'fwd:pv'..msg.from.id) then ---- استقبال رساله الاذاعه خاص
redis:del(rami..'fwd:pv'..msg.from.id)
local pv = redis:smembers(rami..'users')
for i = 1, #pv do
tdcli.sendMessage(pv[i], 0, 0, check_markdown(msg.text), 0)			
end
tdcli.sendMessage(msg.to.id, 0, 0,'❖￤ تم اذاعه الى `'..redis:scard(rami..'users')..'` من المشتركين 👍🏿', 0)
end
---------------------------------------------------------------------------------
if redis:get(rami..'fwd:groups'..msg.from.id) then ---- استقبال رساله الاذاعه خاص
redis:del(rami..'fwd:groups'..msg.from.id)
local groups = redis:smembers(rami..'group:ids')
for i = 1, #groups do
tdcli.sendMessage(groups[i], 0, 0, check_markdown(msg.text), 0)			
end
tdcli.sendMessage(msg.to.id, 0, 0, '❖￤ تم اذاعه الى `'..#groups..'` مجموعات 🍃', 0)			
end
---------------------------------------------------------------------------------
end
end------------ نهايه الحصانه داخل المجموعه
end--------- نهايه فاكشن الرن 
-----------------------------------------
local function pre_process(msg)
local function welcome_cb(arg, data)
if redis:get(rami..'welcome:msg'..msg.to.id) then
welcome = redis:get(rami..'welcome:msg'..msg.to.id) 
else
welcome = "❖￤ مرحباً عزيزي\n❖￤ نورت المجموعه \n❖￤ تابع : @TH3VICTORY\n💂🏼‍♀️"
end
if redis:get(rami..'rulse:msg'..msg.to.id) then
rules = redis:get(rami..'rulse:msg'..msg.to.id)
else
rules = "❖￤ _مرحبأ عزيري_ 👋🏻 _القوانين كلاتي_ 👇🏻\n❖￤ _ممنوع نشر الروابط_ \n❖￤ _ممنوع التكلم او نشر صور اباحيه_ \n❖￤ _ممنوع  اعاده توجيه_ \n❖￤ _ممنوع التكلم بلطائفه_ \n❖￤ _الرجاء احترام المدراء والادمنيه _😅\n❖￤ _تابع _@TH3VICTORY 💤\n💂🏼‍♀️"
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
local welcome = welcome:gsub("{rules}", rules)
local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
local welcome = welcome:gsub("{username}", user_name)
local welcome = welcome:gsub("{gpname}", arg.gp_name)
tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
end
if redis:get(rami..'group:add'..msg.to.id) and redis:get(rami..'welcome:get'..msg.to.id) and msg.adduser ~= tonumber(our_id) then
if msg.adduser then
tdcli.getUser(msg.adduser, welcome_cb, {chat_id=msg.to.id,msg_id=msg.id_,gp_name=msg.to.title})
end
if msg.joinuser then
tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=msg.to.id,msg_id=msg.id_,gp_name=msg.to.title})
end
end
end

return {
patterns ={
"^(ايدي)$",
"^(ايدي) (@[%a%d%_]+)$",
"^(كشف)$",
"^(كشف) (%d+)$",
"^(كشف) (@[%a%d%_]+)$",
'^(الحمايه)$',
'^(الاعدادات)$',
'^(الوسائط)$',
'^(تثبيت)$',
'^(الغاء التثبيت)$',
'^(تفعيل)$',
'^(تعطيل)$',
'^(رفع الادمنيه)$',
'^(رفع المدير)$',
'^(رفع المدير) (@[%a%d%_]+)$',
'^(رفع المدير) (%d+)$',
'^(تنزيل المدير) (@[%a%d%_]+)$',
'^(تنزيل المدير) (%d+)$',
'^(تنزيل المدير)$',
'^(رفع عضو مميز) (@[%a%d%_]+)$',
'^(رفع عضو مميز) (%d+)$',
'^(تنزيل عضو مميز) (@[%a%d%_]+)$',
'^(تنزيل عضو مميز) (%d+)$',
'^(رفع عضو مميز)$',
'^(تنزيل عضو مميز)$',
'^(الاعضاء المميزين)$',
'^(رفع ادمن)$',
'^(رفع ادمن) (@[%a%d%_]+)$',
'^(رفع ادمن) (%d+)$',
'^(تنزيل ادمن) (@[%a%d%_]+)$',
'^(تنزيل ادمن) (%d+)$',
'^(تنزيل ادمن)$',
'^(رفع المدير)$',
'^(رفع المدير) (@[%a%d%_]+)$',
'^(رفع المدير) (%d+)$',
'^(تنزيل المدير)$',
'^(تنزيل المدير) (@[%a%d%_]+)$',
'^(تنزيل المدير) (%d+)$',
'^(قفل) (.*)$',
'^(فتح) (.*)$',
'^(تفعيل) (.*)$',
'^(تعطيل) (.*)$',
'^(الرابط خاص)$',
'^(تغير الرابط)$',
'^(المجموعه)$',
'^(القوانين)$',
'^(الرابط)$',
'^(ضع رابط)$',
'^(ضع القوانين)$',
'^(ضع تكرار) (%d+)$',
'^(مسح) (.*)$',
'^(الوصف)$',
'^(ضع صوره)$',
'^(ضع وصف)$',
'^(ضع اسم)$',
'^(قائمه المنع)$',
'^(المدراء)$',
'^(الادمنيه)$',
'^(طرد البوتات)$',
'^(طرد المحذوف)$',
'^(طرد الكل)$',
'^(كشف البوتات)$',
'^(منع) (.*)$',
'^(الغاء منع) (.*)$',
'^(ضع الترحيب)$',
'^(الترحيب)$',
"^(اذاعه عام بالتوجيه)$",
"^(اذاعه عام)$",
"^(اذاعه خاص)$",
"^(اذاعه)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^!!tgservice (.+)$",
"(.*)" 
},
run=syria,
pre_process = pre_process
}

-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
