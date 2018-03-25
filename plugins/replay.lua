-- BY RAMI SYRIA
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

do 
local function run(msg, matches) 
if redis:get(rami..'bot:name') then
bot_name = redis:get(rami..'bot:name') 
else
bot_name = 'الدولة'
end

if is_silent_user(msg.from.id, msg.to.id) then return end
if msg.from.id == bot.id then return end

local r =  matches[1]
local r2 = matches[2]
local r3 = matches[3]
local r4 = matches[4]

if msg.from.username then
usernamex = "@"..(msg.from.username or "---")
else
usernamex = "️ ما مسوي  😹💔 "
end

---------------[bot out]---------------------------

if r==bot_name and r2== 'غادر' and is_sudo(msg) then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك معلم باي 😢💔🛠', 1, 'html')
botrem(msg)
end   
-------[/start and welcom and save user id ]-----------
-- BY RAMI SYRIA
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

if r=="المشتركين" and is_sudo(msg) and msg.to.type == 'pv'  then
  local users = '❖￤ عدد المشتركين  `'..redis:scard(rami..'users')..'` *مشترك في البوت *🍃'
return users
end

if r=="/start" and msg.to.type == 'pv'  then
 redis:sadd(rami..'users',msg.from.id)
return [[❖￤ مـرحبآ آنآ بوت آسـمـي ]]..bot_name..[[ 🎖
❖￤ آختصـآصـي حمـآيهہ‏‏ آلمـجمـوعآت
❖￤ مـن آلسـبآم وآلتوجيهہ‏‏ وآلتگرآر وآلخ...
❖￤ فقط آلمـطـور يسـتطـيع تفعيل آلبوت
❖￤ مـعرف آلمـطـور  : ]]..sudouser..[[

👨🏽‍🔧]]
end
if r == "ضع اسم للبوت" then
if not we_sudo(msg) then return "❖￤️هذا الامر للمطور الاساسي فقط 🛠" end
redis:setex(rami..'namebot:witting'..msg.from.id,300,true)
return"❖￤ حسننا عزيزي  ✋🏿\n❖￤ الان ارسل الاسم  للبوت 🍃"
end

if (msg.to.type == "pv") and is_sudo(msg) and msg.from.id ~= bot.id then -- ارسال الرساله بالخاص عبر رد على التوجيه
if msg.reply_id then
function get_msg_id(arg, data)
function replay_fwd(arg,data)
if data.forward_info_ then
function infousers(arg,data)
if data.username_ then
user_name = '@'..data.username_
else
user_name = data.first_name_
end
tdcli.sendMessage(arg.user_id, 0,1,check_markdown(r), 1, 'html')
tdcli.sendMessage(msg.from.id, msg.id_,1,"📬¦ تم آرسـآل آلرسـآل‏‏هہ 🌿\n🎟¦ آلى : "..user_name.." 🏌🏻", 1, 'html')
end
tdcli_function ({ID = "GetUser",user_id_ = data.forward_info_.sender_user_id_}, infousers, {user_id=data.forward_info_.sender_user_id_}) 
end end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, replay_fwd, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_msg_id, nil)
end
end
 if (msg.to.type == "pv") then
 if r=="رتبتي" then
if we_sudo(msg) then
rank = 'المطور الاساسي 🛠'
elseif is_sudo(msg) then
rank = 'المطور مالتي 😻'
else
rank = 'مجرد عضو 😹'
end
return '❖￤ رتبتك : '..rank
end
end
 
if (msg.to.type == "pv") and  not is_sudo(msg) and msg.from.id ~= bot.id then -- ارسال رساله للاعضاء الي يدخلون خاص

tdcli.sendMessage(msg.to.id, 0, 1, "❖￤ تم آرسـآل رسـآلتگ آلى آلمـطـور\n📬¦ سـآرد عليگ في آقرب وقت\n🎟¦ـ "..sudouser.." \n 🏌️", 1, 'md')
tdcli.forwardMessages(SUDO,msg.to.id, {[0] = msg.id}, 0)
end
if (r=="تيست" or r=="test") and is_sudo(msg) then
return "🛠 البوت شـغــال 🚀"
end
----------------------------------------------------
---------------[End Function data] -----------------------

