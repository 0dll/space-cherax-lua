
sigs.scan = function(sig, name_)
    local signature_ = Memory.Scan(sig, "GTA5.exe")
    if signature_ == 0 then
        log_t("failed to find: " .. name_)
    else
        log_t("found: " .. name_)
    end
    return signature_
end

sigs.scan_add = function(sig, name_, offset)
    local signature_ = Memory.Scan(sig, "GTA5.exe") + offset
    if signature_ == 0 then
        log_t("failed to find: " .. name_)
    else
        log_t("found: " .. name_)
    end
    return signature_
end

sigs.scan_sub = function(sig, name_, offset)
    local signature_ = Memory.Scan(sig, "GTA5.exe") - offset
    if signature_ == 0 then
        log_t("failed to find: " .. name_)
    else
        log_t("found: " .. name_)
    end
    return signature_
end


--sigs.FLAG_ENTITY_FOR_DELETION = sigs.scan("C6 81 D0 00 00 00 3C"):rip()
--[[
sigs.FLAG_ENTITY_FOR_DELETION = Memory.Rip(Memory.Scan("C6 81 D0 00 00 00 3C", "GTA5.exe"))

if sigs.FLAG_ENTITY_FOR_DELETION == 0 then
    log_t("failed to find: " .. "sigs.FLAG_ENTITY_FOR_DELETION")
else
    log_t("found: " .. "sigs.FLAG_ENTITY_FOR_DELETION: " .. tostring(sigs.FLAG_ENTITY_FOR_DELETION))
end

sigs.UNRIGSTER_ENTITY = Memory.Rip(Memory.Scan("48 89 5C 24 08 48 89 74 24 18 57 48 83 EC 20 48 8B 9A", "GTA5.exe") - 0x7C)

if sigs.UNRIGSTER_ENTITY == 0 then
    log_t("failed to find: " .. "sigs.UNRIGSTER_ENTITY" .. tostring(sigs.UNRIGSTER_ENTITY))
else
    log_t("found: " .. "sigs.UNRIGSTER_ENTITY: " .. tostring(sigs.UNRIGSTER_ENTITY))
end]] -- does not seem to be working

--sigs.send_chat_message = sigs.scan_sub("48 83 EC 20 48 8B F1 48 8B CA 41 8A E9", "send_chat_message", 21):rip()

--sigs.draw_rect = sigs.scan("48 8B C4 48 89 58 08 57 48 83 EC 70 48 63 0D", "draw_rect"):rip()