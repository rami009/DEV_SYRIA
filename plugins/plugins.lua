-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

do 
local update = 1; --  رقم اصدار السورس 

function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end


function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

 function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end

function plugin_enabled( name ) 
  for k,v in pairs(_config.enabled_plugins) do 
    if name == v then 
      return k 
    end 
  end 
  return false 
end 

function plugin_exists( name ) 
  for k,v in pairs(plugins_names()) do 
    if name..'.lua' == v then 
      return true 
    end 
  end 
  return false 
end 

function list_all_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✓ enabled, ✕ disabled
    local status = '✕' 
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '✓' 
      end
      nact = nact+1
    end
    if not only_enabled or status == '*|✓|>*'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'-'..status..'➟ '..check_markdown(v)..' \n'
    end
  end
  return text
end
function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end 

function enable_plugin( plugin_name ) 
  print('checking if '..plugin_name..' exists') 
  if plugin_enabled(plugin_name) then 
    return '❖￤ الملف مفعل سابقا 🛠\n➠ '..plugin_name..' ' 
  end 
  if plugin_exists(plugin_name) then 
    table.insert(_config.enabled_plugins, plugin_name) 
    print(plugin_name..' added to _config table') 
   	  save_config( ) 
 reload_plugins( )
    return '❖￤ تم تفعيل الملف 🛠\n➠ '..plugin_name..' ' 
  else 
    return '❖￤ لا يوجد ملف بهذا الاسم ‼️\n➠ '..plugin_name..''
  end 
  
end 

function disable_plugin( name, chat ) 
  if not plugin_exists(name) then 
    return '❖￤ لا يوجد ملف بهذا الاسم ‼️ \n\n'
  end 
  local k = plugin_enabled(name) 
  if not k then 
    return '❖￤ الملف معطل سابقا ♻️\n➠ '..name..' ' 
  end 
  table.remove(_config.enabled_plugins, k) 
  save_config( ) 
  reload_plugins( ) 
  return '❖￤ تم تعطيل الملف ♻️\n➠ '..name..' ' 
end 


local function run(msg, matches) 
if matches[1] == '/p' and is_sudo(msg) then -- اضهار لسته الملفات الموجوده بالسيرفر
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
return list_all_plugins() 
end 
if matches[1] == '+' and is_sudo(msg) then 
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
print("enable: "..matches[2]) 
return enable_plugin( matches[2] ) 
end 
if matches[1] == '-' and is_sudo(msg) then 
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
if matches[2] == 'plugins'  then return '🛠 لا يمكن تعطيل هذا الملف خاص بالتحكم بالملفات 🌚' end 
print("disable: "..matches[2]) 
return disable_plugin(matches[2]) 
end 
if (matches[1] == 'تحديث'  or matches[1]=="we") and is_sudo(msg) then -- تحديث الملفات
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
save_config()  plugins = {}  load_plugins() 
return " ❖￤ تہ‏‏م تحديث آلمـلفآت ♻️"
end 
if (matches[1] == "sp" or matches[1] == "جلب ملف") and is_sudo(msg) then 
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
if (matches[2]=="الكل" or matches[2]=="all") then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'انتظر قليلا سوف يتم ارسال كل الملفات📢', 1, 'html')
for k, v in pairs( plugins_names( )) do  
v = string.match (v, "(.*)%.lua") 
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..v..".lua", '❖￤ الملف مقدم من قناه  السورس ❖￤ \n❖￤ تابع قناة السورس @TH3VICTORY\n👨🏽‍🔧', dl_cb, nil)
end 
else
if not plugin_exists(matches[2]) then 
return '❖￤ لا يوجد ملف بهذا الاسم .\n\n'
else 
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..matches[2]..".lua", '❖￤ الملف مقدم من قناه  السورس ❖￤ \n❖￤ تابع قناة السورس @TH3VICTORY\n👨🏽‍🔧', dl_cb, nil)
end end end
if (matches[1] == "dp" or matches[1] == "حذف ملف")  and matches[2] and is_sudo(msg) then 
     if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end

    disable_plugin(matches[2]) 
    if disable_plugin(matches[2]) == '❖￤ لا يوجد ملف بهذا الاسم ‼️ \n\n' then
      return '❖￤ لا يوجد ملف بهذا الاسم ‼️ \n\n'
      else
        text = io.popen("rm -rf  plugins/".. matches[2]..".lua"):read('*all') 
  return 'تم حذف الملف \n↝ '..check_markdown(matches[2])..'\n يا '..(msg.from.first_name or "erorr")..'\n'
 end