if r=="اضف رد للكل" then
if not we_sudo(msg) then return "❖￤️هذا الامر للمطور الاساسي فقط 🛠" end
redis:setex(rami..'addrd_all:'..msg.from.id,300 , true)
redis:del(rami..'allreplay:'..msg.from.id)
return "❖￤ _حسننا الان ارسل كلمة الرد العام _🍃\n"
end
------------------------------------------------------
if msg.text then
if redis:get(rami..'namebot:witting'..msg.from.id) then --- استقبال اسم البوت
redis:del(rami..'namebot:witting'..msg.from.id)
redis:set(rami..'bot:name',msg.text)
reload_plugins( )
return "❖￤ تم تغير اسم البوت  ✋🏿\n❖￤ الان اسمه `"..check_markdown(r).."` 🍃"
end

if redis:get(rami..'addrd_all:'..msg.from.id) then -- استقبال الرد لكل المجموعات
if not redis:get(rami..'allreplay:'..msg.from.id) then-- استقبال كلمه الرد لكل المجموعات
redis:setex(rami..'allreplay:'..msg.from.id, 300 , msg.text )
return "❖￤ _شكرأ لك 😻_\n❖￤ _الان ارسل جواب الرد _✔️" 
end
if redis:get(rami..'allreplay:'..msg.from.id) then -- استقبال جواب الرد لكل المجموعات
redis:hset(rami..'replay:all', redis:get(rami.."allreplay:"..msg.from.id), msg.text)
redis:del(rami..'addrd_all:'..msg.from.id)
return '('..check_markdown(redis:get(rami..'allreplay:'..msg.from.id))..')\n  ✓ تم اضافة الرد لكل المجموعات 🚀 '
end
end
-------------------------------------------------------------
if redis:get(rami..'addrd:'..msg.from.id) then -- استقبال الرد للمجموعه فقط
if not redis:get(rami..'replay1'..msg.from.id) then  -- كلمه الرد
redis:setex(rami..'replay1'..msg.from.id,300,msg.text)
return "❖￤ _شكرأ لك 😻_\n❖￤ _الان ارسل جواب الرد _✔️" 
end
if redis:get(rami..'replay1'..msg.from.id) then -- جواب الرد
redis:hset(rami..'replay:'..msg.to.id, redis:get(rami.."replay1"..msg.from.id), msg.text)
redis:del(rami..'addrd:'..msg.from.id)
return '('..check_markdown(redis:get(rami..'replay1'..msg.from.id))..')\n  ✓ تم اضافت الرد 🚀 '
end
end

--------------------------------------
if redis:get(rami..'delrd:'..msg.from.id) then
redis:del(rami..'delrd:'..msg.from.id)

if not redis:hget(rami..'replay:'..msg.to.id,msg.text) then
return '🗯هذا الرد ليس مضاف في قائمه الردود 🛠'
else
redis:hdel(rami..'replay:'..msg.to.id,msg.text)
return '('..check_markdown(msg.text)..')\n  ✓ تم مسح الرد 🚀 '
end
end
-------------------------------------
if redis:get(rami..'delrdall:'..msg.from.id) then
redis:del(rami..'delrdall:'..msg.from.id)
if not redis:hget(rami..'replay:all',msg.text) then
return '🗯هذا الرد ليس مضاف في قائمه الردود 🛠'
else
redis:hdel(rami..'replay:all',msg.text)
return '('..check_markdown(msg.text)..')\n  ✓ تم مسح الرد 🚀 '
end
end

end
--------------------------------------------

if r== 'مسح الردود' then
if not is_owner(msg) then return"♨️ للمدراء فقط ! 🛠" end
local names = redis:hkeys(rami..'replay:'..msg.to.id)
for i=1, #names do
redis:hdel(rami..'replay:'..msg.to.id,names[i])
end
return "✓ تم مسح كل الردود 🚀"
end

if r== 'مسح الردود العامه' then
if not is_owner(msg) then return"♨️ للمدراء فقط ! 🛠" end
local names = redis:hkeys(rami..'replay:all')
for i=1, #names do
redis:hdel(rami..'replay:all',names[i])
end
return "✓ تم مسح كل الردود العامه🚀"

end

if r== 'مسح رد عام' then
if not is_owner(msg) then return"♨️ للمدراء فقط ! 🛠" end
redis:set(rami..'delrdall:'..msg.from.id,true)
return "❖￤ حسننا عزيزي  ✋🏿\n❖￤ الان ارسل الرد لمسحه من  المجموعات 🍃"
end

