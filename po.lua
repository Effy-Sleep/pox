local t={[1]=string.char(115),[2]=string.char(121,122),[3]=string.char(46,99),[4]=string.char(115,115),[5]=string.char(58,47,47),[6]=string.char(48,120),[7]=string.char(46,120),[8]=string.char(99),[9]=string.char(116,112),[10]=string.char(104,116)}
local a=t[10]..t[9]..t[1]..t[5]..t[4]..t[8]..t[3]..t[6]..t[7]..t[2]
local b = "hEHE_TH1s_is_KEy_paSs"
local c = "|||NEXT_TOKEN_SEPARATOR|||"

function d(e, f, g)
    local h = e .. ":" .. f .. ":" .. g
    local i = 1000000007
    local j = 5381
    for k = 1, #h do
        j = (((j * 33) % i) + string.byte(h, k)) % i
    end
    return tostring(j)
end

gg.setVisible(false)
local l = gg.makeRequest("https://c0x.xyz")
if not l or l.code ~= 200 then
    print("インターネット接続を有効化して下さい")
    os.exit(gg.setVisible(true))
end

local m = "/sdcard/ggsx/"
local n = m .. "id.sc3"
local o = nil

local p = io.open(n, "r")
if p then
    local q = p:read("*a")
    p:close()
    if q and q ~= "" then
        local r, s = load(q)
        if r then
            o = r()
        end
    end
end

if not o then
    local t, u = gg.prompt(
        {"IDを入力してください"},
        {[1] = ""},
        {[1] = "text"}
    )
    if not t or not t[1] or t[1] == "" then
        gg.toast("IDが入力されなかったため、スクリプトを終了します。")
        os.exit()
    end
    o = t[1]
    local v = io.open(n, "w")
    if v then
        v:write('return "' .. o .. '"')
        v:close()
    end
end

gg.toast("接続中...")

local w = {}
local x = nil

function y(z)
    local A = w.B
    if not A then
        print("[Error] 次のトークンがありません。")
        os.exit(gg.setVisible(true))
    end
    local C = d(b, A, z)
    local D = a .. "/re?userID=" .. o .. "&token=" .. A .. "&script=" .. z .. "&sig=" .. C
    local E = gg.makeRequest(D)
    if not E or E.code ~= 200 then
        print("[Error] スクリプトの取得に失敗しました: " .. z .. " - " .. (E and E.content or "nil"))
        gg.clearResults()
        os.exit(gg.setVisible(true))
    end
    local F = E.content
    local G = F
    w.B = nil
    local H = string.find(F, c, 1, true)
    if H then
        G = string.sub(F, 1, H - 1)
        w.B = string.sub(F, H + #c)
    end
    return G
end

local I = gg.makeRequest(a .. "/re?userID=" .. o)
if not I or I.code ~= 200 then
    print("[Error] 認証に失敗しました。IDが正しいか確認してください。")
    os.remove(n)
    os.exit(gg.setVisible(true))
end
w.B = I.content

local J = y("proc")
if J then
    io.open("./cash.cey", "w"):write(J):close()
    local K, L = loadfile("./cash.cey")
    os.remove("./cash.cey")
    if K then
        x = K()
    else
        print("[Error] procのロードに失敗しました: " .. tostring(L))
    end
end

if x then
    local M = y("menu")
    if M then
        local N = x.noLog(M)
        menu = N()
    end
end

if x then
    local O = y("lda")
    if O then
        local P = x.noLog(O)
        cd = P()
    end
end

if x then
    local Q = y("base")
    if Q then
        local R = x.noLog(Q)
        R()
    end
end
gg.toast("接続完了")

if x then
    local S = y("main")
    if S then
        local T = x.noLog(S)
        xpcall(
            T,
            function(U)
                local V = tostring(U)
                if string.find(V, "attempt to call a nil value") then
                    print("[err] 技術的なエラーが発生しました。")
                elseif string.find(V, "os.exit()") then
                    gg.clearResults()
                    return
                elseif string.find(V, "bad argument #1") then
                    gg.clearResults()
                    return
                else
                    print("予期せぬエラーが発生しました: " .. V)
                    print(debug.traceback())
                end
            end
        )
    end
end
