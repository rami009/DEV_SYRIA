--[[
 ____                 ____             _
|  _ \  _____   __   / ___| _   _ _ __(_) __ _
| | | |/ _ \ \ / /___\___ \| | | | '__| |/ _` |
| |_| |  __/\ V /_____|__) | |_| | |  | | (_| |
|____/ \___| \_/     |____/ \__, |_|  |_|\__,_|
                            |___/

]]--
tdcli = dofile('./libs/tdcli.lua')
serpent = require('serpent')
serp = require 'serpent'.block
feedparser = (loadfile "./libs/feedparser.lua")()
require('./bot/utils')
require('./bot/locks')
require('./libs/lua-redis')
URL = require "socket.url"
http = require("socket.http")
https = require("ssl.https")
ltn12 = require "ltn12"
json = (loadfile "./libs/JSON.lua")()
mimetype = (loadfile "./libs/mimetype.lua")()
redis = (loadfile "./libs/redis.lua")()
JSON = (loadfile "./libs/dkjson.lua")()
local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")
chats = {}
plugins = {}


function do_notify (user, msg)
	local n = notify.Notification.new(user, msg)
	n:show ()
end

function dl_cb (arg, data)
	-- vardump(data)
end

function vardump(value)
	print(serpent.block(value, {comment=false}))
end

function load_data(filename)
	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON.decode(s)
	return data
end

function save_data(filename, data)
	local s = JSON.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()
end
print('\27[0;33m>>'..[[






 ____                 ____             _
|  _ \  _____   __   / ___| _   _ _ __(_) __ _
| | | |/ _ \ \ / /___\___ \| | | | '__| |/ _` |
| |_| |  __/\ V /_____|__) | |_| | |  | | (_| |
|____/ \___| \_/     |____/ \__, |_|  |_|\__,_|
                            |___/      

]]..'\27[0;31m'..[[@RAMBO_SYR]]..'\27[m'..[[ 
                                              
]]..'\27[0;31m'..[[@RAMBO_SYR1]]..'\27[m'..[[   
                                            
]]..'\27[0;31m'..[[@TH3VICTORY]]..'\27[m'..[[  
                                             
]]..'\27[0;31m'..[[@ramixnxx_bot]]..'\27[m'..[[                                               


]])
function whoami()
	local usr = io.popen("whoami"):read('*a')
	usr = string.gsub(usr, '^%s+', '')
	usr = string.gsub(usr, '%s+$', '')
	usr = string.gsub(usr, '[\n\r]+', ' ') 
	if usr:match("^root$") then
		tcpath = '/root/.telegram-cli'
	elseif not usr:match("^root$") then
		tcpath = '/home/'..usr..'/.telegram-cli'
	end
  print('\27[0;32m>> Download Path = \27[0;32m\27[31m'..tcpath..'\27[39m')
end

function match_plugins(msg)
	for name, plugin in pairs(plugins) do
		match_plugin(plugin, name, msg)
	end
end



