--[[
by @RAMBO_SYR  \ @ramixnxx_bot
اي استفسار او لديك مشكله تابع قناتي @Xxx_DEVRAMI_xxX 
او مراسلتي ع الخاص
]]
local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

--By @RAMBO_SYR
local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function sudolist(msg)
local sudo_users = _config.sudo_users
text = "*💢¦ قائمه المطورين : *\n"
for i=1,#sudo_users do
    text = text..i.." - "..sudo_users[i].."\n"
end
return text
end


local function chat_list(msg)
	i = 1
	local data = load_data(_config.moderation.data)
    local groups = 'groups'
    if not data[tostring(groups)] then
        return 'لا يوجد مجموعات مفعلة حاليا .'
    end
    local message = '💢¦ قـائمـه الـكـروبـات :\n\n'
    for k,v in pairsByKeys(data[tostring(groups)]) do
		local group_id = v
		if data[tostring(group_id)] then
			settings = data[tostring(group_id)]['settings']
		end
        for m,n in pairsByKeys(settings) do
			if m == 'set_name' then
				name = n:gsub("", "")
				chat_name = name:gsub("‮", "")
				 group_name_id = name .. ' \n* ايدي : [<code>' ..group_id.. '</code>]\n'

					group_info = i..' ـ '..group_name_id

				i = i + 1
			end
        end
		message = message..group_info
    end
	send_msg(msg.to.id, message,nil,"html")
