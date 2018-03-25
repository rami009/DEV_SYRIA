-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

---------------Lock brod-------------------
function lock_brod(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if not redis:get(rami..'lock_brod') then
return '❖￤اذاعه المطورين بالتاكيد تم تعطيلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:del(rami..'lock_brod')
return '❖￤تم تعطيل اذاعه المطورين ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
function unlock_brod(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if redis:get(rami..'lock_brod') then
return '❖￤اذاعه المطورين بالتاكيد تم تفعيلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:set(rami..'lock_brod',true)
return '❖￤تم تفعيل اذاعه المطورين ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock replay-------------------
function lock_replay(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if not redis:get(rami..'replay'..msg.to.id) then
return '❖￤الردود بالتاكيد تم تعطيلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:del(rami..'replay'..msg.to.id)
return '❖￤تم تعطيل الردود ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_replay(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if redis:get(rami..'replay'..msg.to.id) then
return '❖￤الردود بالتاكيد تم تفعيلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:set(rami..'replay'..msg.to.id,true)
return '❖￤تم تفعيل الردود ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock bot service-------------------
function lock_service(msg)
if not we_sudo(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end 
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_service') then
return '❖￤  تم بالتاكيد تعطيل نظام البوت خدمي ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:del(rami..'lock_service')
return '❖￤تم  تعطيل نظام البوت خدمي ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_service(msg)
if not we_sudo(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'lock_service') then
return '❖￤ تم بالتأكيد تفعيل نظام البوت خدمي ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:set(rami..'lock_service',true)
return '❖￤ تم تفعيل نظام البوت خدمي ✓\n❖￤ اصبح البوت الان بامكان اي شخص\n❖￤ ان يستخدم البوت للتفعيل\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Lock Link-------------------
function lock_link(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if redis:get(rami..'lock_link'..msg.to.id) then
return '❖￤الروابط بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_link'..msg.to.id,true)
return '❖￤تم قفل الروابط ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_link(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if not redis:get(rami..'lock_link'..msg.to.id) then
return '❖￤الروابط بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_link'..msg.to.id)
return '❖￤تم فتح الروابط ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock Tag-------------------
function lock_tag(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if redis:get(rami..'lock_tag'..msg.to.id) then
return '❖￤التاك(#) بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_tag'..msg.to.id,true)
return '❖￤تم قفل التاك(#) ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_tag(msg, data, target)

if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if not redis:get(rami..'lock_tag'..msg.to.id) then
return '❖￤التاك(#) بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_tag'..msg.to.id)
return '❖￤تم فتح التاك(#) ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Lock UserName-------------------
function lock_username(msg, data, target) 

if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --


if redis:get(rami..'lock_username'..msg.to.id) then
return '❖￤المعرفات @ بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_username'..msg.to.id,true)
return '❖￤تم قفل المعرفات @ ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_username(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if not redis:get(rami..'lock_username'..msg.to.id) then
return '❖￤المعرفات @ بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_username'..msg.to.id)
return '❖￤تم فتح المعرفات @ ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock Edit-------------------
function lock_edit(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if redis:get(rami..'lock_edit'..msg.to.id) then
return '❖￤التعديل بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_edit'..msg.to.id,true)
return '❖￤تم قفل التعديل ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_edit(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if not redis:get(rami..'lock_edit'..msg.to.id) then
return '❖￤التعديل بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_edit'..msg.to.id)
return '❖￤تم فتح التعديل ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock spam-------------------
function lock_spam(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if   redis:get(rami..'lock_spam'..msg.to.id) then
return '❖￤الكلايش بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_spam'..msg.to.id,true)
return '❖￤تم قفل الكلايش ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_spam(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_spam'..msg.to.id) then
return '❖￤الكلايش بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_spam'..msg.to.id)
return '❖￤تم فتح الكلايش ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock Flood-------------------
function lock_flood(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'lock_flood'..msg.to.id) then
return '❖￤التكرار بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_flood'..msg.to.id,true)
return '❖￤تم قفل التكرار ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_flood(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_flood'..msg.to.id) then
return '❖￤التكرار بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_flood'..msg.to.id)
return '❖￤تم فتح التكرار ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock Bots-------------------
function lock_bots(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'lock_bots'..msg.to.id) then
return '❖￤البوتات بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_bots'..msg.to.id,true)
return '❖￤تم قفل البوتات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_bots(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_bots'..msg.to.id) then
return '❖￤البوتات بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_bots'..msg.to.id)
return '❖￤تم فتح البوتات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock Join-------------------
function lock_join(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'lock_join'..msg.to.id) then
return '❖￤الاضافه بالتاكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_join'..msg.to.id,true)
return '❖￤تم قفل الاضافه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_join(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_join'..msg.to.id) then
return '❖￤الاضافه بالتاكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_join'..msg.to.id)
return '❖￤تم فتح الاضافه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock Markdown-------------------
function lock_markdown(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'lock_markdown'..msg.to.id) then
return '❖￤الماركدوان بالتاكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_markdown'..msg.to.id,true)
return '❖￤تم قفل الماركدوان ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_markdown(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_markdown'..msg.to.id) then
return '❖￤الماركدوان بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_markdown'..msg.to.id)
return '❖￤تم فتح الماركدوان ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Lock Webpage-------------------
function lock_webpage(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'lock_webpage'..msg.to.id) then
return '❖￤الويب بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_webpage'..msg.to.id,true)
return '❖￤تم قفل الويب ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_webpage(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_webpage'..msg.to.id) then
return '❖￤الويب بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:set(rami..'lock_webpage'..msg.to.id,true)
return '❖￤تم فتح الويب ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Gif-------------------
function mute_gif(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_gif'..msg.to.id) then
return '❖￤المتحركه بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_gif'..msg.to.id,true)
return '❖￤تم قفل المتحركه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_gif(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_gif'..msg.to.id) then
return '❖￤المتحركه بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_gif'..msg.to.id)
return '❖￤تم فتح المتحركه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Game-------------------
function mute_game(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_game'..msg.to.id) then
return '❖￤الالعاب بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:ser('mute_game'..msg.to.id,true)
return '❖￤تم قفل الالعاب ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_game(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_game'..msg.to.id) then
return '❖￤الألعاب بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_game'..msg.to.id)
return '❖￤تم فتح الألعاب ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Inline-------------------
function mute_inline(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_inline'..msg.to.id) then
return '❖￤الانلاين بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_inline'..msg.to.id,true)
return '❖￤تم قفل الانلاين ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_inline(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_inline'..msg.to.id) then
return '❖￤الانلاين بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_inline'..msg.to.id)
return '❖￤تم فتح الانلاين ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Text-------------------
function mute_text(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_text'..msg.to.id) then
return '❖￤الدرشه بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_text'..msg.to.id,true)
return '❖￤تم قفل الدردشه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_text(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_text'..msg.to.id) then
return '❖￤الدردشه بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_text'..msg.to.id,true)
return '❖￤تم فتح الدردشه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute photo-------------------
function mute_photo(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_photo'..msg.to.id) then
return '❖￤الصور بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_photo'..msg.to.id,true)
return '❖￤تم قفل الصور ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_photo(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_photo'..msg.to.id)then
return '❖￤الصور بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_photo'..msg.to.id)
return '❖￤تم فتح الصور ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Video-------------------
function mute_video(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_video'..msg.to.id) then
return '❖￤الفيديو بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_video'..msg.to.id,true)
return '❖￤تم قفل الفيديو ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_video(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_video'..msg.to.id) then
return '❖￤الفيديو بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_video'..msg.to.id)
return '❖￤تم فتح الفيديو ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Audio-------------------
function mute_audio(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_audio'..msg.to.id) then
return '❖￤البصمات بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_audio'..msg.to.id,true)
return '❖￤تم قفل البصمات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_audio(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_audio'..msg.to.id) then
return '❖￤البصمات بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_audio'..msg.to.id)
return '❖￤تم فتح البصمات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Voice-------------------
function mute_voice(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if   redis:get(rami..'mute_voice'..msg.to.id) then
return '❖￤الصوت بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_voice'..msg.to.id,true)
return '❖￤تم قفل الصوت ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_voice(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_voice'..msg.to.id) then
return '❖￤الصوت بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_voice'..msg.to.id)
return '❖￤تم فتح الصوت ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Sticker-------------------
function mute_sticker(msg, data, target) 

