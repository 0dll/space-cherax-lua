
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

