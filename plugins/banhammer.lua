-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

local function syria(msg, matches)
if msg.to.type ~= 'pv' and redis:get(rami..'group:add'..msg.to.id)  then
if matches[1] == "طرد" and is_mod(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,msg_id=msg.id,cmd="kick"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
if matches[2] == our_id then
tdcli.sendMessage(msg.chat_id_, "", 0, "*❖￤ لا تستطيع طرد البوت*", 0, "md")
elseif is_mod1(msg.to.id, matches[2]) then
tdcli.sendMessage(msg.chat_id_, "", 0, "*❖￤ لا تستطيع طرد المدراء اوالادمنيه*", 0, "md")
else
kick_user(matches[2], msg.to.id)
sleep(1)
channel_unblock(msg.to.id, matches[2])
tdcli.sendMessage(msg.chat_id_, msg.id, 0, "❖￤ مرحبا عزيزي \n❖￤ تم طرد العضو [`"..matches[2].."`]","md")
end end
if matches[2] and string.match(matches[2], '@[%a%d_]') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,msg_id=msg.id,username=matches[2],cmd="kick"})
end end
if matches[1] == "مسح" and is_mod(msg) and not matches[2] and msg.reply_id then
del_msg(msg.to.id, msg.reply_id)
del_msg(msg.to.id, msg.id)
end
if matches[1] == "حظر" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="ban"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
if matches[2] == our_id then
return tdcli.sendMessage( msg.to.id, "", 0, "*❖￤ لا تستطيع حظر البوت*", 0, "md")
end
if is_mod1(msg.to.id, matches[2]) then
return tdcli.sendMessage( msg.to.id, "", 0, "*❖￤ لا تستطيع حظر المدراء او الادمنيه*", 0, "md")
end
if is_banned(matches[2], msg.to.id) then
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم بالتأكيد حظره ✔️_', 0, "md")
end
--redis:hset(rami..'username:'..matches[2], 'username', user_name)
redis:sadd(rami..'banned:'..msg.to.id,matches[2])
kick_user(matches[2], msg.to.id)
return tdcli.sendMessage( msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم حظره ✔️_', 0, "md")
end
if matches[2] and string.match(matches[2], '@[%a%d_]') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ban"})
end end
if matches[1] == "الغاء الحظر" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="unban"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
if not is_banned(matches[2], msg.to.id) then
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم بالتأكيد الغاء حظره ✔️_', 0, "md")
end
--redis:hset(rami..'username:'..matches[2], 'username', user_name)
redis:srem(rami..'banned:'..msg.to.id,matches[2])
channel_unblock(msg.to.id, matches[2])
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم الغاء حظره ✔️_', 0, "md")
end
if matches[2] and string.match(matches[2], '@[%a%d_]') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unban"})
end
end
if matches[1] == "كتم" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="silent"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
if matches[2] == our_id then
return tdcli.sendMessage(msg.to.id, "", 0, "*❖￤ لا تستطيع كتم البوت*", 0, "md")
end
if is_mod1(msg.to.id, matches[2]) then
return tdcli.sendMessage(msg.to.id, "", 0, "*❖￤ لا تستطيع كتم المدراء او الادمنيه*", 0, "md")
end
if is_silent_user(matches[2], msg.to.id) then
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم بالتأكيد كتمه ✔️_', 0, "md")
end
--redis:hset(rami..'username:'..matches[2], 'username', user_name)
redis:sadd(rami..'is_silent_users:'..msg.to.id,matches[2])
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم كتمه ✔️_', 0, "md")
end
if matches[2] and string.match(matches[2], '@[%a%d_]') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="silent"})
end
end
if matches[1] == "الغاء الكتم" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="unsilent"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
if not is_silent_user(matches[2], msg.to.id) then
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم بالتأكيد الغاء كتمه ✔️_', 0, "md")
end
--redis:hset(rami..'username:'..matches[2], 'username', user_name)
redis:srem(rami..'is_silent_users:'..msg.to.id,matches[2])
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔  *('..matches[2]..')*\n❖￤ _ تم الغاء كتمه ✔️_', 0, "md")
end
if matches[2] and string.match(matches[2], '@[%a%d_]') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unsilent"})
end
end
if matches[1] == "مسح" and is_owner(msg)  then
if matches[2] and string.match(matches[2], '^%d+$') then
local num = matches[2]
if 100 < tonumber(num) then
return "❖￤_حدود المسح ,  يجب ان تكون ما بين _ *[2-100]*"
end
print("❖￤ تم مسح ["..num.."] رسالة  ")
for i=1,tonumber(num) do
del_msg(msg.to.id,msg.id - i)
end
return"❖￤ تم مسح `"..num.."` رسالة  "
end
if matches[2] == 'المحظورين'  then
if #redis:smembers(rami..'banned:'..msg.to.id) ==0 then
return "*❖￤ لا يوجد مستخدمين محظورين  *"
end
redis:del(rami..'banned:'..msg.to.id)
----------------------------------------
tdcli.getChannelMembers(msg.to.id, 0, "Kicked", 30, function (i, naji)
for k,v in pairs(naji.members_) do
channel_unblock(i.chat_id, v.user_id_)
end end, {chat_id=msg.to.id})
return "*❖￤ تم مسح المحظورين في المجموعه*"
end
if matches[2] == 'المكتومين'  then
if #redis:smembers(rami..'is_silent_users:'..msg.to.id) ==0 then
return "*❖￤ لا يوجد مستخدمين مكتومين في المجموعه *"
end
redis:del(rami..'is_silent_users:'..msg.to.id)
return "*❖￤ تم مسح قائمه الكتم*"
end
if matches[2] == 'المميزين'  then
if #redis:smembers(rami..'whitelist:'..msg.to.id) ==0 then
return "*❖￤ لا يوجد مستخدمين مميزين في المجموعه *"
end
redis:del(rami..'whitelist:'..msg.to.id)
return "*❖￤ تم مسح قائمه المميزين*"
end end
if matches[1] == "المكتومين" and is_mod(msg)  then
return silent_users_list(msg.to.id)
end
if matches[1] == "المحظورين" and is_mod(msg)  then
return banned_list(msg.to.id)
end end
if matches[1] == "مسح" and we_sudo(msg)  then
if matches[2] == 'المطورين'  then
local i =0
 for v,user in pairs(_config.sudo_users) do