if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --

if   redis:get(rami..'mute_sticker'..msg.to.id) then
return '❖￤الملصقات بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_sticker'..msg.to.id,true)
return '❖￤تم قفل الملصقات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_sticker(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_sticker'..msg.to.id) then
return '❖￤الملصقات بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_sticker'..msg.to.id)
return '❖￤تم فتح الملصقات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Contact-------------------
function mute_contact(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_contact'..msg.to.id) then
return '❖￤جهات الاتصال بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_contact'..msg.to.id,true)
return '❖￤تم قفل جهات الاتصال ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_contact(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_contact'..msg.to.id) then
return '❖￤جهات الاتصال بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_contact'..msg.to.id)
return '❖￤تم فتح جهات الاتصال ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Forward-------------------
function mute_forward(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_forward'..msg.to.id) then
return '❖￤التوجيه بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_forward'..msg.to.id,true)
return '❖￤تم قفل التوجيه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_forward(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_forward'..msg.to.id) then
return '❖￤التوجيه بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_forward'..msg.to.id)
return '❖￤تم فتح التوجيه ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Location-------------------
function mute_location(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_location'..msg.to.id) then
return '❖￤الموقع بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_location'..msg.to.id,true)
return '❖￤تم قفل الموقع ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_location(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_location'..msg.to.id) then
return '❖￤الموقع بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_location'..msg.to.id)
return '❖￤تم فتح الموقع ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute Document-------------------
function mute_document(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_document'..msg.to.id) then
return '❖￤الملفات بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_document'..msg.to.id,true)
return '❖￤تم قفل الملفات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_document(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_document'..msg.to.id) then
return '❖￤الملفات بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_document'..msg.to.id)
return '❖￤تم فتح الملفات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end
---------------Mute TgService-------------------
function mute_tgservice(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_tgservice'..msg.to.id) then
return '❖￤الاشعارات بالتأكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_tgservice'..msg.to.id,true)
return '❖￤تم قفل الاشعارات ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_tgservice(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_tgservice'..msg.to.id) then
return '❖￤الاشعارات بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_tgservice'..msg.to.id)
return '❖￤الاشعارات بالتأكيد تم فتحها ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------Mute Keyboard-------------------
function mute_keyboard(msg, data, target) 
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'mute_keyboard'..msg.to.id) then
return '❖￤الكيبورد بالتأكيد تم قفله ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'mute_keyboard'..msg.to.id,true)
return '❖￤تم قفل الكيبورد ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unmute_keyboard(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶" 
end
-- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'mute_keyboard'..msg.to.id) then
return '❖￤الكيبورد بالتأكيد تم فتحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'mute_keyboard'..msg.to.id)
return '❖￤تم فتح الكيبورد ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