if r== 'مسح رد' then
if not is_owner(msg) then return"♨️ للمدراء فقط ! 🛠" end
redis:set(rami..'delrd:'..msg.from.id,true)
return "❖￤ حسننا عزيزي  ✋🏿\n❖￤ الان ارسل الرد لمسحه من  للمجموعه 🍃"
end

if r== 'الردود' then
local names = redis:hkeys(rami..'replay:'..msg.to.id)
local i = 1
local message = '❖￤ ردود البوت في المجموعه  🛠\n\n'
for i=1, #names do
message = message ..i..' - ('..names[i]..') \n'
i = i + 1
end
if message ~='❖￤ ردود البوت في المجموعه  🛠\n\n' then
return message
else
return "👨🏾‍🔧¦ لا يوجد ردود مضافه للمجموعـة ✋🏿"
end
end

if r== 'الردود العامه' then
local names = redis:hkeys(rami..'replay:all')
local i = 1
local message = '❖￤ ردود العامه في البوت  🛠\n\n'
for i=1, #names do
message = message ..i..' - ('..names[i]..') \n'
i = i + 1
end
if message ~= '❖￤ ردود العامه في البوت  🛠\n\n' then
return message
else
return "👨🏾‍🔧¦ لا يوجد ردود مضافه للمجموعات ✋🏿"
end

end

-- by @RAMBO_SYR

if not redis:get(rami..'group:add'..msg.to.id) then return end

--------------------[Test Bot]----------------------------
if r=="اضف رد" then
if not is_owner(msg) then return"♨️ للمدراء فقط ! 🛠" end
redis:setex(rami..'addrd:'..msg.from.id,300 , true)
redis:del(rami.."replay1"..msg.from.id)
return "❖￤ _حسننا الان ارسل كلمة الرد _🍃\n"
end


if r== "اسمي" then
return  "\n" ..msg.from.first_name.."\n" 
elseif r== "معرفي" then
return  "@"..(msg.from.username or "لايوجد").."\n" 
elseif r== "ايديي" then
return  "\n"..msg.from.id.."\n" 
elseif r=="صورتي" then
local function getpro(arg, data)
if data.photos_[0] then
tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,"",dl_cb,nil)
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "❖￤لا يوجد صوره في بروفايلك ...", 1, 'md')
end end
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.from.id,offset_ = 0,limit_ = 1}, getpro, nil)
elseif r=="بدي رابط الحذف" or r=="اريد رابط حذف" or r=="رابط حذف" or r=="رابط الحذف" then
return [[
❖￤ رابط حذف حـساب التيليگرام ↯
❖￤ لا تتندم فڪر قبل ڪلشي 
❖￤ بالتـوفيـق عزيزي ...
❖￤ـ  https://telegram.org/deactivate
]] 
elseif r=="رتبتي" then
local rank
if we_sudo(msg) then
rank = 'المطور الاساسي 🛠'
elseif is_sudo(msg) then
rank = 'المطور مالتي 😻'
elseif is_owner(msg) then
rank = 'مدير المجموعه 😽'
elseif is_mod(msg) then
rank = ' ادمن في البوت 😺'
elseif is_whitelist(msg.from.id,msg.to.id) then
rank = 'عضو مميز 🎖'
else
rank = 'مجرد عضو 😹'
end
return '❖￤ رتبتك : '..rank
end
------------[lock and unlock reply in pv ]---------


if redis:get(rami..'replay'..msg.to.id) then