if user[1] ~= SUDO  then
table.remove(_config.sudo_users,nil) 
i=i+1
end end
if i == 0 then
return "*❖￤ لا يوجد مطورين مضافين  ☔️*"
else
return "❖￤ تم مسح `"..i.."` من المطورين ☔️"
end end			
if matches[2] == 'قائمه العام'  then
if #redis:smembers(rami..'gban_users') ==0 then
return "*❖￤ لا يوجد مستخدمين محظورين عام في المجموعه *"
end
redis:del(rami..'gban_users')
return "*❖￤ تم مسح قائمه العام*"
end end
if matches[1] == "قائمه العام" and is_sudo(msg)  then
return gbanned_list(msg)
end
if matches[1] == "حظر عام" and we_sudo(msg)  then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="banall"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
if matches[2] == our_id then
return tdcli.sendMessage(msg.to.id, "", 0, "*❖￤ لا تستطيع حظر عام للبوت*", 0, "md")
end
if is_sudo1(matches[2]) then
return tdcli.sendMessage(msg.to.id, "", 0, "*❖￤ لا تستطيع حظر عام للادمنيه او المدراء*", 0, "md")
end
if is_gbanned(matches[2]) then
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔ *('..matches[2]..')*\n❖￤ _ تم بالتأكيد حظره عام ✔️_', 0, "md")
end
--redis:hset(rami..'username:'..matches[2], 'username', user_name)
redis:sadd(rami..'gban_users',matches[2])
kick_user(matches[2], msg.to.id)
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔ *('..matches[2]..')*\n❖￤ _ تم حظره عام ✔️_', 0, "md")
end
if matches[2] and string.match(matches[2], '@[%a%d_]') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="banall"})
end end
if matches[1] == "الغاء العام" and we_sudo(msg)  then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,cmd="unbanall"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
if not is_gbanned(matches[2]) then
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔ *('..matches[2]..')*\n❖￤ _ تم بالتأكيد الغاء حظره العام ✔️_', 0, "md")
end
--redis:hset(rami..'username:'..matches[2], 'username', user_name)
redis:srem(rami..'gban_users',matches[2])
channel_unblock(msg.to.id, matches[2])
return tdcli.sendMessage(msg.to.id, "", 0, '❖￤ الايدي  ⇔ *('..matches[2]..')*\n❖￤ _ تم الغاء حظره العام ✔️_', 0, "md")
end
if matches[2] and string.match(matches[2], '@[%a%d_]') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unbanall"})
end end end
return {
	patterns = {
"^(حظر عام) (@[%a%d%_]+)$",
"^(حظر عام) (%d+)$",
"^(حظر عام)$",
"^(الغاء العام) (@[%a%d%_]+)$",
"^(الغاء العام) (%d+)$",
"^(الغاء العام)$",
"^(حظر) (@[%a%d%_]+)$",
"^(حظر) (%d+)$",
"^(حظر)$",
"^(الغاء الحظر) (@[%a%d%_]+)$",
"^(الغاء الحظر) (%d+)$",
"^(الغاء الحظر)$",
"^(طرد) (@[%a%d%_]+)$",
"^(طرد) (%d+)$",
"^(طرد)$",
"^(كتم) (@[%a%d%_]+)$",
"^(كتم) (%d+)$",
"^(كتم)$",
"^(الغاء الكتم) (@[%a%d%_]+)$",
"^(الغاء الكتم) (%d+)$",
"^(الغاء الكتم)$",
"^(المحظورين)$",
"^(قائمه العام)$",
"^(المكتومين)$",
"^(مسح)$",
"^(مسح) (.*)$",
},
run = syria,
}
-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
