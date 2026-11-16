-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

-- line 3-7
-- proto#1 params=3 locals=4 upvalues=0 vararg=false
function vec2Rotate(p1_0, p1_1, p1_2)
    local r1_0 = _G.math.sin(p1_2)
    local r1_1 = _G.math.cos(p1_2)
    return r1_1 * p1_0 - r1_0 * p1_1, r1_0 * p1_0 + r1_1 * p1_1
end

-- line 10-12
-- proto#2 params=4 locals=1 upvalues=0 vararg=false
function vec2AngleBetween(p2_0, p2_1, p2_2, p2_3)
    return _G.math.atan2(dotProduct(-p2_1, p2_0, p2_2, p2_3), dotProduct(p2_0, p2_1, p2_2, p2_3))
end

-- line 15-17
-- proto#3 params=1 locals=3 upvalues=0 vararg=false
function vec2FromAngle(p3_0)
    local r3_0 = _G.math.cos(p3_0)
    local r3_1 = _G.math.sin
    return r3_0, r3_1(p3_0)
end
