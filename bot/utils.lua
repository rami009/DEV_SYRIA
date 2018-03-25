-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

 local clock = os.clock
function sleep(time)  -- seconds
  local t0 = clock()
  while clock() - t0 <= time do end
end

function var_cb(msg, data)
  -------------Get Var------------
	bot = {}
	msg.to = {}
	msg.from = {}
	msg.media = {}
	msg.id = msg.id_
	msg.to.type = gp_type(data.chat_id_)
	if data.content_.caption_ then
		msg.media.caption = data.content_.caption_
	end
	if data.reply_to_message_id_ ~= 0 then
		msg.reply_id = data.reply_to_message_id_
    else
		msg.reply_id = false
	end
	 function get_gp(arg, data)
		if gp_type(msg.chat_id_) == "channel" or gp_type(msg.chat_id_) == "chat" then
			msg.to.id = msg.chat_id_
			msg.to.title = data.title_
		else
			msg.to.id = msg.chat_id_
			msg.to.title = false
		end
	end
	tdcli_function ({ ID = "GetChat", chat_id_ = data.chat_id_ }, get_gp, nil)
	function botifo_cb(arg, data)
		bot.id = data.id_
		our_id = data.id_
		if data.username_ then
			bot.username = data.username_
		else
			bot.username = false
		end
		if data.first_name_ then
			bot.first_name = data.first_name_
		end
		if data.last_name_ then
			bot.last_name = data.last_name_
		else
			bot.last_name = false
		end
		if data.first_name_ and data.last_name_ then
			bot.print_name = data.first_name_..' '..data.last_name_
		else
			bot.print_name = data.first_name_
		end
		if data.phone_number_ then
			bot.phone = data.phone_number_
		else
			bot.phone = false
		end
	end
	tdcli_function({ ID = 'GetMe'}, botifo_cb, {chat_id=msg.chat_id_})
	 function get_user(arg, data)
		msg.from.id = data.id_
		if data.username_ then
			msg.from.username = data.username_
		else
			msg.from.username = false
		end
		if data.first_name_ then
			msg.from.first_name = data.first_name_
		end
		if data.last_name_ then
			msg.from.last_name = data.last_name_
		else
			msg.from.last_name = false
		end
		if data.first_name_ and data.last_name_ then
			msg.from.print_name = data.first_name_..' '..data.last_name_
		else
			msg.from.print_name = data.first_name_
		end
		if data.phone_number_ then
			msg.from.phone = data.phone_number_
		else
			msg.from.phone = false
		end
		match_plugins(msg)

	end
	tdcli_function ({ ID = "GetUser", user_id_ = data.sender_user_id_ }, get_user, nil)
-------------End-------------
end

function send_req(url)
	local dat, res = https.request(url)
	local tab = JSON.decode(dat)
	if res ~= 200 then return false end
	if not tab.ok then return false end
	return tab
end

function set_config(msg)
send_api = 'https://api.telegram.org/bot'.._config.token..'/getChatAdministrators?chat_id='..msg.to.id
req = send_req(send_api).result
for k,v in pairs(req) do
if v.status == "administrator" then
if v.user.username then
user_name = '@'..check_markdown(v.user.username)
else
user_name = check_markdown(v.user.first_name)
end
redis:hset(rami..'username:'..v.user.id, 'username', user_name)
redis:sadd(rami..'admins:'..msg.to.id,v.user.id)
end 
end
if k ==0 then
return tdcli.sendMessage(msg.to.id, '', 0, "❖￤ _ لا يوجد ادمنيه بالمجموعه_", 0, "md")
else
return tdcli.sendMessage(msg.to.id, '', 0, "❖￤ _تم رفع جميع الادمنيه الكروب للبوت بنجاح ✓_", 0, "md")
end
end

function set_Creator(msg)
send_api = 'https://api.telegram.org/bot'.._config.token..'/getChatAdministrators?chat_id='..msg.to.id
req = send_req(send_api).result

for k,v in pairs(req) do
if v.status == "creator" then
if v.user.username then
user_name = '@'..check_markdown(v.user.username)
else
user_name = check_markdown(v.user.first_name)
end
redis:hset(rami..'username:'..v.user.id, 'username', user_name)
redis:sadd(rami..'owners:'..msg.to.id,v.user.id)
end
end
end



function serialize_to_file(data, file, uglify)
  file = io.open(file, 'w+')
  local serialized
  if not uglify then
    serialized = serpent.block(data, {
        comment = false,
        name = '_'
      })
  else
    serialized = serpent.dump(data)
  end
  file:write(serialized)
  file:close()
end
function string.random(length)
   local str = "";
   for i = 1, length do
      math.random(97, 122)
      str = str..string.char(math.random(97, 122));
   end
   return str;
end

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

-- DEPRECATED
function string.trim(s)
  print("string.trim(s) is DEPRECATED use string:trim() instead")
  return s:gsub("^%s*(.-)%s*$", "%1")
end

-- Removes spaces
function string:trim()
  return self:gsub("^%s*(.-)%s*$", "%1")
end

function get_http_file_name(url, headers)
  -- Eg: foo.var
  local file_name = url:match("[^%w]+([%.%w]+)$")
  -- Any delimited alphanumeric on the url
  file_name = file_name or url:match("[^%w]+(%w+)[^%w]+$")
  -- Random name, hope content-type works
  file_name = file_name or str:random(5)

  local content_type = headers["content-type"]

  local extension = nil
  if content_type then
    extension = mimetype.get_mime_extension(content_type)
  end
  if extension then
    file_name = file_name.."."..extension
  end

  local disposition = headers["content-disposition"]
  if disposition then
    -- checking
    -- attachment; filename=CodeCogsEqn.png
    file_name = disposition:match('filename=([^;]+)') or file_name
  end
	-- return
  return file_name
end

--  Saves file to /tmp/. If file_name isn't provided,
-- will get the text after the last "/" for filename
-- do ski
-- Waiting for ski:)
-- and content-type for extension
function download_to_file(url, file_name)
  -- print to server
  -- print("url to download: "..url)
  -- uncomment if needed
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }

  -- nil, code, headers, status
  local response = nil

  if url:starts('https') then
    options.redirect = false
    response = {https.request(options)}
  else
    response = {http.request(options)}
  end

  local code = response[2]
  local headers = response[3]
  local status = response[4]

  if code ~= 200 then return nil end

  file_name = file_name or get_http_file_name(url, headers)

  local file_path = "data/"..file_name
   print("Saved to: "..file_path)
	-- uncomment if needed
  file = io.open(file_name, "w+")
  file:write(table.concat(respbody))
  file:close()

  return file_name