if ( msg.text ) and ( msg.to.type == "channel" ) or ( msg.to.type == "chat" ) then
----------------------
-- by @rami
local su = {
"نعم حبيبي المطور 🌝❤",
"يابعد روح "..bot_name.." 😘❤️",
"هلا بمطوري الغالي أمرني"
}
local  ss97 = {
"ها حياتي😻",
"عيونه 👀 وخشمه 👃🏻واذانه👂🏻",
"باقي ويتمدد 😎",
"ها حبي 😍",
"ها عمري 🌹",
"اجيت اجيت حاج لا تصيح 🌚👌",
"هياتني اجيت 🌚❤️",
"نعم حبي 😎",
"هوووه لك خلي يسكت صرع ربي 😷",
"احكي بسرعه شو بدك 😤",
"ها يا قلبي ❤️",
"كمان صاحو عليي رح اغير اسمي من وراكم 😡",
"لك فداك "..bot_name.." حبيبي انت اموووح 💋",
"عم اشرب متة تعال بعدين 😌",
"قول حبيبي أمرني 😍",
"احكي خلصني شو بدك ولا تصير ظريف وتقلي جرايد او مجلات تره بايخه 😒😏",
"اشتعلو اهل "..bot_name.." شو بدك 😠",
"بووووووووو 👻 ها ها فزيت شفتك شفتك لا تحلف 😂",
"طالع مموجود 😒",
"هااا شوو في قحبة بالكروب وصحت عليه  😍💕",
"انت مو قبل يومين غلطت عليي؟  😒",
"راجع عالمكتب حبيبي عبالك "..bot_name.." سهل تحكي معاه 😒",
"ياعيون "..bot_name.." أمرني 😍",
"لك عم ابدل تيابي اطلع برااااا 😵😡 ناس ماتستحي",
"سويت كتير شغلات سخيفه بحياتي بس بعمري ماصحت على واحد وقلتلو خراس 😑",
"مشغول مع صاحبتب  ☺️",
"ماذا تريد منه 😌🍃",

}
local bs = {
"مابوس 🌚💔",
"اآآآم͠ــ.❤️😍ــو͠و͠و͠آ͠آ͠ح͠❤️عسسـل❤️",
"الوجه ميساعد 😐✋",
"ممممح😘ححح😍😍💋",
}
local ns = {
"🌹 هــلــℌelℓoووات🌹عمـ°🌺°ــري🙊😋",
"هْـٌﮩٌﮧٌ﴿🙃﴾ﮩٌـ୭ٌ୭ـْلوُّات†😻☝️",
"هلاوو99وووات نورت/ي ❤️🙈",
"هلووات 😊🌹",
}
local sh = {
"اهلا عزيزي المطور 😽❤️",
"هلوات . نورت مطوري 😍",
}
local lovs =  "اموت عليك حياتي  😍❤️"
local  lovm = {
"اكرهك 😒👌🏿",
"دي 😑👊🏾",
"اعشقك/ج مح 😍💋",
"اي احبك/ج 😍❤️",
"مابحبك/ج 😌🖖",
"امـــوت فيك ☹️",
"اذا قتلك احبك شو راح تستفاد/ي 😕❤️",
"ولي مابحبك 🙊💔",
}
local thb = {
"اموت عليه-ه 😻😻",
"فديته-ه 😍❤️",
"لا مابحبو 🌚💔",
"اكرهه 💔🌚",
"يييع 😾👊🏿",
"مابعرف عم افڱﮩﮩﮩر🐸💔"
}
local song = {
"عمي يبو البار 🤓☝🏿️ \nصبلي لبلبي ترى اني سكران 😌 \n وصاير عصبي 😠 \nانه وياج يم شامه 😉 \nوانه ويــــاج يم شامه  شد شد  👏🏿👏🏿 \nعدكم سطح وعدنه سطح 😁 \n نتغازل لحد الصبح 😉 \n انه وياج يم شامه 😍 \n وانه وياج فخريه وانه وياج حمديه 😂🖖🏿\n ",
"اي مو كدامك مغني قديم 😒🎋 هوه ﴿↜ انـِۨـۛـِۨـۛـِۨيـُِـٌِہۧۥۛ ֆᵛ͢ᵎᵖ ⌯﴾❥  ربي كامز و تكلي غنيلي 🙄😒🕷 آإرۈحُـ✯ـہ✟  😴أنــ💤ــااااام😴  اشرف تالي وكت يردوني اغني 😒☹️🚶",
"لا تظربني لا تظرب 💃💃 كسرت الخيزارانه💃🎋 صارلي سنه وست اشهر💃💃 من ظربتك وجعانه🤒😹",
"موجوع كلبي😔والتعب بية☹️من اباوع على روحي😢ينكسر كلبي عليه😭",
"ايامي وياها👫اتمنا انساها😔متندم اني حيل😞يم غيري هيه💃تضحك😂عليه😔مقهور انام الليل😢كاعد امسح بل رسائل✉️وجان اشوف كل رسايلها📩وبجيت هوايه😭شفت احبك😍واني من دونك اموت😱وشفت واحد 🚶صار هسه وياية👬اني رايدها عمر عمر تعرفني كل زين🙈 وماردت لا مصلحة ولاغايه😕والله مافد يوم بايسها💋خاف تطلع🗣البوسه💋وتجيها حجايه😔️",
"😔صوتي بعد مت سمعه✋يال رايح بلا رجعة🚶بزودك نزلت الدمعة ذاك اليوم☝️يال حبيتلك ثاني✌روح وياه وضل عاني😞يوم اسود علية اني🌚 ذاك اليوم☝️تباها بروحك واضحك😂لان بجيتلي عيني😢😭 وافراح يابعد روحي😌خل الحركة تجويني😔🔥صوتي بعد متسمعة🗣✋",


}

