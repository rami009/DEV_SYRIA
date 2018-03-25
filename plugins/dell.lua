-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY

local function delmsg (i,naji)
    msgs = i.msgs 
    for k,v in pairs(naji.messages_) do
        msgs = msgs - 1
        tdcli.deleteMessages(v.chat_id_,{[0] = v.id_}, dl_cb, cmd)
        if msgs == 1 then
            tdcli.deleteMessages(naji.messages_[0].chat_id_,{[0] = naji.messages_[0].id_}, dl_cb, cmd)
            return false
        end
    end
    tdcli.getChatHistory(naji.messages_[0].chat_id_, naji.messages_[0].id_,0 , 100, delmsg, {msgs=msgs})
end
local function run(msg, matches)
    if matches[1] == 'Ù…Ø³Ø­' and is_owner(msg) then
        if tostring(msg.to.id):match("^-100") then 
            if tonumber(matches[2]) > 1000 or tonumber(matches[2]) < 1 then
                return  'ðŸš« *1000*> _ÙŠØ¬Ø¨ Ø§Ù† Ù„Ø§ ÙŠØªØ¬Ø§ÙˆØ²_ >*1* ðŸš«'
            else
                tdcli.getChatHistory(msg.to.id, msg.id,0 , 100, delmsg, {msgs=matches[2]})
                return "`"..matches[2].." `ØªÙ… Ù…Ø³Ø­"
            end
        else
            return ' _ØºÙ„Ø·_ '
        end
    end
end
return {
    patterns = {
        '^(Ù…Ø³Ø­) (%d*)$',
    },
    run = run
}

-- BY RAMI Syria
-- BY @RAMBO_SYR
-- BY @TH3VICTORY
-- V1