function create_config( )
io.write('\n\27[1;33m📛↓ارسل لي ايديك \n📛↓(send id sudo) : \27[0;39;49m')
local SUDO = tonumber(io.read())
if not tostring(SUDO):match('%d+') then
SUDO = 280911803
end
io.write('\n\27[1;33m 📛↓ارسل التوكن \n📛↓ send Token : \27[0;39;49m')
local tokenz = io.read()
if tokenz ~= '' then
token = tokenz:gsub(' ','')
end
io.write('\n\27[1;33m📛↓ ارسل اسم البوت \n📛↓ send name bot: \27[0;39;49m')
local botnamex = io.read()
if botnamex =="" then
botname = "الدولة"
else
botname = botnamex:gsub(' ','')
end
io.write('\n\27[1;33m📛↓ ارسل معرفك \n📛↓send sudo user: \27[0;39;49m')
local sudouser = io.read()
if sudouser =="" then
sudouser = "@RAMBO_SYR"
end
redis:set(string.sub(token,0,9)..'bot:name',botname)
	config = {
    enabled_plugins = {
	"banhammer",
    "groupmanager",
    "msg-checks",
    "plugins",
    "tools",
	"replay",
	"zhrf",
	"dell",

	},
    token = token,
    sudo_users = {{SUDO,check_markdown(sudouser)}},
	SUDO = SUDO,
	sudouser = check_markdown(sudouser),
	info_text = [[
	
	هنا رابط سورسك
	,
  }

file = io.open("TH3SYRIA.sh", "w")
file:write([[
token="]]..token..[["
if [ ! -f ./libs/tg ]; then
    echo "tg not found"
    echo "Run install.sh"
    exit 1
fi
if [ $token == "" ]; then
    echo "token not found"
    echo "Run install.sh again"
    exit 1
fi
 
COUNTER=1
while(true) do

curl "https://api.telegram.org/bot"$token"/sendmessage" -F
./libs/tg -s ./bot/TH3SYRIA.lua $@ --bot=$token

let COUNTER=COUNTER+1 
done


]])
file:close()

serialize_to_file(config, './data/config.lua')
print ('saved config into config.lua')
if token=="" then
print("📛↓ ارسل التوكن صديقي\n")
print ('\n\n\n 📛↓you did not Enter token\n ')
sleep(3)
os.execute(' rm -fr data/config.lua && lua bot/TH3SYRIA.lua ')
return
end
end

function load_config( )
	local f = io.open('./data/config.lua', "r")
		-- If config.lua doesn't exist
	if not f then
		--print ("Created new config file: ./data/config.lua")
		create_config()
	else
		f:close()
	end
	print("")
	local config = loadfile ("./data/config.lua")()
	for v,user in pairs(config.sudo_users) do
		print("\27[0;32mSUDO USER: \27[1;34m" ..user[2]:gsub('\\','')..'\27[0;33m ('..user[1]..')\27[m')
	end
  os.execute(' rm -fr ../.telegram-cli')

	return config
end
whoami()
_config = load_config()

function save_config( )
	serialize_to_file(_config, './data/config.lua')
	print ('saved config into ./data/config.lua')
end
rami = string.sub(_config.token,0,9)
sudouser =_config.sudouser 
SUDO = _config.SUDO 

if redis:get(rami..'bot:name') then
bot_name = redis:get(rami..'bot:name') 
else
bot_name = 'الدولة'
end

function load_plugins()
	local config = loadfile ("./data/config.lua")()
	print("")
	for k, v in pairs(config.enabled_plugins) do
		print("\27[0;36mLoaded Plugin  ", v..'\27[m')
		local ok, err =  pcall(function()
		local t = loadfile("plugins/"..v..'.lua')()
		plugins[v] = t 
		end)
		if not ok then
			print('\27[31mError loading plugins '..v..'\27[39m')
			print(tostring(io.popen("lua plugins/"..v..".lua"):read('*all')))
			print('\27[31m'..err..'\27[39m')
		end
	end
	print('\n\27[0;32m'..#config.enabled_plugins..' Plugins Are Active\n\n\27[0;31mStarting TH3SYRIA V1 Robot...\n\27[m')
end

load_plugins()

function msg_valid(msg)
	 if tonumber(msg.date_) < (tonumber(os.time()) - 60) then
        print('\27[36m>>-- OLD MESSAGE --<<\27[39m')
		 return false
	 end

 if is_gbanned(msg.sender_user_id_) then
 del_msg(msg.chat_id_, tonumber(msg.id_))
     kick_user(msg.sender_user_id_, msg.chat_id_)
    return false
   end
   
    return true
end

function match_pattern(pattern, text, lower_case)
	if text then
		local matches = {}
		if lower_case then
			matches = { string.match(text:lower(), pattern) }
		else
			matches = { string.match(text, pattern) }
		end
		if next(matches) then
			return matches
		end
	end
end

function match_plugin(plugin, plugin_name, msg)
	if plugin.pre_process then
        --If plugin is for privileged users only
		local result = plugin.pre_process(msg)
		if result then
			print("pre process: ", plugin_name)
		end
	end
	for k, pattern in pairs(plugin.patterns) do
		matches = match_pattern(pattern, msg.content_.text_ or msg.content_.caption_)
		if matches then

			print("Message matches: ", pattern..' | Plugin: '..plugin_name)
			if plugin.run then
				local result = plugin.run(msg, matches)
					if result then
						tdcli.sendMessage(msg.chat_id_, msg.id_, 0, result, 0, "md")
                 end
			end
			return
		end
	end
end

function file_cb(msg)
	if msg.content_.ID == "MessagePhoto" then
		photo_id = ''
		local function get_cb(arg, data)
		if data.content_.photo_.sizes_[2] then
			photo_id = data.content_.photo_.sizes_[2].photo_.id_
			else
			photo_id = data.content_.photo_.sizes_[1].photo_.id_
			end
			tdcli.downloadFile(photo_id, dl_cb, nil)
		end
		tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.id_ }, get_cb, nil)
	elseif msg.content_.ID == "MessageVideo" then
		video_id = ''
		local function get_cb(arg, data)
			video_id = data.content_.video_.video_.id_
			tdcli.downloadFile(video_id, dl_cb, nil)
		end
		tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.id_ }, get_cb, nil)
	elseif msg.content_.ID == "MessageAnimation" then
		anim_id, anim_name = '', ''
		local function get_cb(arg, data)
			anim_id = data.content_.animation_.animation_.id_
			anim_name = data.content_.animation_.file_name_
			 tdcli.downloadFile(anim_id, dl_cb, nil)
		end
		tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.id_ }, get_cb, nil)
	elseif msg.content_.ID == "MessageVoice" then
		voice_id = ''
		local function get_cb(arg, data)
			voice_id = data.content_.voice_.voice_.id_
			tdcli.downloadFile(voice_id, dl_cb, nil)
		end
		tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.id_ }, get_cb, nil)
	elseif msg.content_.ID == "MessageAudio" then
		audio_id, audio_name, audio_title = '', '', ''
		local function get_cb(arg, data)
			audio_id = data.content_.audio_.audio_.id_
			audio_name = data.content_.audio_.file_name_
			audio_title = data.content_.audio_.title_
			tdcli.downloadFile(audio_id, dl_cb, nil)
		end
		tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.id_ }, get_cb, nil)
	elseif msg.content_.ID == "MessageSticker" then
		sticker_id = ''
		local function get_cb(arg, data)
			sticker_id = data.content_.sticker_.sticker_.id_
			tdcli.downloadFile(sticker_id, dl_cb, nil)
		end
		tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.id_ }, get_cb, nil)
	elseif msg.content_.ID == "MessageDocument" then
		document_id, document_name = '', ''
		local function get_cb(arg, data)
			document_id = data.content_.document_.document_.id_
			document_name = data.content_.document_.file_name_
			tdcli.downloadFile(document_id, dl_cb, nil)
		end
		tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.id_ }, get_cb, nil)