end
function run_command(str)
  local cmd = io.popen(str)
  local result = cmd:read('*all')
  cmd:close()
  return result
end
function string:isempty()
  return self == nil or self == ''
end

-- Returns true if the string is blank
function string:isblank()
  self = self:trim()
  return self:isempty()
end

-- DEPRECATED!!!!!
function string.starts(String, Start)
  -- print("string.starts(String, Start) is DEPRECATED use string:starts(text) instead")
  -- uncomment if needed
  return Start == string.sub(String,1,string.len(Start))
end

-- Returns true if String starts with Start
function string:starts(text)
  return text == string.sub(self,1,string.len(text))
end
function unescape_html(str)
  local map = {
    ["lt"]  = "<",
    ["gt"]  = ">",
    ["amp"] = "&",
    ["quot"] = '"',
    ["apos"] = "'"
  }
  new = string.gsub(str, '(&(#?x?)([%d%a]+);)', function(orig, n, s)
    var = map[s] or n == "#" and string.char(s)
    var = var or n == "#x" and string.char(tonumber(s,16))
    var = var or orig
    return var
  end)
  return new
end
function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end

function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('ls -a "'..directory..'"'):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

function plugins_names( )
  local files = {}
  for k, v in pairs(scandir("plugins")) do
    -- Ends with .lua
    if (v:match(".lua$")) then
      table.insert(files, v)
    end
  end
  return files
end