local function sudoname(r2)
if string.match(r2, 'رامي')  or  string.match(r2, 'الدولة') or  string.match(r2, '@RAMBO_SYR') or  string.match(r2, 'رامبو')  or string.match(r2, 'الدولة ابن الاسد') then
return true
else
return false
end
end
local function linkmsg(r2)
if (r2:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or r2:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or r2:match("[Tt].[Mm][Ee]/") or r2:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or r2:match(".[Pp][Ee]") or r2:match("[Hh][Tt][Tt][Pp][Ss]://") or r2:match("[Hh][Tt][Tt][Pp]://") or r2:match("[r2][r2][r2].") or r2:match(".[Cc][Oo][Mm]") or r2:match("@")) then 
return true
else
return false
end
end
----------------------------------------------
if redis:hget(rami..'replay:all', r) then
return check_markdown(redis:hget(rami..'replay:all', r))
elseif redis:hget(rami..'replay:'..msg.to.id, r) then
return check_markdown(redis:hget(rami..'replay:'..msg.to.id, r))
elseif is_sudo(msg) and r== bot_name and not r2 then 
return  su[math.random(#su)]  
elseif not is_sudo(msg) and r== bot_name and not r2 then 
return  ss97[math.random(#ss97)]  
elseif r== "قول" and r2 then
if string.len(r2) > 60 then return "❖￤ ما بقدر اقول اكثر من 60 حرف 🙌🏾" end
if sudoname(r2) then return "📌 ما بقدر احكي عنو مستحيل 🕵🏻" end
if linkmsg(r2) then
return "انته منتاك مثلا ؟ هو انا تلميذو ههه بدو انشر رابط او معرف 😪 " 
end
return tdcli.sendMessage(msg.to.id, 0, 1, '<code>'..r2..'</code>', 1, 'html')
elseif r== "قلو" and r2 then
if string.len(r2) > 60 then return "❖￤ ما مابقدر اقلو اكثر من 60 حرف 🙌🏾" end
if sudoname(r2) then return "📌 ما بقدر احكي عنو مستحيل 🕵🏻" end
if linkmsg(r2) then
return "انته منتاك مثلا ؟ هو انا تلميذو ههه بدو انشر رابط او معرف 😪 " 
end
if msg.reply_id then
return tdcli.sendMessage(msg.to.id, msg.reply_id, 1, '<code>'..r2..'</code>', 1, 'html')
end
elseif r== "اتفل" and r2 then
if sudoname(r2) then return "📌 ما اكدر اتفل عليه مستحيل 🕵🏻" end
if msg.reply_id then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك سيدي 🌝🍃', 1, 'html')
tdcli.sendMessage(msg.to.id, msg.reply_id, 1, 'ختفوووووووووو💦💦️️', 1, 'html')
else 
return"  🕵🏻 وينه بله سويله رد 🙄"
end
elseif r== ""..bot_name.." رزله" and r2 and is_sudo(msg) then
if msg.reply_id then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك سيدي 🌝🍃', 1, 'html')
tdcli.sendMessage(msg.to.id, msg.reply_id, 1, 'يا ول شو طالعة عينك😒 من البنات مو😪و هم صايرلك لسان تحجي😠اشو تعال👋👊صير حباب مرة ثانية ترةة ...😉و لا تخليني البسك عمامة و اتفل عليك😂️', 1, 'html')
end
elseif r== "بوس" and r2 then 
if sudoname(r2) then
return " امممح عـﮩـموري┇🎵™ هذا العشق😻💋"
else
if msg.reply_id then
return  bs[math.random(#bs)] 
else
return "📌 وينه بله سويله رد 🕵🏻"
end
end
elseif r== "تحب" and r2 then
if sudoname(r2) then
return "اموت عليةة عـﮩـموري┇🎵™ هذا العشق😻💋"
else
return  thb[math.random(#thb)] 
end
elseif is_sudo(msg) and r=="هلو" then
return  sh[math.random(#sh)]  
elseif not is_sudo(msg) and r=="هلو" then
return  ns[math.random(#ns)]  
elseif is_sudo(msg) and r== "احبك" then
return  lovs
elseif is_sudo(msg) and r== "تحبني" or r=="حبك"  then
return  lovs
elseif not is_sudo(msg) and r== "احبك" or r=="حبك" then
return  lovm[math.random(#lovm)]  
elseif not is_sudo(msg) and r== "تحبني" then
return  lovm[math.random(#lovm)]  
elseif r== "ڤير"  then
return  ss97[math.random(#ss97)]  
elseif r== "غني" or r=="غنيلي" then
return  song[math.random(#song)] 
elseif r=="اتفل" or r=="تفل" then
if is_mod(msg) then return 'ختفوووووووووو💦💦️️' else return "📌 انجب ما اتفل عيب 😼🙌🏿" end
elseif r== "تف" then
return  "عيب ابني/بتي اتفل/ي اكبر منها شوية 😌😹"
elseif r== "شلونكم" or r== "شلونك" or r== "شونك" or r== "شونكم"   then
return  "احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚"
elseif r== "صاكه"  then
return  "اووويلي يابه 😍❤️ دزلي صورتهه 🐸💔"
elseif r== "وينك"  then
return   "دور بكلبك وتلكاني 😍😍❤️"
elseif r== "منورين"  then
return  "من نورك عمري ❤️🌺"
elseif r== "هاي"  then
return  "هايات عمري 😍🍷"
elseif r== "🙊"  then
return  "فديت الخجول 🙊 😍"
elseif r== "😢"  then
return  "لتبجي حياتي 😢"
elseif r== "😭"  then
return  "لتبجي حياتي 😭😭"
elseif r== "منور"  then
return  "نِْـِْـــِْ([💡])ِْــــًِـًًْـــِْـِْـِْـورِْكِْ"
elseif r== "😒" and not is_sudo then
return  "شبيك-ج عمو 🤔"
elseif r== "مح"  then
return  "محات حياتي🙈❤"
elseif r== "شكرا" or r== "ثكرا" then
return  "{ •• الـّ~ـعـفو •• }"
elseif r== "انته وين"  then
return  "بالــبــ🏠ــيــت"
elseif r== "😍"  then
return  " يَمـه̷̐ إآلُحــ❤ــب يَمـه̷̐ ❤️😍"
elseif r== "اكرهك"  then
return  "ديله شلون اطيق خلقتك اني😾🖖🏿🕷"
elseif r== "اريد اكبل"  then
return  "خخ اني هم اريد اكبل قابل ربي وحد😹🙌️"
elseif r== "باي" or r=="بااي" or r=="باااي" or r=="بااااي" then
return  "بايات حياتي ❤️ " ..check_markdown(msg.from.first_name).."\n"
elseif r== "ضوجه"  then
return  "شي اكيد الكبل ماكو 😂 لو بعدك/ج مازاحف/ة 🙊😋"
elseif r== "اروح اصلي"  then
return  "انته حافظ سوره الفاتحة😍❤️️"
elseif r== "صاك"  then
return  "زاحفه 😂 منو هذا دزيلي صورهه"
elseif r== "اجيت" or r=="اني اجيت" then
return  "كْـٌﮩٌﮧٌ﴿😍﴾ـﮩٌول الـ୭ـهـٌ୭ـْلا❤️"
elseif r== "طفي السبلت"  then
return  "تم اطفاء السبلت بنجاح 🌚🍃"
elseif r== "شغل السبلت"  then
return  "تم تشغيل السبلت بنجاح بردتو مبردتو معليه  🌚🍃"
elseif r== "حفلش"  then
return  "افلش راسك 🤓"
elseif r=="نايمين" then
return  "ني سهران احرسكـم😐🍃'"
elseif r=="اكو احد" then
return  "يي عيني انـي موجـود🌝🌿"
elseif r=="شكو" then
return  "كلشي وكلاشي🐸تگـول عبالك احنـة بالشورجـة🌝"
elseif r=="انتة منو" then
return  "آني كـامل مفيد اكبر زنگين أگعدة عالحديـد🙌"
elseif r=="كلخرا" then
return  "خرا ليترس حلكك/ج ياخرا يابنلخرا خختفووو ابلع😸🙊💋"
elseif r== "حبيبتي"  then
return  "منو هاي 😱 تخوني 😔☹"
elseif r== "حروح اسبح"  then
return  "واخيراً 😂"
elseif r== "😔"  then
return  "ليش الحلو ضايج ❤️🍃"
elseif r== "☹️"  then
return  "لضوج حبيبي 😢❤️🍃"
elseif r== "جوعان"  then
return  "تعال اكلني 😐😂"
elseif r== "تعال خاص" or r== "خاصك" or r=="شوف الخاص" or r=="شوف خاص" then
return  "ها شسون 😉"
elseif r== "لتحجي"  then
return  "وانت شعليك حاجي من حلگگ😒"
elseif r== "معليك" or r== "شعليك" then
return  "عليه ونص 😡"
elseif r== "شدسون" or r== "شداتسوون" or r== "شدتسون" then
return  "نطبخ 😐"
elseif r== bot_name and r2=="شلونك"  then
return "احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚"
elseif r== "يومه فدوه"  then
return  "فدؤه الج حياتي 😍😙"
elseif r== "افلش"  then
return  "باند عام من 30 بوت 😉"
elseif r== "احبج"  then
return  "يخي احترم شعوري 😢"
elseif r== "شكو ماكو"  then
return  "غيرك/ج بل كلب ماكو يبعد كلبي😍❤️️"
elseif r== "اغير جو"  then
return  "😂 تغير جو لو تسحف 🐍 عل بنات"
elseif r== "😋"  then
return  "طبب لسانك جوه عيب 😌"
elseif r== "😡"  then 
return  "ابرد  🚒"  
elseif r== "مرحبا"  then
return  "مراحب 😍❤️ نورت-ي 🌹"
elseif r== "سلام" or r== "السلام عليكم" or r== "سلام عليكم" or r=="سلامن عليكم" or r=="السلامن عليكم" then
return  "وعليكم السلام اغاتي🌝👋" 
elseif r== "واكف"  then
return  "يخي مابيه شي ليش تتفاول😢" 
elseif r== "🚶🏻"  then
return  "لُـﮩـضڵ تتـمشـﮥ اڪعـد ﺳـﯠڵـف 🤖👋🏻"
elseif r== "البوت واكف"  then
return  "هياتني 😐"
elseif r== "ضايج"  then 
return  "ليش ضايج حياتي"
elseif r== "ضايجه"  then
return  "منو مضوجج كبدايتي"
elseif r== "😳" or r== "😳😳" or r== "😳😳😳" then
return  "ها بس لا شفت خالتك الشكره 😳😹🕷"
elseif r== "صدك"  then
return  "قابل اجذب عليك!؟ 🌚"
elseif r== "شغال"  then
return  "نعم عزيزي باقي واتمدد 😎🌿"
elseif r== "تخليني"  then
return  "اخليك بزاويه 380 درجه وانته تعرف الباقي 🐸"
elseif r== "فديتك" or r== "فديتنك"  then
return  "فداكـ/چ ثولان العالـم😍😂" 
elseif r== "بوت"  then
return  "أسمي "..bot_name.." 🌚🌸"
elseif r== "مساعدة"  then
return  "لعرض قائمة المساعدة اكتب الاوامر 🌚❤️"
elseif r== "زاحف"  then
return  "زاحف عله خالتك الشكره 🌝"
elseif r== "حلو"  then
return  "انت الاحلى 🌚❤️"
elseif r== "تبادل"  then
return  "كافي ملينه تبادل 😕💔"
elseif r== "عاش"  then
return  "الحلو 🌝🌷"
elseif r== "مات"  then
return  "أبو الحمامات 🕊🕊"
elseif r== "ورده" or r== "وردة"  then
return  "أنت/ي  عطرها 🌹🌸"
elseif r== "شسمك"  then
return  "مكتوب فوك 🌚🌿"
elseif r== "فديت" or r=="فطيت" then
return  "فداك/ج 💞🌸"
elseif r== "واو"  then
return  "قميل 🌝🌿"
elseif r== "زاحفه" or r== "زاحفة"  then
return  "لو زاحفتلك جان ماكلت زاحفه 🌝🌸"
elseif r== "حبيبي" or r=="حبي"  then
return  "بعد روحي 😍❤️ تفضل"
elseif r== "حبيبتي"  then
return  "تحبك وتحب عليك 🌝🌷"
elseif r== "حياتي"  then
return  "ها حياتي 😍🌿"
elseif r== "عمري"  then
return  "خلصته دياحه وزحف 🌝🌿 "
elseif r== "اسكت"  then
return  "وك معلم 🌚💞"
elseif r== "بتحبني"  then
return  "بحبك اد الكون 😍🌷"
elseif r== "المعزوفه" or r=="المعزوفة" or r=="معزوفه" then
return  "طرطاا طرطاا طرطاا 😂👌"
elseif r== "موجود"  then
return  "تفضل عزيزي 🌝🌸"
elseif r== "اكلك"  then
return  ".كول حياتي 😚🌿"
elseif r== "فدوه" or r=="فدوة" or r=="فطوه" or r=="فطوة" then      
return  "لكلبك/ج 😍❤️"
elseif r== "دي"  then
return  "خليني احہۣۗبہۜۧ😻ہہۖۗڱֆ ̮⇣  🌝💔"
elseif r== "اشكرك"  then
return  "بخدمتك/ج حبي ❤"
elseif r== "😉"  then
return  "😻🙈"
elseif r== "اقرالي دعاء"  then
return "اللهم عذب المدرسين 😢 منهم الاحياء والاموات 😭🔥 اللهم عذب ام الانكليزي 😭💔 وكهربها بلتيار الرئيسي 😇 اللهم عذب ام الرياضيات وحولها الى غساله بطانيات 🙊 اللهم عذب ام الاسلاميه واجعلها بائعة الشاميه 😭🍃 اللهم عذب ام العربي وحولها الى بائعه البلبي اللهم عذب ام الجغرافيه واجعلها كلدجاجه الحافية اللهم عذب ام التاريخ وزحلقها بقشره من البطيخ وارسلها الى المريخ اللهم عذب ام الاحياء واجعلها كل مومياء اللهم عذب المعاون اقتله بلمدرسه بهاون 😂😂😂"
elseif msg.edited and not is_sudo(msg) then
return "سحك وعدل 😹☝🏿"
-------------- صوتيات
elseif r== ""..bot_name.." عفط" and r2 and msg.reply_id and is_sudo(msg) then
if msg.reply_id then
return tdcli.sendVoice(msg.chat_id_, msg.reply_id, 0, 1, nil, 'data/audio/zeg.ogg', nil, nil, '❖￤اسمع الديك  اسمع 🔊')
end
elseif r== ""..bot_name.." بوس" and r2 and msg.reply_id and is_sudo(msg) then
if msg.reply_id then
return tdcli.sendAnimation(msg.to.id, msg.reply_id, 0, 1, nil, "data/photo/rame.mp4", nil, nil, 'مح 💋')  
end
---------------------------------------------
elseif r== "اخرس" or r== "خراس" or r=="اقطع" then
if is_sudo(msg) then 
return   "حاضر تاج راسي خرست 😇 "
elseif is_owner(msg) then
return   "لخاطرك راح اسكت لان مدير وع راسي  😌"
elseif is_mod(msg) then
return   "فوق مامصعدك ادمن ؟؟ انت اخرس 😏"
else
return   "خراس انته لاتنطرد 😏"
end

end
end 
else
return
end
---------------------------------------------

---------------------------------------------

end
return {
patterns = {
"^("..bot_name.." عفط)(.*)$", 
"^("..bot_name.." اتفل)(.*)$", 
"^("..bot_name.." رزله)(.*)$", 
"^("..bot_name.." بوس)(.*)$", 
"^(بوس)(.*)$", 
"^(تحب) (.*)$",
"^("..bot_name..") (.*)$",
"^(قلو) (.*)$",
"^(قول) (.*)$",
"^(بوس) (.*)$", 
"^(مسح رد عام)$",
"^(مسح رد)$",
"(.*)" 
},
run = run,
}
end
-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