end

 function botrem(msg)
	local data = load_data(_config.moderation.data)
	if data[tostring(msg.to.id)] then
	data[tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	local groups = 'groups'
	if not data[tostring(groups)] then
		data[tostring(groups)] = nil
		save_data(_config.moderation.data, data)
	end
	data[tostring(groups)][tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	if redis:get('CheckExpire::'..msg.to.id) then
		redis:del('CheckExpire::'..msg.to.id)
	end
	if redis:get('ExpireDate:'..msg.to.id) then
		redis:del('ExpireDate:'..msg.to.id)
	end
	  leave_group(msg.to.id)
	end
  leave_group(msg.to.id)
end

local function warning(msg)
local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
if expiretime == -1 then
return
else
local d = math.floor(expiretime / 86400) + 1
if tonumber(d) == 1 and not is_sudo(msg) and is_mod(msg) then
send_msg(msg.to.id,'💢¦ يرجى التواصل مع مطور البوت لتجديد اشتراك البوت والا ساخرج تلقائيا ‼️', msg.id, 'md')
end
end
end
local function pre_process(msg)
if msg.to.type ~= 'private' then
local data = load_data(_config.moderation.data)
local gpst = data[tostring(msg.to.id)]
local chex = redis:get('CheckExpire::'..msg.to.id)
local exd = redis:get('ExpireDate:'..msg.to.id)
if gpst and not chex and msg.from.id ~= sudo_id and not is_sudo(msg) then
redis:set('CheckExpire::'..msg.to.id,true)
redis:set('ExpireDate:'..msg.to.id,true)
redis:setex('ExpireDate:'..msg.to.id, 86400, true)
send_msg(msg.to.id, '💢¦ _تم دعم المجموعه ليوم واحد _\n💢¦ _راسل المطور لتجديد الوقت_',msg.id,'md')
end
if chex and not exd and msg.from.id ~= sudo_id and not is_sudo(msg) then
local text1 = '💢¦ اشتراك المجموعه انتهى💢 \n💢¦ '..msg.to.title..'\n\nID:  <code>'..msg.to.id..'</code>'
local text2 = '💢¦ الاشتراك البوت انتهى \n💢¦ سوف اغادر \n💢¦ لتجديد الاشتراك راسل '..botname
send_msg(sudo_id, text1, nil, 'html')
send_msg(msg.to.id, text2, msg.id, 'html')
botrem(msg)
else
local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
local day = (expiretime / 86400)
if tonumber(day) > 0.208 and not is_sudo(msg) and is_mod(msg) then
warning(msg)
end
end
end
end


local function run(msg, matches)

local data = load_data(_config.moderation.data)

  if tonumber(msg.from.id) == tonumber(sudo_id) then
   if matches[1] == "رفع مطور" then
   if not matches[2] and msg.reply_to_message then
	if msg.reply.username then
	username = "@"..check_markdown(msg.reply.username)
    else
	username = escape_markdown(msg.reply.print_name)
end
      if msg.reply.id == our_id then return end
   if already_sudo(tonumber(msg.reply.id)) then
    return "💢¦ _العضو_ : "..username.." \n💢¦ _الايدي_ :  ["..msg.reply.id.."]\n💢¦ انه بالتاكيد مطور"
    else
          table.insert(_config.sudo_users, tonumber(msg.reply.id)) 
     save_config() 
     reload_plugins(true) 
    return "💢¦ _العضو_ : "..username.." \n💢¦ _الايدي_ :  ["..msg.reply.id.."]\n💢¦ تم ترقيتة ليصبح مطور"
      end
  elseif matches[2] and matches[2]:match('^%d+') then
            if matches[2] == our_id then return end
   if not getUser(matches[2]).result then
   return "💢¦ لا يوجد عضو بهذا المعرف"
    end
	  local user_name = '@'..check_markdown(getUser(matches[2]).information.username)
	  if not user_name then
		user_name = escape_markdown(getUser(matches[2]).information.first_name)
	  end
   if already_sudo(tonumber(matches[2])) then
    return "💢¦ _العضو_ :   "..user_name.."\n💢¦ الايدي : ["..matches[2].."]\n💢¦ انه بالتاكيد مطور"
    else
           table.insert(_config.sudo_users, tonumber(matches[2])) 
     save_config() 
     reload_plugins(true) 
    return "💢¦ _العضو_ :   "..user_name.."\n💢¦ الايدي : ["..matches[2].."] \n💢¦ تم ترقيتة ليصبح مطور"
   end
   elseif matches[2] and string.match(matches[2], '@[%a%d_]')  then
    local status = resolve_username(matches[2])
         if status.information.id == our_id then return end
   if not resolve_username(matches[2]).result then
   return "💢¦ لا يوجد عضو بهذا المعرف"
end
if already_sudo(tonumber(status.information.id)) then
    return "💢¦ _العضو_ :   @"..check_markdown(status.information.username).."\n💢¦ الايدي : ["..status.information.id.."] \n💢¦ انه بالتاكيد مطور"
    else
          table.insert(_config.sudo_users, tonumber(status.information.id)) 
     save_config() 
     reload_plugins(true) 
    return "💢¦ _العضو_ :   @"..check_markdown(status.information.username).."\n💢¦ الايدي : ["..status.information.id.."] \n💢¦ تم ترقيتة ليصبح مطور"
     end
  end
end
   if matches[1] == "تنزيل مطور" then
      if not matches[2] and msg.reply_to_message then
	if msg.reply.username then
	username = "@"..check_markdown(msg.reply.username)
    else
	username = escape_markdown(msg.reply.print_name)
end
if tonumber(msg.reply.id) == tonumber(our_id) then return end
   if not already_sudo(tonumber(msg.reply.id)) then
    return "💢¦ _العضو_ : "..username.." \n💢¦ _الايدي_ :  ["..msg.reply.id.."]\n💢¦ انه بالتاكيد تم تنزيله من المطورين"
    else
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(msg.reply.id)))
		save_config()
     reload_plugins(true) 
    return "💢¦ _العضو_ : "..username.." \n💢¦ _الايدي_ :  ["..msg.reply.id.."]\n💢¦ تم تنزيله من المطورين"
      end
	  elseif matches[2] and matches[2]:match('^%d+') then
 if tonumber(matches[2]) == tonumber(our_id) then return end
  if not getUser(matches[2]).result then
   return "💢¦ لا يوجد عضو بهذا المعرف"
    end
	  local user_name = '@'..check_markdown(getUser(matches[2]).information.username)
	  if not user_name then
		user_name = escape_markdown(getUser(matches[2]).information.first_name)
	  end
   if not already_sudo(tonumber(matches[2])) then
    return "💢¦ _العضو_ :   "..user_name.." \n💢¦ _الايدي_ :  ["..matches[2].."]\n💢¦ انه بالتاكيد تم تنزيله من المطورين"
    else
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(matches[2])))
		save_config()
     reload_plugins(true) 
    return "💢¦ _العضو_ :   "..user_name.." \n💢¦ _الايدي_ :  ["..matches[2].."] \n💢¦ تم تنزيله من المطورين"
      end