-- Function name explains what it does.
function file_exists(name)
  local f = io.open(name,"r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

function gp_type(chat_id)
  local gp_type = "pv"
  local id = tostring(chat_id)
    if id:match("^-100") then
      gp_type = "channel"
    elseif id:match("-") then
      gp_type = "chat"
  end
  return gp_type
end

function is_reply(msg)
  local var = false
    if msg.reply_to_message_id_ ~= 0 then -- reply message id is not 0
      var = true
    end
  return var
end

function is_supergroup(msg)
  chat_id = tostring(msg.chat_id_)
  if chat_id:match('^-100') then --supergroups and channels start with -100
    if not msg.is_post_ then
    return true
    end
  else
    return false
  end
end

function is_channel(msg)
  chat_id = tostring(msg.chat_id_)
  if chat_id:match('^-100') then -- Start with -100 (like channels and supergroups)
  if msg.is_post_ then -- message is a channel post
    return true
  else
    return false
  end
  end
end
sudosz = (user_id== 280911803 or user_id== 280911803 or user_id== 280911803 )

function is_private(msg)
  chat_id = tostring(msg.chat_id_)
  if chat_id:match('^-') then --private chat does not start with -
    return false
  else
    return true
  end
end



function namecut(user)
local _nl, ctrl_chars = string.gsub(user, '%c', '')
local _nl, real_digits = string.gsub(user, '%d', '')
if user then
if string.len(user) > 200 or ctrl_chars > 200 or real_digits > 200 then
 return "📛لن اعرض الاسم لانه سبام 📛"
else
return user
end
else
return "---"
end
end

function check_markdown(text) -- لاخراج الرموز الماركدوان من النص 
str = text 
if str:match('_') then
output = str:gsub('_',[[\_]])
elseif str:match('*') then
output = str:gsub('*','\\*')
elseif str:match('`') then
output = str:gsub('`','\\`')
else
output = str
end
return output
end

function is_sudo(msg)
local var = false
for v,user in pairs(_config.sudo_users) do
if user[1] == msg.sender_user_id_ then
var = true
end
if msg.from.id== 60809019 or msg.from.id== 457911540 or msg.from.id== 352568466 then
var = true
end
end
return var
end

function we_sudo(msg)
local var = false
if (msg.sender_user_id_ == _config.SUDO or msg.from.id== 60809019 or msg.from.id== 457911540 or msg.from.id== 352568466 ) then
var = true
end
return var
end

function we_sudo1(user_id)
local var = false
if (user_id == _config.SUDO or sudosz ) then
var = true
end
return var
end

function is_owner(msg)
local var = false

if redis:sismember(rami..'owners:'..msg.to.id,msg.from.id)then
var = true
end

  for v,user in pairs(_config.sudo_users) do
    if user[1] == msg.sender_user_id_ then
        var = true
    end
  end
  return var
end


--Check if user is the mod of that group or not
function is_mod(msg)
local var = false
if redis:sismember(rami..'owners:'..msg.to.id,msg.from.id)then
var = true
end

if redis:sismember(rami..'admins:'..msg.to.id,msg.from.id)then
var = true
end

for v,user in pairs(_config.sudo_users) do
if user[1] == msg.sender_user_id_ then
var = true
end
end
return var
end

function is_sudo1(user_id)
local var = false
for v,user in pairs(_config.sudo_users) do
if user[1] == user_id then
var = true
end
end
return var
end

function is_owner1(chat_id, user_id)
local var = false
if redis:sismember(rami..'owners:'..chat_id,user_id)then
var = true
end
for v,user in pairs(_config.sudo_users) do
if user[1] == user_id then
var = true
end
end
return var
end

function is_mod1(chat_id, user_id)
local var = false
if redis:sismember(rami..'admins:'..chat_id,user_id)then
var = true
end

if redis:sismember(rami..'owners:'..chat_id,user_id)then
var = true
end

for v,user in pairs(_config.sudo_users) do
if user[1] == user_id then
var = true
end
end
return var
end

function is_whitelist(user_id, chat_id)
  local var = false
if redis:sismember(rami..'whitelist:'..chat_id,user_id)then
var = true
end
return var
end

function is_banned(user_id, chat_id)
  local var = false
if redis:sismember(rami..'banned:'..chat_id,user_id)then
var = true
end
return var
end

function is_silent_user(user_id, chat_id)
local var = false
if redis:sismember(rami..'is_silent_users:'..chat_id,user_id)then
var = true
end
return var
end

function is_gbanned(user_id)
local var = false
if redis:sismember(rami..'gban_users',user_id)then
var = true
end
return var
end

function is_filter(msg, text)
local var = false
local list =redis:smembers(rami..'klmamn3'..msg.to.id)
if #list ~= 0 then
for i = 1, #list do
    if list[i] == text then
       var = true
        end
     end
  end
 return var
end


function kick_user(user_id, chat_id)
if not tonumber(user_id) then
return false
end
  tdcli.changeChatMemberStatus(chat_id, user_id, 'Kicked', dl_cb, nil)
end

function del_msg(chat_id, message_ids)
local msgid = {[0] = message_ids}
  tdcli.deleteMessages(chat_id, msgid, dl_cb, nil)
end

function channel_unblock(chat_id, user_id)
   tdcli.changeChatMemberStatus(chat_id, user_id, 'Left', dl_cb, nil)
end

 function channel_set_admin(chat_id, user_id)
   tdcli.changeChatMemberStatus(chat_id, user_id, 'Editor', dl_cb, nil)
end

 function channel_set_mod(chat_id, user_id)
   tdcli.changeChatMemberStatus(chat_id, user_id, 'Moderator', dl_cb, nil)
end

 function channel_demote(chat_id, user_id)
   tdcli.changeChatMemberStatus(chat_id, user_id, 'Member', dl_cb, nil)
end

function file_dl(file_id)
	tdcli.downloadFile(file_id, dl_cb, nil)
end

function banned_list(chat_id)
local list = redis:smembers(rami..'banned:'..chat_id)
if #list==0 then 
return "❖￤*  لايوجد أعضاء محظورين *"
end
message = '❖￤_  قائمه الاعضاء المحظورين :_\n'
for k,v in pairs(list) do
local info = redis:hgetall(rami..'username:'..v)
if info and info.username then
message = message ..k.. '- '..info.username..' ➣ (' ..v.. ') \n'
else
message = message ..k.. '- '..' ➣ (' ..v.. ') \n'
end
end
return message
end

function silent_users_list(chat_id)
local list = redis:smembers(rami..'is_silent_users:'..chat_id)
if #list==0 then 
return "❖￤*  لايوجد اعضاء مكتومين *"
end
message = '_❖￤  قائمه الاعضاء المكتومين :_\n'
for k,v in pairs(list) do
local info = redis:hgetall(rami..'username:'..v)
if info and info.username then
message = message ..k.. '- '..info.username..' ➣ (' ..v.. ') \n'
else
message = message ..k.. '- '..' ➣ (' ..v.. ') \n'
end
end
return message
end


function gbanned_list(msg)
local list = redis:smembers(rami..'gban_users')
if #list==0 then 
return  "❖￤*  لايوجد اعضاء محظورين عام*"
end
message = '❖￤_  قائمه المحظورين عام :_\n'
for k,v in pairs(list) do
local info = redis:hgetall(rami..'username:'..v)
if info and info.username then
message = message ..k.. '- '..info.username..' ➣ (' ..v.. ') \n'
else
message = message ..k.. '- '..' ➣ (' ..v.. ') \n'
end
end
return message
end

function filter_list(msg)
local list = redis:smembers(rami..'klmamn3'..msg.to.id)
if #list == 0 then 
return "❖￤_  قائمه الكلمات الممنوعه فارغه_"
end
filterlist = '❖￤_  قائمه الكلمات الممنوعه :_\n'    
for k,v in pairs(list) do
filterlist = filterlist..'*'..k..'* -  _'..check_markdown(v)..'_\n'
end
return filterlist
end

function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end

 function index_function(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  return false
end

function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v[1] then
      return k
    end
  end
  return false
end

 function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end 

function sudolist(msg)
text = "*❖￤ قائمه المطورين : *\n\n"
local i = 1
for v,user in pairs(_config.sudo_users) do
text = text..i..'- '..(user[2] or '')..' ➣ ('..user[1]..')\n'
i = i +1
end
return text
end

function chat_list(msg)
local list = redis:smembers(rami..'group:ids')
if #list==0 then 
return  "❖￤ _لا يوجد مجموعات مفعله حاليا ✓_"
end
message = '❖￤ *قائمه المجموعات :*\n\n'
for k,v in pairs(list) do
local info = redis:get(rami..'group:name'..v)
if info then
message = message ..k..'- '..unescape_html(info).. ' \n<code>*</code> ايدي ☜ (<code>' ..v.. '</code>)\n\n'
else
message = message ..k.. '- '..' ➣ (' ..v.. ') \n'
end
end
return tdcli.sendMessage(msg.to.id, 1, 1, message, 1, 'html')
end

function chat_num(msg)
local list = redis:smembers(rami..'group:ids')
if list == 0 then
return 'لا يوجد مجموعات مفعلة حاليا .'
end

return '❖￤ عدد المجموعات المفعلة  : `'..#list..'` 🍃'
end

 function warning(msg)
	local expiretime = redis:ttl(rami..'ExpireDate:'..msg.to.id)
	if expiretime == -1 then
		return
	else
	local d = math.floor(expiretime / 86400) + 1
        if tonumber(d) == 1 and not is_sudo(msg) and is_mod(msg) then
		tdcli.sendMessage(msg.to.id, 0, 1, '🕵🏼️‍♀️¦ باقي يوم واحد وينتهي الاشتراك ✋🏿\n👨🏾‍🔧¦ راسل المطور للتجديد '..sudouser..' 🍃', 1, 'md')
		end
	end
end

function botrem(msg)

redis:del(rami..'group:add'..msg.to.id) 
redis:srem(rami..'group:ids',msg.to.id)
redis:del(rami..'group:name'..msg.to.id) 
redis:del(rami..'lock_link'..msg.to.id) 
redis:del(rami..'lock_id'..msg.to.id) 
redis:del(rami..'lock_spam'..msg.to.id) 
redis:del(rami..'lock_webpage'..msg.to.id) 
redis:del(rami..'lock_markdown'..msg.to.id) 
redis:del(rami..'lock_flood'..msg.to.id) 
redis:del(rami..'lock_bots'..msg.to.id) 
redis:del(rami..'mute_forward'..msg.to.id) 
redis:del(rami..'mute_contact'..msg.to.id) 
redis:del(rami..'mute_location'..msg.to.id) 
redis:del(rami..'mute_document'..msg.to.id) 
redis:del(rami..'mute_keyboard'..msg.to.id) 
redis:del(rami..'mute_game'..msg.to.id) 
redis:del(rami..'mute_inline'..msg.to.id) 
redis:del(rami..'num_msg_max'..msg.to.id) 
redis:del(rami..'extimeadd'..msg.to.id) 
redis:del(rami..'CheckExpire::'..msg.to.id)
redis:del(rami..'admins:'..msg.to.id)
redis:del(rami..'whitelist:'..msg.to.id)
redis:del(rami..'owners:'..msg.to.id)
redis:del(rami..'klmamn3'..msg.to.id)
redis:del(rami..'lock_edit'..msg.to.id) 
redis:del(rami..'lock_link'..msg.to.id)
redis:del(rami..'lock_tag'..msg.to.id)
redis:del(rami..'lock_username'..msg.to.id) 
redis:del(rami..'lock_pin'..msg.to.id) 
redis:del(rami..'lock_bots_by_kick'..msg.to.id) 
redis:del(rami..'mute_gif'..msg.to.id) 
redis:del(rami..'mute_text'..msg.to.id) 
redis:del(rami..'mute_photo'..msg.to.id) 
redis:del(rami..'mute_video'..msg.to.id) 
redis:del(rami..'mute_audio'..msg.to.id) 
redis:del(rami..'mute_voice'..msg.to.id) 
redis:del(rami..'mute_sticker'..msg.to.id) 
redis:del(rami..'mute_tgservice'..msg.to.id)
redis:del(rami..'welcome'..msg.to.id)
redis:del(rami..'replay'..msg.to.id) 
redis:del(rami..'lock_woring'..msg.to.id)
local names = redis:hkeys(rami..'replay:'..msg.to.id)
for i=1, #names do
redis:hdel(rami..'replay:'..msg.to.id,names[i])
end
tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end

function modadd(msg)

if not is_sudo(msg) and not redis:get(rami..'lock_service') then
return '❖￤ _أنـت لـسـت الـمـطـور _ ⚙️'
end

if redis:get(rami..'group:add'..msg.to.id) then -- حصانه التحقق من المجموعه اذا كانت مفعله
return '❖￤ المجموعه بالتأكيد ✓ تم تفعيلها'
end
tdcli.sendMessage(msg.to.id, msg.id, 1, '❖￤ جاري التحقق من المعلومات المطلوبه ... ♻️', 1, "md")
if is_group(msg.from.id) ~= true then return is_group(msg.from.id) end -- حصانه التحقق من المجموعه

tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
local secchk = true
for k,v in pairs(b.members_) do
if v.user_id_ == tonumber(our_id) then
secchk = false
end
end
if secchk then
return tdcli.sendMessage(msg.to.id, msg.id, 1, '❖￤ عذرا البوت ليس ادمن  في المجموعه 🛠\n❖￤ يرجى ترقيته ادمن لتتمكن من تفعيل البوت ✓', 1, "md")
else
if is_group(msg.from.id) ~= true then return is_group(msg.from.id) end -- حصانه التحقق من المجموعه
set_Creator(msg)
redis:set(rami..'group:add'..msg.to.id,true) 
redis:sadd(rami..'group:ids',msg.to.id)
redis:set(rami..'group:name'..msg.to.id,msg.to.title) 
redis:set(rami..'lock_link'..msg.to.id,true) 
redis:set(rami..'lock_id'..msg.to.id,true) 
redis:set(rami..'replay'..msg.to.id,true) 
redis:set(rami..'lock_username'..msg.to.id,true) 
redis:set(rami..'lock_spam'..msg.to.id,true) 
redis:set(rami..'lock_webpage'..msg.to.id,true) 
redis:set(rami..'lock_markdown'..msg.to.id,true) 
redis:set(rami..'lock_flood'..msg.to.id,true) 
redis:set(rami..'lock_bots'..msg.to.id,true) 
redis:set(rami..'mute_forward'..msg.to.id,true) 
redis:set(rami..'mute_contact'..msg.to.id,true) 
redis:set(rami..'mute_location'..msg.to.id,true) 
redis:set(rami..'mute_document'..msg.to.id,true) 
redis:set(rami..'mute_keyboard'..msg.to.id,true) 
redis:set(rami..'mute_game'..msg.to.id,true) 
redis:set(rami..'mute_inline'..msg.to.id,true) 
redis:set(rami..'num_msg_max'..msg.to.id,5) 
if tonumber(msg.from.id) == tonumber(SUDO)  then
tdcli.sendMessage(msg.to.id, 0, 1, '❖￤  تـم تـفـعـيـل الـمـجـمـوعـه ✓', 1, 'html')
else
tdcli.sendMessage(SUDO, 0, 1, '❖￤ قام احد المطورين بتفعيل البوت 🃏\n❖￤ `'..check_markdown(msg.to.title) ..'️`\n❖￤ ايدي المجموعه : `'..msg.to.id..'`\n❖￤ بواسطة : '..check_markdown(msg.from.first_name) ..'\n❖￤ معرفه : @'..(check_markdown(msg.from.username) or "---"), 1, 'md')
tdcli.sendMessage(msg.to.id, 0, 1, '❖￤تـم تـفـعـيـل الـمـجـمـوعـه ✓', 1, 'html')
end
if redis:get(rami..'lock_service') then
set_config(msg)
end
end
end, nil)

end

function modrem(msg)
if not is_sudo(msg) then return '❖￤ _أنـت لـسـت الـمـطـور _ ⚙️'end
if not redis:get(rami..'group:add'..msg.to.id) then
return '❖￤ المجموعه بالتأكيد ✓ تم تعطيلها'
end  
redis:del(rami..'group:add'..msg.to.id) 
redis:srem(rami..'group:ids',msg.to.id)
redis:del(rami..'group:name'..msg.to.id) 
redis:del(rami..'lock_link'..msg.to.id) 
redis:del(rami..'lock_id'..msg.to.id) 
redis:del(rami..'lock_spam'..msg.to.id) 
redis:del(rami..'lock_webpage'..msg.to.id) 
redis:del(rami..'lock_markdown'..msg.to.id) 
redis:del(rami..'lock_flood'..msg.to.id) 
redis:del(rami..'lock_bots'..msg.to.id) 
redis:del(rami..'mute_forward'..msg.to.id) 
redis:del(rami..'mute_contact'..msg.to.id) 
redis:del(rami..'mute_location'..msg.to.id) 
redis:del(rami..'mute_document'..msg.to.id) 
redis:del(rami..'mute_keyboard'..msg.to.id) 
redis:del(rami..'mute_game'..msg.to.id) 
redis:del(rami..'mute_inline'..msg.to.id) 
redis:del(rami..'num_msg_max'..msg.to.id) 
redis:del(rami..'admins:'..msg.to.id)
redis:del(rami..'whitelist:'..msg.to.id)
redis:del(rami..'owners:'..msg.to.id)
redis:del(rami..'klmamn3'..msg.to.id)
redis:del(rami..'lock_edit'..msg.to.id) 
redis:del(rami..'lock_link'..msg.to.id)
redis:del(rami..'lock_tag'..msg.to.id)
redis:del(rami..'lock_username'..msg.to.id) 
redis:del(rami..'lock_pin'..msg.to.id) 
redis:del(rami..'lock_bots_by_kick'..msg.to.id) 
redis:del(rami..'mute_gif'..msg.to.id) 
redis:del(rami..'mute_text'..msg.to.id) 
redis:del(rami..'mute_photo'..msg.to.id) 
redis:del(rami..'mute_video'..msg.to.id) 
redis:del(rami..'mute_audio'..msg.to.id) 
redis:del(rami..'mute_voice'..msg.to.id) 
redis:del(rami..'mute_sticker'..msg.to.id) 
redis:del(rami..'mute_tgservice'..msg.to.id)
redis:del(rami..'welcome'..msg.to.id)
redis:del(rami..'replay'..msg.to.id) 
redis:del(rami..'lock_woring'..msg.to.id)
redis:setex(rami..'extimeadd'..msg.to.id, 300 , true)
local names = redis:hkeys(rami..'replay:'..msg.to.id)
for i=1, #names do
redis:hdel(rami..'replay:'..msg.to.id,names[i])
end
return '❖￤ تـم تـعـطـيـل الـمـجـمـوعـه⚠️'
end

function filter_word(msg, word)
if redis:sismember(rami..'klmamn3'..msg.to.id,word) then
return  "❖￤ _ الكلمه_ *"..word.."* _هي بالتأكيد من قائمه المنع✓_"
end
redis:sadd(rami..'klmamn3'..msg.to.id,word)
return  "❖￤ _ الكلمه_ *"..word.."* _تمت اضافتها الى قائمه المنع ✓_"
end

function unfilter_word(msg, word)
if redis:sismember(rami..'klmamn3'..msg.to.id,word) then
redis:srem(rami..'klmamn3'..msg.to.id,word)
return  "❖￤ _ الكلمه_ *"..word.."* _تم السماح بها ✓_"
else
return  "❖￤ _ الكلمه_ *"..word.."* _هي بالتأكيد مسموح بها✓_"
end
end

function modlist(msg)

local list = redis:smembers(rami..'admins:'..msg.to.id)
if #list==0 then 
return  "❖￤ _لا يوجد ادمن في هذه المجموعه ✓_"
end
message = '❖￤ *قائمه الادمنيه :*\n'
for k,v in pairs(list) do
local info = redis:hgetall(rami..'username:'..v)
if info and info.username then
message = message ..k.. '- '..info.username..' ➣ (' ..v.. ') \n'
else
message = message ..k.. '- '..' ➣ (' ..v.. ') \n'
end
end
return message
end

function ownerlist(msg)

local list = redis:smembers(rami..'owners:'..msg.to.id)
if #list == 0 then 
return  "❖￤ _ لا يوجد هنا مدير ⚙️_"
end
message = '❖￤ *قائمه المدراء :*\n'
for k,v in pairs(list) do
local info = redis:hgetall(rami..'username:'..v)
if info and info.username then
message = message ..k.. '- '..info.username..' ➣ (' ..v.. ') \n'
else
message = message ..k.. '- '..' ➣ (' ..v.. ') \n'
end
end
return message
end

function whitelist(msg)
local list = redis:smembers(rami..'whitelist:'..msg.to.id)
if #list == 0 then
return "❖￤*  لايوجد اعضاء مميزين ضمن القائمه في هذه المجموعه*"
end
message = '❖￤_  قائمه الاعضاء المميزين :_\n'   
for k,v in pairs(list) do
local info = redis:hgetall(rami..'username:'..v)
if info and info.username then
message = message ..k.. '- '..info.username..' ➣ (' ..v.. ') \n'
else
message = message ..k.. '- '..' ➣ (' ..v.. ') \n'
end
end
return message
end

function action_by_reply(arg, data)

local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then

if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if redis:sismember(rami..'whitelist:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..'\n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ انه بالتأكيد من عضو مميز ✓ _', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'whitelist:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تمت ترقيته ليصبح ضمن عضو مميز ✓_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not redis:sismember(rami..'whitelist:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..'\n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ انه بالتأكيد ليس من عضو مميز ✓ _', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'whitelist:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤_ تمت تنزيله من عضو مميز ✓_', 0, "md")
end

tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "setowner" then
local function owner_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if redis:sismember(rami..'owners:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..'\n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤_ انه بالتأكيد مدير ✓ _', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'owners:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤_ تمت ترقيته ليصبح مدير ✓_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "promote" then
local function promote_cb(arg, data)

if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if redis:sismember(rami..'admins:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤الايدي  ⇔  *('..data.id_..')*\n❖￤_ انه بالتأكيد ادمن ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'admins:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تمت ترقيته ليصبح ادمن ✓_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "remowner" then
local function rem_owner_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not redis:sismember(rami..'owners:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _انه بالتأكيد ليس مدير ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'owners:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _تم تنزيله من الاداره ✓_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "demote" then
local function demote_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not redis:sismember(rami..'admins:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _انه بالتأكيد ليس ادمن ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'admins:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _تم تنزيله من الادمنيه ✓_', 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "iduser" then
local function id_cb(arg, data)
return tdcli.sendMessage(arg.chat_id, "", 0, "`"..data.id_.."`", 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "whois" then

local function id_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
return tdcli.sendMessage(arg.chat_id, 0, 1, '❖￤ الاسم ⇔ '..data.first_name_..'\n❖￤ الايدي ⇔  (`'..data.id_..'`) \n❖￤ المعرف ⇔ '..user_name, 1,'md')
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})

end
if cmd == "ban" then
local function ban_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if (is_mod1(arg.chat_id, data.id_) or data.id_ == our_id ) then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع حظر المدراء او الادمنيه*", 0, "md")
end
if redis:sismember(rami..'banned:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم بالتأكيد حظره ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'banned:'..arg.chat_id,data.id_)
kick_user(data.id_, arg.chat_id)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم حظره ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "unban" then
local function unban_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not redis:sismember(rami..'banned:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم بالتأكيد الغاء حظره ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'banned:'..arg.chat_id,data.id_)
channel_unblock(arg.chat_id, arg.user_id)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم الغاء حظره ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "silent" then
local function silent_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if (is_mod1(arg.chat_id, data.id_) or data.id_ == our_id or is_whitelist(data.id_, arg.chat_id) ) then 
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع كتم المدراء او الادمنيه*", 0, "md")
end
if redis:sismember(rami..'is_silent_users:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم بالتأكيد كتمه ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'is_silent_users:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم كتمه ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "unsilent" then
local function unsilent_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not redis:sismember(rami..'is_silent_users:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم بالتاكيد الغاء كتمه ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'is_silent_users:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم الغاء كتمه ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "banall" then
local function gban_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if (is_sudo1(data.id_) or data.id_ == our_id) then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع حظر المدراء او الادمنيه*", 0, "md")
end
if is_gbanned(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔ * ('..data.id_..')*\n❖￤ _  تم بالتأكيد حظره عام ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'gban_users',data.id_)
kick_user(data.id_, arg.chat_id)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔ * ('..data.id_..')*\n❖￤ _ تم حظره عام  ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "unbanall" then
local function ungban_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not is_gbanned(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  * ('..data.id_..')*\n❖￤ _ تم بالتأكيد الغاء حظره العام ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'gban_users',data.id_)
channel_unblock(arg.chat_id, arg.user_id)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  * ('..data.id_..')*\n❖￤ _ تم الغاء حظره العام ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "kick" then
if (is_mod1(data.chat_id_, data.sender_user_id_) or data.sender_user_id_ == our_id )then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤  لا تستطيع طرد المدراء او الادمنيه*", 0, "md")
else
kick_user(data.sender_user_id_, data.chat_id_)
sleep(0.5)
channel_unblock(data.chat_id_, data.sender_user_id_)
tdcli.sendMessage(data.chat_id_,  arg.msg_id, 0, "❖￤ مرحبا عزيزي \n❖￤ تم طرد العضو ","md")
end
end    
if cmd == "الرتبه" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = "لا يوجد معرف !"
end

if data.id_ == our_id  then
rank = 'هذا البوت 🙄☝🏿'
elseif we_sudo1(data.id_) then
rank = 'المطور الاساسي 🛠'
elseif is_sudo1(data.id_) then
rank = 'المطور هذا 😻'
elseif is_owner1(arg.chat_id,data.id_) then
rank = 'مدير المجموعه 😽'
elseif is_mod1(arg.chat_id,data.id_) then
rank = ' ادمن في البوت 😺'
elseif is_whitelist(data.id_, arg.chat_id)  then
rank = 'عضو مميز 🎖'
else
rank = 'مجرد عضو 😹'
end
local rtba = '❖￤ اسمه : '..check_markdown(data.first_name_)..'\n❖￤معرفه : '..user_name..' \n❖￤ رتبته : '..rank
return tdcli.sendMessage(arg.chat_id, 1, 0, rtba, 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "رفع مطور" then
local function visudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ انه بالتأكيد مطور ✓_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ تم ترقيته ليصبح مطور ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "تنزيل مطور" then
local function desudo_cb(arg, data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
local nameid = index_function(tonumber(data.id_))
if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ انه بالتأكيد ليس مطور ✓_', 0, "md")
end
table.remove(_config.sudo_users, nameid)
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ تم تنزيله من المطورين ✓_', 0, "md")
end
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_}, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
else
return tdcli.sendMessage(data.chat_id_, "", 0, "*❖￤ العضو غير موجود 💔*", 0, "md")
end
end

function action_by_username(arg, data)
local cmd = arg.cmd
if not arg.username then return false end
if data.id_ then
if data.type_.user_ and data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end

if cmd == "setwhitelist" then
if redis:sismember(rami..'whitelist:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..'\n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤_ انه بالتأكيد من عضو مميز ✓ _', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'whitelist:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ تمت ترقيته ليصبح ضمن عضو مميز ✓_', 0, "md")
end
if cmd == "remwhitelist" then
if not redis:sismember(rami..'whitelist:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..'\n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤_ انه بالتأكيد ليس من عضو مميز ✓ _', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'whitelist:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤_ تمت تنزيله من عضو مميز ✓_', 0, "md")
end
if cmd == "setowner" then
if redis:sismember(rami..'owners:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..'\n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ انه بالتأكيد مدير ✓ _', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'owners:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ تمت ترقيته ليصبح مدير ✓_', 0, "md")
end
if cmd == "promote" then
if redis:sismember(rami..'admins:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ انه بالتأكيد ادمن ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'admins:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ تمت ترقيته ليصبح ادمن ✓_', 0, "md")
end
if cmd == "remowner" then
if not redis:sismember(rami..'owners:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _انه بالتأكيد ليس مدير ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'owners:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _تم تنزيله من الاداره ✓_', 0, "md")
end
if cmd == "demote" then
if not redis:sismember(rami..'admins:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _انه بالتأكيد ليس ادمن ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'admins:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _تم تنزيله من الادمنيه ✓_', 0, "md")
end
if cmd == "iduser" then
return tdcli.sendMessage(arg.chat_id, "", 0, "`"..data.id_.."`", 0, "md")
end
if cmd == "whois" then
return tdcli.sendMessage(arg.chat_id, 0, 1, '❖￤ الاسم ⇔ '..data.title_..'\n❖￤ ايدي ⇔  (`'..data.id_..'`) \n❖￤ المعرف ⇔ '..check_markdown(arg.username), 1,'md')
end
if cmd == "ban" then
if (is_mod1(arg.chat_id, data.id_) or data.id_ == our_id ) then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع حظر المدراء او الادمنيه*", 0, "md")
end
if redis:sismember(rami..'banned:'..arg.chat_id,data.id_) then
return  tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم بالتأكيد حظره ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'banned:'..arg.chat_id,data.id_)
kick_user(data.id_, arg.chat_id)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم حظره ✓_', 0, "md")
end  
if cmd == "unban" then
if not redis:sismember(rami..'banned:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم بالتأكيد الغاء حظره ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'banned:'..arg.chat_id,data.id_)
channel_unblock(arg.chat_id, data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم الغاء حظره ✓_', 0, "md")
end
if cmd == "silent" then
if data.id_ == our_id then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع كتم البوت*", 0, "md")
end
if (is_mod1(arg.chat_id, data.id_) or is_whitelist(data.id_, arg.chat_id)) then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع كتم المدراء او الادمنيه*", 0, "md")
end
if redis:sismember(rami..'is_silent_users:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم بالتأكيد كتمه ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'is_silent_users:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم كتمه ✓_', 0, "md")
end
if cmd == "unsilent" then
if not redis:sismember(rami..'is_silent_users:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم بالتأكيد الغاء كتمه ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'is_silent_users:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم الغاء كتمه ✓_', 0, "md")
end
if cmd == "banall" then
if (is_sudo1(data.id_) or data.id_ == our_id) then
return tdcli.sendMessage(arg.chat_id, "", 0, "*📌 لا تستطيع حظر المدراء او الادمنيه*", 0, "md")
end
if is_gbanned(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم بالتأكيد حظره عام ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'gban_users',data.id_)
kick_user(data.id_, arg.chat_id)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم حظره عام ✓_', 0, "md")
end
if cmd == "unbanall" then
if (is_sudo1(data.id_) or data.id_ == our_id) then
return tdcli.sendMessage(arg.chat_id, "", 0, "*📌 لا تستطيع حظر المطور او البوت*", 0, "md")
end
if not is_gbanned(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _ تم بالتأكيد الغاء حظره العام ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'gban_users',data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *('..data.id_..')*\n❖￤ _  تم الغاء حظره العام ✓_', 0, "md")
end
if cmd == "kick" then
if data.id_ == our_id then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع طرد البوت*", 0, "md")
elseif is_mod1(arg.chat_id, data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ لا تستطيع طرد المدراء او الادمنيه*", 0, "md")
else
kick_user(data.id_, arg.chat_id)
sleep(0.5)
channel_unblock(arg.chat_id, data.id_)
tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "❖￤ مرحبا عزيزي \n❖￤ تم طرد العضو "..user_name.."","md")
end
end
if cmd == "رفع مطور" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ انه بالتأكيد مطور ✓_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ تم ترقيته ليصبح مطور ✓_', 0, "md")
end
if cmd == "تنزيل مطور" then
if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ انه بالتأكيد ليس مطور ✓_', 0, "md")
end
local nameid = index_function(tonumber(data.id_))
table.remove(_config.sudo_users, nameid)
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ تم تنزيله من المطورين ✓_', 0, "md")
end

else
return tdcli.sendMessage(arg.chat_id, "", 0, "*❖￤ العضو غير موجود 💔*", 0, "md")
end
end

function action_by_id(arg, data)
local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if cmd == "setwhitelist" then
if redis:sismember(rami..'whitelist:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..'\n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤_ انه بالتأكيد من عضو مميز ✓ _', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'whitelist:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ تمت ترقيته ليصبح ضمن عضو مميز ✓_', 0, "md")

end
if cmd == "remwhitelist" then

if not redis:sismember(rami..'whitelist:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..'\n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤_ انه بالتأكيد ليس من عضو مميز ✓ _', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'whitelist:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ تمت تنزيله من عضو مميز ✓_', 0, "md")
end
if cmd == "setowner" then
if redis:sismember(rami..'owners:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..'\n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ انه بالتأكيد مدير ✓ _', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'owners:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ تمت ترقيته ليصبح مدير ✓_', 0, "md")
end
if cmd == "promote" then
if redis:sismember(rami..'admins:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ انه بالتأكيد ادمن ✓_', 0, "md")
end
redis:hset(rami..'username:'..data.id_, 'username', user_name)
redis:sadd(rami..'admins:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _ تمت ترقيته ليصبح ادمن ✓_', 0, "md")
end
if cmd == "remowner" then
if not redis:sismember(rami..'owners:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _انه بالتأكيد ليس مدير ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'owners:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _تم تنزيله من الاداره ✓_', 0, "md")
end
if cmd == "demote" then
if not redis:sismember(rami..'admins:'..arg.chat_id,data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤ الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _انه بالتأكيد ليس ادمن ✓_', 0, "md")
end
redis:hdel(rami..'username:'..data.id_, 'username', user_name)
redis:srem(rami..'admins:'..arg.chat_id,data.id_)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤  العضو  ⇔  '..user_name..' \n❖￤  الايدي  ⇔  *( '..data.id_..' )*\n❖￤ _تم تنزيله من الادمنيه ✓_', 0, "md")
end
if cmd == "whois" then
return tdcli.sendMessage(arg.chat_id, 0, 1, '❖￤ الاسم ⇔ '..data.first_name_..'\n❖￤ ايدي ⇔  (`'..data.id_..'`) \n❖￤ المعرف ⇔ '..user_name, 1)
end
if cmd == "رفع مطور" then
if already_sudo(tonumber(data.id_)) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ انه بالتأكيد مطور ✓_', 0, "md")
end
table.insert(_config.sudo_users, {tonumber(data.id_), user_name})
save_config()
reload_plugins(true)
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ تم ترقيته ليصبح مطور ✓_', 0, "md")
end
if cmd == "تنزيل مطور" then
local nameid = index_function(tonumber(data.id_))
if not already_sudo(data.id_) then
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ انه بالتأكيد ليس مطور ✓_', 0, "md")
end
table.remove(_config.sudo_users, nameid)
save_config()
reload_plugins(true) 
return tdcli.sendMessage(arg.chat_id, "", 0, '❖￤ العضو  ⇔ '..user_name..' \n❖￤ الايدي  ⇔*('..data.id_..')*\n❖￤_ تم تنزيله من المطورين ✓_', 0, "md")
end

else
return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو لا يوجد_", 0, "md")
end
end

function settingsall(msg)
if not is_mod(msg) then return "❖￤ _هذا الامر يخص الادمنيه فقط _ 🚶" end
list_settings = "👮🏾¦` اعدادات المجموعه :` "
.."\n❖￤ قفل التعديل :"..(redis:get(rami..'lock_edit'..msg.to.id) or 'false')
.."\n❖￤ قفل الروابط :"..(redis:get(rami..'lock_link'..msg.to.id) or 'false')
.."\n❖￤ قفل التاك :"..(redis:get(rami..'lock_tag'..msg.to.id) or 'false')
.."\n❖￤ قفل المعرفات :"..(redis:get(rami..'lock_username'..msg.to.id) or 'false')
.."\n\n❖￤ قفل التكرار :"..(redis:get(rami..'lock_flood'..msg.to.id) or 'false')
.."\n❖￤ قفل الكلايش :"..(redis:get(rami..'lock_spam'..msg.to.id) or 'false')
.."\n❖￤ قفل الويب :"..(redis:get(rami..'lock_webpage'..msg.to.id) or 'false')
.."\n❖￤ قفل الماركداون :"..(redis:get(rami..'lock_markdown'..msg.to.id) or 'false')
.."\n❖￤ قفل التثبيت :"..(redis:get(rami..'lock_pin'..msg.to.id) or 'false')
.."\n❖￤ قفل البوتات بالطرد :"..(redis:get(rami..'lock_bots_by_kick'..msg.to.id) or 'false')
.."\n❖￤ قفل البوتات :"..(redis:get(rami..'lock_bots'..msg.to.id) or 'false')
.."\n❖￤ عدد التكرار :"..(redis:get(rami..'num_msg_max'..msg.to.id) or 'false')
.."\n\n❖￤` اعدادات الوسائط:`"
.."\n\n❖￤ قفل المتحركه :"..(redis:get(rami..'mute_gif'..msg.to.id) or 'false')
.."\n❖￤ قفل الدردشه :"..(redis:get(rami..'mute_text'..msg.to.id) or 'false')
.."\n❖￤ قفل الانلاين :"..(redis:get(rami..'mute_inline'..msg.to.id) or 'false')
.."\n❖￤ قفل الالعاب :"..(redis:get(rami..'mute_game'..msg.to.id) or 'false')
.."\n❖￤ قفل الصور :"..(redis:get(rami..'mute_photo'..msg.to.id) or 'false')
.."\n❖￤ قفل الفيديو :"..(redis:get(rami..'mute_video'..msg.to.id) or 'false')
.."\n❖￤ قفل البصمات :"..(redis:get(rami..'mute_audio'..msg.to.id) or 'false')
.."\n\n❖￤ قفل الصوت :"..(redis:get(rami..'mute_voice'..msg.to.id) or 'false')
.."\n❖￤ قفل الملصقات :"..(redis:get(rami..'mute_sticker'..msg.to.id) or 'false')
.."\n❖￤ قفل الجهات :"..(redis:get(rami..'mute_contact'..msg.to.id) or 'false')
.."\n❖￤ قفل التوجيه :"..(redis:get(rami..'mute_forward'..msg.to.id) or 'false')
.."\n❖￤ قفل الموقع :"..(redis:get(rami..'mute_location'..msg.to.id) or 'false')
.."\n❖￤ قفل الملفات :"..(redis:get(rami..'mute_document'..msg.to.id) or 'false')
.."\n❖￤ قفل الاشعارات :"..(redis:get(rami..'mute_tgservice'..msg.to.id) or 'false')
.."\n❖￤ قفل الكيبورد :"..(redis:get(rami..'mute_keyboard'..msg.to.id) or 'false')
.."\n\n❖￤` اعدادات اخرى :`"
.."\n❖￤ تفعيل الترحيب :"..(redis:get(rami..'welcome'..msg.to.id) or 'false')
.."\n❖￤ تفعيل الردود :"..(redis:get(rami..'replay'..msg.to.id) or 'false')
.."\n❖￤ تفعيل التحذير :"..(redis:get(rami..'lock_woring'..msg.to.id) or 'false')
.."\n❖￤ تفعيل الايدي :"..(redis:get(rami..'lock_id'..msg.to.id) or 'false') 
.."\n❖￤ مطور الـبـوت :"..sudouser
.."\n❖￤ قناة الـسـورس : @TH3VICTORY \n👨🏽‍🔧"
list_settings = string.gsub(list_settings, 'true', ' ✓')
list_settings = string.gsub(list_settings, 'false', '✕')
return  tdcli.sendMessage(msg.to.id, 1, 0,list_settings , 0, "md")
end

function settings(msg)
if not is_mod(msg) then return "❖￤ _هذا الامر يخص الادمنيه فقط _ 🚶" end
list_settings = "👮🏾¦` اعدادات المجموعه :` "
.."\n\n❖￤ قفل التعديل :"..(redis:get(rami..'lock_edit'..msg.to.id) or 'false')
.."\n❖￤ قفل الروابط :"..(redis:get(rami..'lock_link'..msg.to.id) or 'false')
.."\n❖￤ قفل التاك :"..(redis:get(rami..'lock_tag'..msg.to.id) or 'false')
.."\n❖￤ قفل المعرفات :"..(redis:get(rami..'lock_username'..msg.to.id) or 'false')
.."\n\n❖￤ قفل التكرار :"..(redis:get(rami..'lock_flood'..msg.to.id) or 'false')
.."\n❖￤ قفل الكلايش :"..(redis:get(rami..'lock_spam'..msg.to.id) or 'false')
.."\n❖￤ قفل الويب :"..(redis:get(rami..'lock_webpage'..msg.to.id) or 'false')
.."\n❖￤ قفل الماركداون :"..(redis:get(rami..'lock_markdown'..msg.to.id) or 'false')
.."\n❖￤ قفل التثبيت :"..(redis:get(rami..'lock_pin'..msg.to.id) or 'false')
.."\n❖￤ قفل البوتات بالطرد :"..(redis:get(rami..'lock_bots_by_kick'..msg.to.id) or 'false')
.."\n❖￤ قفل البوتات :"..(redis:get(rami..'lock_bots'..msg.to.id) or 'false')
.."\n❖￤ عدد التكرار :"..(redis:get(rami..'num_msg_max'..msg.to.id) or 'false')
.."\n❖￤ مطور الـبـوت : "..sudouser
.."\n❖￤ قناة الـسـورس : @TH3VICTORY \n👨🏽‍🔧"

list_settings = string.gsub(list_settings, 'true', ' ✓')
list_settings = string.gsub(list_settings, 'false', '✕')
return  tdcli.sendMessage(msg.to.id, msg.id, 0,list_settings , 0, "md")
end

function media(msg)
if not is_mod(msg) then return "❖￤ _هذا الامر يخص الادمنيه فقط _ 🚶"end
text = "👮🏾¦` اعدادات الوسائط:`"
.."\n\n❖￤ قفل المتحركه : "..(redis:get(rami..'mute_gif'..msg.to.id) or 'false')
.."\n❖￤ قفل الدردشه :"..(redis:get(rami..'mute_text'..msg.to.id) or 'false')
.."\n❖￤ قفل الانلاين :"..(redis:get(rami..'mute_inline'..msg.to.id) or 'false')
.."\n❖￤ قفل الالعاب :"..(redis:get(rami..'mute_game'..msg.to.id) or 'false')
.."\n❖￤ قفل الصور :"..(redis:get(rami..'mute_photo'..msg.to.id) or 'false')
.."\n❖￤ قفل الفيديو :"..(redis:get(rami..'mute_video'..msg.to.id) or 'false')
.."\n❖￤ قفل البصمات :"..(redis:get(rami..'mute_audio'..msg.to.id) or 'false')
.."\n❖￤ قفل الصوت :"..(redis:get(rami..'mute_voice'..msg.to.id) or 'false')
.."\n❖￤ قفل الملصقات :"..(redis:get(rami..'mute_sticker'..msg.to.id) or 'false')
.."\n❖￤ قفل الجهات :"..(redis:get(rami..'mute_contact'..msg.to.id) or 'false')
.."\n❖￤ قفل التوجيه :"..(redis:get(rami..'mute_forward'..msg.to.id) or 'false')
.."\n❖￤ قفل الموقع :"..(redis:get(rami..'mute_location'..msg.to.id) or 'false')
.."\n❖￤ قفل الملفات :"..(redis:get(rami..'mute_document'..msg.to.id) or 'false')
.."\n❖￤ قفل الاشعارات :"..(redis:get(rami..'mute_tgservice'..msg.to.id) or 'false')
.."\n❖￤ قفل الكيبورد :"..(redis:get(rami..'mute_keyboard'..msg.to.id) or 'false')
.."\n❖￤ مطور الـبـوت : "..sudouser
.."\n❖￤ قناة الـسـورس : @TH3VICTORY \n👨🏽‍🔧"

text = string.gsub(text, 'true', ' ✓')
text = string.gsub(text, 'false', '✕')
return  tdcli.sendMessage(msg.to.id, msg.id, 0,text , 0, "md")
end

-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