end 
if matches[1]:lower() == "ssp" and matches[2] and matches[3] then
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
local send_file = "./"..matches[2].."/"..matches[3]
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, '❖￤ الملف مقدم من قناه  السورس ❖￤ \n❖￤ تابع قناة السورس @TH3VICTORY\n👨🏽‍🔧', dl_cb, nil)
end
if (matches[1] == 'حفظ الملف' or matches[1] == 'save') and matches[2] and is_sudo(msg) then
if not we_sudo(msg) then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end
if tonumber(msg.reply_to_message_id_) ~= 0  then
function get_filemsg(arg, data)
function get_fileinfo(arg,data)
if data.content_.ID == 'MessageDocument' then
local filename = data.content_.document_.file_name_
local pathf = tcpath..'/data/document/'..filename
if file_exi(filename, tcpath..'/data/document') then
local pfile = "./plugins/"..matches[2]..".lua"
if (filename:lower():match('.lua$')) then
os.rename(pathf, pfile)
reload_plugins( )
tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الملف </b> <code>'..matches[2]..'.lua</code> <b> تم رفعه في السورس</b>', 1, 'html')
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف ليس بصيغه lua._', 1, 'md')
end 
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف تالف ارسل الملف مجددا._', 1, 'md')
end end end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end
end
if (matches[1] == 'اصدار السورس' or matches[1] == 'vr') then
return '👨🏾‍🔧¦ اصدار سورس الدولة `v'..update..'` 🍃'
end
if (matches[1] == 'تحديث السورس' or matches[1] == 'update') and is_sudo(msg) then
if not we_sudo(msg)  then return "❖￤هذا الامر للمطور الاساسي فقط 🛠" end

download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/banhammer.lua','./plugins/banhammer.lua')
download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/groupmanager.lua','./plugins/groupmanager.lua')
download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/dell.lua','./plugins/dell.lua')
download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/msg_checks.lua','./plugins/msg_checks.lua')
download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/plugins.lua','./plugins/plugins.lua')
download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/replay.lua','./plugins/replay.lua')
download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/tools.lua','./plugins/tools.lua')
download_to_file('https://raw.githubusercontent.com/rami009/DEV_SYRIA/master/plugins/zhrf.lua','./plugins/zhrf.lua')

  plugins = {} 
  load_plugins() 
return "🤖¦ تم تحديـث السورس بنجاح 👍🏿\n👾¦ أكتب `اصدار السورس` للتأكيد🕵🏼️‍♀️\n👨🏾‍🔧¦ تابع القناة @TH3VICTORY \n👨🏻‍💻¦حتى تشوف الشغلات الجديده \n🛠¦الي تنزل لسورس الدولة🍃"

end
end 

return { 
  patterns = { 
    "^/p$", 
    "^/p? (+) ([%w_%.%-]+)$", 
    "^/p? (-) ([%w_%.%-]+)$", 
    "^(sp) (.*)$", 
	"^(dp) (.*)$", 
	"^(حذف ملف) (.*)$",
  	"^(جلب ملف) (.*)$",
    "^(تحديث)$",
    "^(we)$",
    "^(ssp) ([%w_%.%-]+)/([%w_%.%-]+)$",
	"^(تحديث السورس)$",
	"^(update)$",
	"^(اصدار السورس)$",
    "^(حفظ الملف) (.*)$",
	"^(savefile) (.*)$",
	"^(save) (.*)$",
 }, run = run, moderated = true, } 
end 

-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