elseif matches[2] and string.match(matches[2], '@[%a%d_]')  then
      local status = resolve_username(matches[2])
   if tonumber(status.id) == tonumber(our_id) then return end

   if not resolve_username(matches[2]).result then
   return "💢¦ لا يوجد عضو بهذا المعرف"
    end
   if not already_sudo(tonumber(status.information.id)) then
    return "💢¦ _العضو_ :   @"..check_markdown(status.information.username).." \n💢¦ _الايدي_ :  ["..status.information.id.."] \n💢¦ انه بالتاكيد تم تنزيله من المطورين"
    else
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(status.information.id)))
		save_config()
     reload_plugins(true) 
    return "💢¦ _العضو_ :   @"..check_markdown(status.information.username).." \n💢¦ _الايدي_ :  ["..status.information.id.."] \n💢¦ تم تنزيله من المطورين"
          end
      end
   end
end

if is_sudo(msg) then



  
if matches[1] == 'المجموعات' then
return chat_list(msg)
    end
if matches[1] == 'تعطيل' and matches[2] and string.match(matches[2], '^%d+$') then
    local data = load_data(_config.moderation.data)
			-- Group configuration removal
			data[tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = nil
				save_data(_config.moderation.data, data)
			end
			data[tostring(groups)][tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
	   send_msg(matches[2], "💢¦ تم تعطيل البوت من قبل المطور", nil, 'md')
    send_msg(msg.to.id , '💢¦ المجموعة : *'..matches[2]..'* تم تعطيلها')
		end
  if matches[1] == 'اذاعه' and matches[2]  then	
if tonumber(msg.from.id) ~= tonumber(sudo_id) then return "☔️هذا الامر للمطور الاساسي فقط 🌑" end
  local data = load_data(_config.moderation.data)		
  local bc = matches[2]		
  local i = 1
  for k,v in pairs(data) do				
send_msg(k, bc)
i = i+1
end	
send_msg(msg.to.id, '💢¦ تم اذاعة الرساله الى ['..i..'] مجموعة ')

end
if matches[2] == 'الخروج التلقائي' and is_sudo(msg) then
--Enable Auto Leave
     if matches[1] == 'تعطيل' then
    redis:del('AutoLeaveBot')
     return '💢¦ تم تعطيل الخروج التلقائي'
--Disable Auto Leave
     elseif matches[1] == 'تفعيل' then
    redis:set('AutoLeaveBot', true)
 return '💢¦ تم تفعيل الخروج التلقائي'
--Auto Leave Status
end
end
if matches[1] =="الخروج التلقائي" then
if redis:get('AutoLeaveBot') then
return '💢¦ الخروج التلقائي: مفعل'
else
return '💢¦ الخروج التلقائي: معطل'
end
end


if msg.to.type == 'supergroup' or msg.to.type == 'group' then



 if not data[tostring(msg.to.id)] then return end


if matches[1] == 'شحن' and matches[2] and not matches[3] and is_sudo(msg) then
if tonumber(matches[2]) > 0 and tonumber(matches[2]) < 1001 then
local extime = (tonumber(matches[2]) * 86400)
redis:setex('ExpireDate:'..msg.to.id, extime, true)
if not redis:get('CheckExpire::'..msg.to.id) then
redis:set('CheckExpire::'..msg.to.id)
end
send_msg(msg.to.id, '💢¦تم شحن الاشتراك ل\n [<code>'..matches[2]..'</code>] يوم ⌚️',msg.id, 'html')
send_msg(sudo_id, ' 💢¦تم تمديد فترة الاشتراك لـ[<code>'..matches[2]..'</code>].\n💢¦ في المجموعة\n💢¦ [<code>'..msg.to.title..'</code>]',nil, 'html')
else
send_msg(msg.to.id,  '_ اختر من 1 الى 1000 فقط ⌚️    ._',msg.id, 'md')
end
end

if matches[1]:lower() == 'الاشتراك' and is_mod(msg) and not matches[2] then
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
	send_msg(msg.to.id, '_المجموعة مفعله مدى الحياة⌚️_', msg.id, 'md')
else
local day = math.floor(expi / 86400) + 1
if expi == -1 then
	expire_date = 'مفتوح🎖'
    elseif day == 1 then
	expire_date = 'يوم واحد' 
	elseif day == 2 then
   	expire_date = 'يومين'
	elseif day <= 10 then
   	expire_date = day..' ايام'
   	else
	expire_date = day..' يوم'
end
 send_msg(msg.to.id, '💢¦ باقي '..day..' وينتهي اشتراك البوت 💯', msg.id, 'md')
end
end

if matches[1]:lower() == 'الاشتراك' and matches[2] == '1' and not matches[3] then
			local timeplan1 = 2592000
			redis:setex('ExpireDate:'..msg.to.id, timeplan1, true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
send_msg(sudo_id, '💢¦ تم تفعيل المجموعة\n💢¦  [ <code>'..msg.to.title..'</code> ]\n💢¦الاشتراك : شهر واحد 🛠 )' , nil, 'html')
send_msg(msg.to.id, '💢¦ تم تفعیل المجموعه ستبقی صالحة الی 30 یوم⌚️', msg.id, 'md')
		end
if matches[1]:lower() == 'الاشتراك' and matches[2] == '2' and not matches[3] then
			local timeplan2 = 7776000
			redis:setex('ExpireDate:'..msg.to.id,timeplan2,true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
send_msg(sudo_id, '💢¦ تم تفعيل المجموعة \n💢¦ [ <code>'..msg.to.title..'</code> ]\n💢¦ الاشتراك : 3 اشهر 🛠 )', nil, 'html')
send_msg(msg.to.id, '💢¦ تم تفعيل البوت بنجاح وصلاحيته لمدة 90 يوم  )', msg.id, 'md')
		end
if matches[1]:lower() == 'الاشتراك' and matches[2] == '3' and not matches[3] then
			redis:set('ExpireDate:'..msg.to.id,true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
send_msg(sudo_id, '💢¦ تم تفعيل المجموعة \n💢¦ [ <code>'..msg.to.title..'</code> ]\n💢¦ الاشتراك : مدى الحياه', nil, 'html')
send_msg(msg.to.id, '💢¦ تم تفعيل البوت بنجاح وصلاحيته مدى الحياه ', msg.id, 'md')
end
end



end
---------------Help Tools----------------
  
if matches[1] == 'المطور' and data[tostring(msg.to.id)]  then
send_msg(msg.to.id, _config.info_text, msg.id)
end
if matches[1] == "المطورين" and data[tostring(msg.to.id)] and is_sudo(msg) then
return sudolist(msg)
end


if matches[1]:lower() == 'معلوماتي' or matches[1]:lower() == 'موقعي'  then
if msg.from.username then username = '@'..msg.from.username
else username = '<i>ما مسوي  😹💔</i>'
end
if is_sudo(msg) then rank = 'المطور مالتي 😻'
elseif is_owner(msg) then rank = 'مدير المجموعه 😽'
elseif is_mod(msg) then rank = 'ادمن في البوت 😺'
else rank = 'مجرد عضو 😹'
end
local info = '<b>💯️¦ اهـلا بـك معلوماتك :</b>\n\n<b>💢¦ الاسم :</b> <i>'..namecut(msg.from.first_name)
..'</i>\n<b>💢¦ المعرف:</b> '..username
..'\n<b>💢¦ الايدي :</b> [ <code>'..msg.from.id
..'</code> ]\n<b>💢¦ ايدي الكروب :</b> [ <code>'..msg.to.id
..'</code> ]\n<b>💢¦ موقعك :</b> <i>'..rank..'</i>'
send_msg(msg.to.id, info, msg.id, 'html')
end
 if matches[1] == "مواليدي" then
local kyear = tonumber(os.date("%Y"))
local kmonth = tonumber(os.date("%m"))
local kday = tonumber(os.date("%d"))
--
local agee = kyear - matches[2]
local ageee = kmonth - matches[3]
local ageeee = kday - matches[4]

return  " 👮🏼 مرحبا عزيزي"
.."\n👮🏼 لقد قمت بحسب عمرك 💯  \n\n"

.."💢¦ "..agee.." سنه\n"
.."💢¦ "..ageee.." اشهر \n"
.."💢¦ "..ageeee.." يوم \n\n"

end
-------



if matches[1] == "الاوامر" then
if not is_mod(msg) then return "💢¦ للاداريين فقط 🎖" end
return [[
♨️¦ الاوامـر الـ؏ـامـة

💢¦ـ➖➖➖➖➖
💢¦ م1 ➙ اوامر الادارة
💢¦ م2 ➙ اوامر اعدادات المجموعه
💢¦ م3 ➙ اوامر الحـمـايـة
💢¦ م4 ➙ الاوامـر الـ؏ـامـة
💢¦ م المطور ➙ اوامر المطور
💢¦ اوامر الرد ➙ لاضافه رد معين
💢¦ اوامر الزخرفه ➙ لزخرفه الكلمات
💢¦ اوامر الملفات ➙ لاضافه وتفعيل وحذف الملفات
ֆ • • • • • • • • • • • • • ֆ 

💬¦ راسلني للاستفسار 💡↭ ]]..check_markdown(sudouser) 
end

if matches[1]== 'م1' then
if not is_mod(msg) then return "💢¦ للاداريين فقط 🎖" end
return [[
🎖  اوامر الرفع والتنزيل📍
💢¦ـ➖➖➖➖➖
💢¦ رفع ادمن : لرفع ادمن في البوت
💢¦ تنزيل ادمن : لتنزيل ادمن من البوت
💢¦ رفع عضو مميز : لرفع عضو مميز في البوت
💢¦ تنزيل عضو مميز : لتنزيل عضو مميز من البوت
💢¦ الادمنيه : لعرض قائمة الادمنيه
💢¦ الاداريين : لعرض قائمة الاداريين
ֆ • • • • • • • • • • • • • ֆ 
💬 اوامر الطرد والحضر 🀄️
💢¦ طرد بالرد : لطرد العضو من المجموعه
💢¦ طرد + المعرف : لطرد العضو من المجموعه
💢¦ حظر بالرد : لحظر وطرد عضو من المجموعه 
💢¦ حظر + المعرف : لحظر وطرد عضو من المجموعه 
💢¦ الغاء الحظر : لالغاء الحظر عن عضو 
💢¦ منع : لمنع كلمه داخل المجموعه
💢¦ الغاء منع : لالغاء منع الكلمه  
💢¦ كتم  : لكتم عضو بواسطة الرد
💢¦ الغاء الكتم  : لالغاء الكتم بواسطة الرد
ֆ • • • • • • • • • • • • • ֆ 
💬¦ راسلني للاستفسار 💡↭ ]]..check_markdown(sudouser) 

end

if matches[1]== 'م2' then
if not is_mod(msg) then return "💢¦ للاداريين فقط 🎖" end
return [[
📌 اوامر الوضع للمجموعه 🀄️

💢¦ـ➖➖➖➖➖
💢¦ ضع الترحيب + الكلمه  :↜ لوضع ترحيب  
💢¦ ضع قوانين :↜ لوضع قوانين 
💢¦ ضع وصف :↜ لوضع وصف  
💢¦ ضـع رابط :↜ لوضع الرابط  
💢¦ الـرابـط  خاص :↜  لارسال الرابط  خاص
💢¦ الـرابـط :↜  لعرض الرابط  
ֆ • • • • • • • • • • • • • ֆ 

📌 اوامر رؤية الاعدادات 🀄️

💢¦ القوانين : لعرض  القوانين 
💢¦ الادمنيه : لعرض  الادمنيه 
💢¦ الاداريين : لعرض  الاداريين 
💢¦ المكتومين :↜لعرض  المكتومين 
💢¦ المطور : لعرض معلومات المطور 
💢¦ معلوماتي :↜لعرض معلوماتك  
💢¦ الحمايه : لعرض اعدادات المجموعه 
💢¦ الوسائط : لعرض اعدادات الميديا 
💢¦ المجموعه : لعرض معلومات المجموعه 

💬¦ راسلني للاستفسار 💡↭ ]]..check_markdown(sudouser) 

  end

if matches[1]== 'م3' then
if not is_mod(msg) then return "💢¦ للاداريين فقط 🎖" end
return [[
⚡️ اوامر حماية المجموعه ⚡️
💢¦ـ➖➖➖➖➖ـ
💢¦️ قفل ┇ فتح :  التثبيت
💢¦️ قفل ┇ فتح :  التعديل
💢¦️ قفل ┇ فتح :  البصمات
💢¦️ قفل ┇ فتح :  الــفيديو
💢¦️ قفل ┇ فتح : الـصـوت 
💢¦️ قفل ┇ فتح :  الـصــور 
💢¦️ قفل ┇ فتح :  الملصقات
💢¦️ قفل ┇ فتح :  المتحركه
💢¦️ قفل ┇ فتح : الدردشه
💢¦️ قفل ┇ فتح : الملصقات
💢¦️ قفل ┇ فتح : الروابط
💢¦️ قفل ┇ فتح : التاك
💢¦️ قفل ┇ فتح : البوتات
💢¦️ قفل ┇ فتح : البوتات بالطرد
💢¦️ قفل ┇ فتح : الكلايش
💢¦️ قفل ┇ فتح : التكرار
💢¦️ قفل ┇ فتح :  التوجيه
💢¦️ قفل ┇ فتح :  الانلاين
💢¦️ قفل ┇ فتح : الجهات 
💢¦️ قفل ┇ فتح : المجموعه 
💢¦️ قفل ┇ فتح : الــكـــل
💢¦ـ➖➖➖➖➖
📌¦ تشغيل ┇ ايقاف : الترحيب 
💬¦ تشغيل ┇ ايقاف : الردود 
📢¦ تشغيل ┇ ايقاف : التحذير
🗨¦ تشغيل ┇ ايقاف : الايدي
ֆ • • • • • • • • • • • • • ֆ 
💬¦ راسلني للاستفسار 💡↭ ]]..check_markdown(sudouser) 

end

if matches[1]== 'م4' then
if not is_mod(msg) then return "💢¦ للاداريين فقط 🎖" end
return [[
📍💭 اوامر اضافيه 🔹🚀🔹
💢¦ـ➖➖➖➖➖
🕵🏻 معلوماتك الشخصيه 🙊
💢¦ اسمي : لعرض اسمك 💯
💢¦ معرفي : لعرض معرفك 💯
💢¦ ايديي : لعرض ايديك 💯
💢¦ رقمي : لعرض رقمك  💯
💢¦ـ➖➖➖➖➖
💢¦ اوامر التحشيش 😄
📌¦ تحب + (اسم الشخص)
📌¦ بوس + (اسم الشخص) 
📌¦ كول + (اسم الشخص) 
📌¦ كله + الرد + (الكلام) 
ֆ • • • • • • • • • • • • • ֆ 

💬¦ راسلني للاستفسار 💡↭ ]]..check_markdown(sudouser) 

end

if matches[1]== "م المطور" then
if not is_sudo(msg) then return "💢¦ للمطوين فقط 🎖" end
return [[
📌¦ اوامر المطور 🃏

💢¦ تفعيل  : لتفعيل البوت 
💢¦ تعطيل : لتعطيل البوت 
💢¦️ تفعيل ┇ تعطيل : الخروج التلقائي 
💢¦ اذاعه : لنشر كلمه لكل المجموعات
💢¦` اسم بوتك + غادر :` لطرد البوت
💢¦ مسح الادمنيه : لمسح الادمنيه 
💢¦ مسح الاداريين : لمسح الاداريين 
💢¦ تحديث: لتحديث ملفات البوت
ֆ • • • • • • • • • • • • • ֆ 

💬¦ راسلني للاستفسار 💡↭ ]]..check_markdown(sudouser) 

end

if matches[1]== 'اوامر الرد' then
if not is_owner(msg) then return "💢¦ للمدراء فقط 🎖" end

return [[
💬¦ جميع اوامر الردود 
💢¦ـ➖➖➖➖➖
💢¦ الردود : لعرض الردود المثبته
💢¦ رد اضف  + الرد : لأضافت رد جديد
💢¦ رد مسح  + الرد المراد مسحه
💢¦ رد مسح الكل : لمسح الكل
💢¦ـ➖➖➖➖➖
💬¦ راسلني للاستفسار 💡↭ ]]..check_markdown(sudouser) 

end

if matches[1]== "اوامر الزخرفه" then
if not is_mod(msg) then return "💢¦ للاداريين فقط 🎖" end
return [[☔️¦ اوامر الزخرفةة 🌑

💢¦ زخرف + الكلمه المراد زخرفتها بالانكلش 🍃
💢¦ زخرفه + الكلمه المراد زخرفتها بالعربي 🍃

]]
end

if matches[1]== "اوامر الملفات" then
if tonumber(msg.from.id) ~= tonumber(sudo_id) then return "☔️هذه الاوامر للمطور الاساسي فقط 🌑" end
return [[☔️¦ اوامر الملفات 🌑

💢¦ /p | لعرض قائمه الملفات السورس 🍃
💢¦ /p + اسم الملف المراد تفعيله 🍃
💢¦ /p - اسم الملف المراد تعطيله 🍃
💢¦ sp + الاسم | لارسال الملف اليك 🍃
💢¦ dp + اسم الملف المراد حذفه 🍃
💢¦ sp all | لارسالك كل ملفات السورس 🍃

]]
end

if matches[1]=="start" then
local usersudo = string.gsub(sudouser, '@', '')
keyboard = {}
keyboard.inline_keyboard = {
{
{text= '♨️ الــمــطــور ❤️💯' ,url = 'https://t.me/'..usersudo} -- هنا خلي معرفك انته كمطور
}					
}
tkey = [[💢¦ مٌرَحُبّاً انَا بّوَتْ اسِمٌيَ ]]..botname..[[ 🎖
💢¦ اقًوَمٌ بّحُمٌايَةِ الُمٌجْمٌوَْعات حُتْى 20k كِيَ 
💢¦ الُمٌطِوَرَ فَقًطِ يَسِتْطِيَْع تْفَْعيَلُيَ فَيَ الُمٌجْمٌوَْعات ْ⇩⇩
💢¦ اوَ اتْرَكِ رَسِالُتْكِ ُهنَا وَسِوَفَ يَرَدِ ْعلُيَكِ الُمٌطِوَر ]]
send_key(msg.chat.id, tkey, keyboard, msg.id,"html")
end

if matches[1]=="رتبتي" and not matches[2] then
if is_sudo(msg) then
rank = 'المطور مالتي 😻'
elseif is_owner(msg) and msg.to.type ~= 'private'  then
rank = 'مدير المجموعه 😽'
elseif is_mod(msg) and msg.to.type ~= 'private'  then
rank = ' ادمن في البوت 😺'
elseif  is_whitelist(msg.from.id, msg.to.id) and msg.to.type ~= 'private' then
rank = 'عضو مميز 🎖'
else
if msg.to.type ~= 'private' then
rank = 'مجرد عضو 😹'
else
rank = 'لست مطور في السورس ✖️'
end
end
return '💢¦ رتبتك : '..rank
end

if matches[1]=="الرتبه" and not matches[2] and is_owner(msg) and not  msg.to.type ~= 'private' then
if msg.reply_id then
if msg.reply.id == our_id  then
rank = 'هذا البوت 🙄☝🏿'
elseif msg.reply.id == msg.from.id  then
rank = 'انته المطور 👨🏼‍🔧'
elseif is_sudo1(msg.reply.id) then
rank = 'المطور هذا 😻'
elseif is_owner1( msg.to.id,msg.reply.id) then
rank = 'مدير المجموعه 😽'
elseif is_mod1( msg.to.id,msg.reply.id) then
rank = ' ادمن في البوت 😺'
elseif is_whitelist(msg.reply.id, msg.to.id)  then
rank = 'عضو مميز 🎖'
else
rank = 'مجرد عضو 😹'
end
if msg.reply.username then usernamrxx = "@"..msg.reply.username else usernamrxx = " لا يوجد 📛" end
local rtba = '💢¦ اسمه : '..msg.reply.first_name..'\n💢¦معرفه : '..usernamrxx..' \n💢¦ رتبته : '..rank
send_msg(msg.to.id,rtba , msg.id)
else
return "📌 سوي رد للعضو حته اكلك شنو رتبته🕵🏻"
end
end

end
return {
  patterns = {
    "^(م المطور)$", 
    "^[/](start)$", 
    "^(اوامر الرد)$", 
    "^(الاوامر)$", 
    "^(م1)$", 
    "^(م2)$", 
    "^(م3)$", 
    "^(م4)$", 
    "^(اوامر الزخرفه)$", 
    "^(اوامر الملفات)$", 
    "^(معلوماتي)$",
    "^(موقعي)$",
    "^(رفع مطور)$",
    "^(تنزيل مطور)$",
    "^(رفع مطور) (%d+)$",
    "^(تنزيل مطور) (%d+)$",
    "^(رفع مطور) (@[%a%d%_]+)$",
    "^(تنزيل مطور) (@[%a%d%_]+)$",
    "^(المطورين)$",
    "^(المجموعات)$",
    "^(الاشتراك)$",
    "^(الاشتراك) ([123])$",
    "^(مواليدي) (.+)/(.+)/(.+)",
    "^(شحن) (%d+)$",
    "^(اذاعه) (.*)$",
    "^(الخروج التلقائي)$",
    "^(تفعيل) (.*)$",
    "^(تعطيل) (.*)$",
    "^(المطور)$",
    "^(رتبتي)$",
    "^(الرتبه)$",
    },
  run = run,
  pre_process = pre_process
}
--[[
by @RAMBO_SYR  \ @ramixnxx_bot
اي استفسار او لديك مشكله تابع قناتي @Xxx_DEVRAMI_xxX 
او مراسلتي ع الخاص
]]