---------------lock_bots_by_kick-------------------
function lock_bots_by_kick(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if redis:get(rami..'lock_bots_by_kick'..msg.to.id) then
return '❖￤البوتات بالطرد بالتاكيد تم قفلها ✓\n❖￤ بواسطه ⇔ '..syria..''
else
redis:set(rami..'lock_bots_by_kick'..msg.to.id,true)
return '❖￤تم قفل البوتات بالطرد (مع طرد الي ضافه) ✓\n❖￤ بواسطه ⇔ '..syria..''
end
end

function unlock_bots_by_kick(msg, data, target)
if not is_mod(msg) then return "❖￤ هذا الامر يخص الادمنيه فقط  🚶"
 end
 -- حصانه التحقق من العضو --
if is_sudo(msg) then
syria = 'المطور'
elseif is_owner(msg) then
syria = 'المدير'
elseif is_mod(msg) then
syria = 'ادمن'
end
-- حصانه التحقق من العضو --
if not redis:get(rami..'lock_bots_by_kick'..msg.to.id) then
return '❖￤البوتات بالطرد بالتاكيد مفتوحه ✓\n❖￤ بواسطه ⇔ '..syria..''
else 
redis:del(rami..'lock_bots_by_kick'..msg.to.id)
return '❖￤تم فتح البوتات بالطرد ✓\n❖￤ بواسطه ⇔ '..syria..''
end 
end
-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
