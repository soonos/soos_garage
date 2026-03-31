function getGermanyTimeOffset(timestamp)
    local t = os.date("!*t", timestamp)
    local year = t.year
    local march = os.time({year = year, month = 3, day = 31, hour = 1})
    while os.date("!*t", march).wday ~= 1 do
        march = march - 86400
    end
    local october = os.time({year = year, month = 10, day = 31, hour = 1})
    while os.date("!*t", october).wday ~= 1 do
        october = october - 86400
    end
    if timestamp >= march and timestamp < october then
        return 2 * 3600
    else
        return 1 * 3600
    end
end

function osTimeGermany()
    local utc = os.time()
    return utc + getGermanyTimeOffset(utc)
end