end
end

function tdcli_update_callback (data)
	if data.message_ then
		if msg_caption ~= get_text_msg() then
			msg_caption = get_text_msg()
		end
	end
	if (data.ID == "UpdateNewMessage") then
		local msg = data.message_
		local d = data.disable_notification_
		local chat = chats[msg.chat_id_]
		if ((not d) and chat) then
			if msg.content_.ID == "MessageText" then
				do_notify (chat.title_, msg.content_.text_)
			else
				do_notify (chat.title_, msg.content_.ID)
			end
		end
		if msg_valid(msg) then
		var_cb(msg, msg)
		file_cb(msg)
	if msg.content_.ID == "MessageText" then
		msg.text = msg.content_.text_
		msg.edited = false
		msg.pinned = false
	elseif msg.content_.ID == "MessagePinMessage" then
		msg.pinned = true
	elseif msg.content_.ID == "MessagePhoto" then
		msg.photo_ = true 
	elseif msg.content_.ID == "MessageVideo" then
		msg.video_ = true
	elseif msg.content_.ID == "MessageAnimation" then
		msg.animation_ = true
	elseif msg.content_.ID == "MessageVoice" then
		msg.voice_ = true
	elseif msg.content_.ID == "MessageAudio" then
		msg.audio_ = true
	elseif msg.content_.ID == "MessageForwardedFromUser" or msg.content_.ID  == "MessageForwardedPost"  then
	    msg.forward_info_ = true
    	msg.forward = {}
    	msg.forward.from_id = data.forward_info_.sender_user_id_
    	msg.forward.msg_id = data.forward_info_.data_
	elseif msg.content_.ID == "MessageSticker" then
		msg.sticker_ = true
	elseif msg.content_.ID == "MessageContact" then
		msg.contact_ = true
	elseif msg.content_.ID == "MessageDocument" then
		msg.document_ = true
	elseif msg.content_.ID == "MessageLocation" then
		msg.location_ = true
	elseif msg.content_.ID == "MessageGame" then
		msg.game_ = true
	elseif msg.content_.ID == "MessageChatAddMembers" then
	for i=0,#msg.content_.members_ do
		msg.adduser = msg.content_.members_[i].id_
	end
	elseif msg.content_.ID == "MessageChatJoinByLink" then
		msg.joinuser = msg.sender_user_id_
	elseif msg.content_.ID == "MessageChatDeleteMember" then
		msg.deluser = true
      end
	end
	elseif data.ID == "UpdateMessageContent" then  
		cmsg = data
		local function edited_cb(arg, data)
			msg = data
			msg.media = {}
			if cmsg.new_content_.text_ then
				msg.text = cmsg.new_content_.text_
			end
			if cmsg.new_content_.caption_ then
				msg.media.caption = cmsg.new_content_.caption_
			end
			msg.edited = true
		if msg_valid(msg) then
			var_cb(msg, msg)
        end
		end
	tdcli_function ({ ID = "GetMessage", chat_id_ = data.chat_id_, message_id_ = data.message_id_ }, edited_cb, nil)
	elseif data.ID == "UpdateFile" then
		file_id = data.file_.id_
	elseif (data.ID == "UpdateChat") then
		chat = data.chat_
		chats[chat.id_] = chat 
	elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
		tdcli_function ({ID="GetChats", offset_order_="9223372036854775807", offset_chat_id_=0, limit_=20}, dl_cb, nil)    
	end
end
