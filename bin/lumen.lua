nexus = {}
(function ()
  nexus["lumen/runtime"] = {}
  local function nil63(x)
    return(x == nil)
  end
  nexus["lumen/runtime"]["nil?"] = nil63
  local function is63(x)
    return(not nil63(x))
  end
  nexus["lumen/runtime"]["is?"] = is63
  local function length(x)
    return(#x)
  end
  nexus["lumen/runtime"].length = length
  local function none63(x)
    return(length(x) == 0)
  end
  nexus["lumen/runtime"]["none?"] = none63
  local function some63(x)
    return(length(x) > 0)
  end
  nexus["lumen/runtime"]["some?"] = some63
  local function one63(x)
    return(length(x) == 1)
  end
  nexus["lumen/runtime"]["one?"] = one63
  local function hd(l)
    return(l[1])
  end
  nexus["lumen/runtime"].hd = hd
  local function string63(x)
    return(type(x) == "string")
  end
  nexus["lumen/runtime"]["string?"] = string63
  local function number63(x)
    return(type(x) == "number")
  end
  nexus["lumen/runtime"]["number?"] = number63
  local function boolean63(x)
    return(type(x) == "boolean")
  end
  nexus["lumen/runtime"]["boolean?"] = boolean63
  local function function63(x)
    return(type(x) == "function")
  end
  nexus["lumen/runtime"]["function?"] = function63
  local function composite63(x)
    return(is63(x) and type(x) == "table")
  end
  nexus["lumen/runtime"]["composite?"] = composite63
  local function atom63(x)
    return(nil63(x) or not composite63(x))
  end
  nexus["lumen/runtime"]["atom?"] = atom63
  local function table63(x)
    return(composite63(x) and nil63(hd(x)))
  end
  nexus["lumen/runtime"]["table?"] = table63
  local function list63(x)
    return(composite63(x) and is63(hd(x)))
  end
  nexus["lumen/runtime"]["list?"] = list63
  local function substring(str, from, upto)
    return(string.sub(str, from + 1, upto))
  end
  nexus["lumen/runtime"].substring = substring
  local function sub(x, from, upto)
    if string63(x) then
      return(substring(x, from or 0, upto))
    else
      local l = {}
      local j = 0
      local _g142
      if nil63(from) or from < 0 then
        _g142 = 0
      else
        _g142 = from
      end
      local i = _g142
      local n = length(x)
      local _g143
      if nil63(upto) or upto > n then
        _g143 = n
      else
        _g143 = upto
      end
      local _g46 = _g143
      while i < _g46 do
        l[j + 1] = x[i + 1]
        i = i + 1
        j = j + 1
      end
      local _g47 = x
      local k = nil
      for k in next, _g47 do
        local v = _g47[k]
        if not number63(k) then
          l[k] = v
        end
      end
      return(l)
    end
  end
  nexus["lumen/runtime"].sub = sub
  local function keys(x)
    local t = {}
    local _g50 = x
    local k = nil
    for k in next, _g50 do
      local v = _g50[k]
      if not number63(k) then
        t[k] = v
      end
    end
    return(t)
  end
  nexus["lumen/runtime"].keys = keys
  local function inner(x)
    return(sub(x, 1, length(x) - 1))
  end
  nexus["lumen/runtime"].inner = inner
  local function tl(l)
    return(sub(l, 1))
  end
  nexus["lumen/runtime"].tl = tl
  local function char(str, n)
    return(sub(str, n, n + 1))
  end
  nexus["lumen/runtime"].char = char
  local function code(str, n)
    local _g144
    if n then
      _g144 = n + 1
    end
    return(string.byte(str, _g144))
  end
  nexus["lumen/runtime"].code = code
  local function string_literal63(x)
    return(string63(x) and char(x, 0) == "\"")
  end
  nexus["lumen/runtime"]["string-literal?"] = string_literal63
  local function id_literal63(x)
    return(string63(x) and char(x, 0) == "|")
  end
  nexus["lumen/runtime"]["id-literal?"] = id_literal63
  local function add(l, x)
    return(table.insert(l, x))
  end
  nexus["lumen/runtime"].add = add
  local function drop(l)
    return(table.remove(l))
  end
  nexus["lumen/runtime"].drop = drop
  local function last(l)
    return(l[length(l) - 1 + 1])
  end
  nexus["lumen/runtime"].last = last
  local function reverse(l)
    local l1 = sub(l, length(l))
    local i = length(l) - 1
    while i >= 0 do
      add(l1, l[i + 1])
      i = i - 1
    end
    return(l1)
  end
  nexus["lumen/runtime"].reverse = reverse
  local function join(a, b)
    if a and b then
      local c = {}
      local o = length(a)
      local _g63 = a
      local k = nil
      for k in next, _g63 do
        local v = _g63[k]
        c[k] = v
      end
      local _g65 = b
      local k = nil
      for k in next, _g65 do
        local v = _g65[k]
        if number63(k) then
          k = k + o
        end
        c[k] = v
      end
      return(c)
    else
      return(a or b or {})
    end
  end
  nexus["lumen/runtime"].join = join
  local function reduce(f, x)
    if none63(x) then
      return(x)
    else
      if one63(x) then
        return(hd(x))
      else
        return(f(hd(x), reduce(f, tl(x))))
      end
    end
  end
  nexus["lumen/runtime"].reduce = reduce
  local function shift(k, n)
    if number63(k) then
      return(k - n)
    else
      return(k)
    end
  end
  nexus["lumen/runtime"].shift = shift
  local function keep(f, x)
    local t = {}
    local o = 0
    local _g70 = x
    local k = nil
    for k in next, _g70 do
      local v = _g70[k]
      if f(v) then
        t[shift(k, o)] = v
      else
        o = o + 1
      end
    end
    return(t)
  end
  nexus["lumen/runtime"].keep = keep
  local function in63(x, t)
    local _g73 = t
    local _g21 = nil
    for _g21 in next, _g73 do
      local y = _g73[_g21]
      if x == y then
        return(true)
      end
    end
  end
  nexus["lumen/runtime"]["in?"] = in63
  local function find(f, t)
    local _g76 = t
    local _g22 = nil
    for _g22 in next, _g76 do
      local x = _g76[_g22]
      local _g78 = f(x)
      if _g78 then
        return(_g78)
      end
    end
  end
  nexus["lumen/runtime"].find = find
  local function pair(l)
    local i = 0
    local l1 = {}
    while i < length(l) do
      add(l1, {l[i + 1], l[i + 1 + 1]})
      i = i + 2
    end
    return(l1)
  end
  nexus["lumen/runtime"].pair = pair
  local function sort(l, f)
    table.sort(l, f)
    return(l)
  end
  nexus["lumen/runtime"].sort = sort
  local function iterate(f, count)
    local i = 0
    while i < count do
      f(i)
      i = i + 1
    end
  end
  nexus["lumen/runtime"].iterate = iterate
  local function replicate(n, x)
    local l = {}
    iterate(function ()
      return(add(l, x))
    end, n)
    return(l)
  end
  nexus["lumen/runtime"].replicate = replicate
  local function series(f, l)
    return(iterate(function (i)
      return(f(l[i + 1]))
    end, length(l)))
  end
  nexus["lumen/runtime"].series = series
  local function map(f, x)
    local t = {}
    local o = 0
    local _g87 = x
    local k = nil
    for k in next, _g87 do
      local v = _g87[k]
      local y = f(v)
      if is63(y) then
        t[shift(k, o)] = y
      else
        o = o + 1
      end
    end
    return(t)
  end
  nexus["lumen/runtime"].map = map
  local function keys63(t)
    local b = false
    local _g90 = t
    local k = nil
    for k in next, _g90 do
      local _g23 = _g90[k]
      if not number63(k) then
        b = true
        break
      end
    end
    return(b)
  end
  nexus["lumen/runtime"]["keys?"] = keys63
  local function empty63(t)
    local b = true
    local _g93 = t
    local _g24 = nil
    for _g24 in next, _g93 do
      local _g25 = _g93[_g24]
      b = false
      break
    end
    return(b)
  end
  nexus["lumen/runtime"]["empty?"] = empty63
  local function stash(args)
    if keys63(args) then
      local p = {}
      local _g96 = args
      local k = nil
      for k in next, _g96 do
        local v = _g96[k]
        if not number63(k) then
          p[k] = v
        end
      end
      p._stash = true
      add(args, p)
    end
    return(args)
  end
  nexus["lumen/runtime"].stash = stash
  local function unstash(args)
    if none63(args) then
      return({})
    else
      local l = last(args)
      if table63(l) and l._stash then
        local args1 = sub(args, 0, length(args) - 1)
        local _g99 = l
        local k = nil
        for k in next, _g99 do
          local v = _g99[k]
          if not (k == "_stash") then
            args1[k] = v
          end
        end
        return(args1)
      else
        return(args)
      end
    end
  end
  nexus["lumen/runtime"].unstash = unstash
  local function search(str, pattern, start)
    local _g145
    if start then
      _g145 = start + 1
    end
    local _g102 = _g145
    local i = string.find(str, pattern, _g102, true)
    return(i and i - 1)
  end
  nexus["lumen/runtime"].search = search
  local function split(str, sep)
    if str == "" or sep == "" then
      return({})
    else
      local strs = {}
      while true do
        local i = search(str, sep)
        if nil63(i) then
          break
        else
          add(strs, sub(str, 0, i))
          str = sub(str, i + 1)
        end
      end
      add(strs, str)
      return(strs)
    end
  end
  nexus["lumen/runtime"].split = split
  local function cat(...)
    local xs = unstash({...})
    if none63(xs) then
      return("")
    else
      return(reduce(function (a, b)
        return(a .. b)
      end, xs))
    end
  end
  nexus["lumen/runtime"].cat = cat
  local function _43(...)
    local xs = unstash({...})
    return(reduce(function (a, b)
      return(a + b)
    end, xs))
  end
  nexus["lumen/runtime"]["+"] = _43
  local function _(...)
    local xs = unstash({...})
    return(reduce(function (b, a)
      return(a - b)
    end, reverse(xs)))
  end
  nexus["lumen/runtime"]["-"] = _
  local function _42(...)
    local xs = unstash({...})
    return(reduce(function (a, b)
      return(a * b)
    end, xs))
  end
  nexus["lumen/runtime"]["*"] = _42
  local function _47(...)
    local xs = unstash({...})
    return(reduce(function (b, a)
      return(a / b)
    end, reverse(xs)))
  end
  nexus["lumen/runtime"]["/"] = _47
  local function _37(...)
    local xs = unstash({...})
    return(reduce(function (b, a)
      return(a % b)
    end, reverse(xs)))
  end
  nexus["lumen/runtime"]["%"] = _37
  local function _62(a, b)
    return(a > b)
  end
  nexus["lumen/runtime"][">"] = _62
  local function _60(a, b)
    return(a < b)
  end
  nexus["lumen/runtime"]["<"] = _60
  local function _61(a, b)
    return(a == b)
  end
  nexus["lumen/runtime"]["="] = _61
  local function _6261(a, b)
    return(a >= b)
  end
  nexus["lumen/runtime"][">="] = _6261
  local function _6061(a, b)
    return(a <= b)
  end
  nexus["lumen/runtime"]["<="] = _6061
  local function read_file(path)
    local f = io.open(path)
    return(f.read(f, "*a"))
  end
  nexus["lumen/runtime"]["read-file"] = read_file
  local function write_file(path, data)
    local f = io.open(path, "w")
    return(f.write(f, data))
  end
  nexus["lumen/runtime"]["write-file"] = write_file
  local function write(x)
    return(io.write(x))
  end
  nexus["lumen/runtime"].write = write
  local function exit(code)
    return(os.exit(code))
  end
  nexus["lumen/runtime"].exit = exit
  local function today()
    return(os.date("!%F"))
  end
  nexus["lumen/runtime"].today = today
  local function now()
    return(os.time())
  end
  nexus["lumen/runtime"].now = now
  local function number(str)
    return(tonumber(str))
  end
  nexus["lumen/runtime"].number = number
  local function string(x)
    if nil63(x) then
      return("nil")
    else
      if boolean63(x) then
        if x then
          return("true")
        else
          return("false")
        end
      else
        if function63(x) then
          return("#<function>")
        else
          if atom63(x) then
            return(x .. "")
          else
            local str = "("
            local sp = ""
            local xs = {}
            local ks = {}
            local _g123 = x
            local k = nil
            for k in next, _g123 do
              local v = _g123[k]
              if number63(k) then
                xs[k] = string(v)
              else
                add(ks, k .. ":")
                add(ks, string(v))
              end
            end
            local _g125 = join(xs, ks)
            local _g26 = nil
            for _g26 in next, _g125 do
              local v = _g125[_g26]
              str = str .. sp .. v
              sp = " "
            end
            return(str .. ")")
          end
        end
      end
    end
  end
  nexus["lumen/runtime"].string = string
  local function space(xs)
    local function string(x)
      if string_literal63(x) or list63(x) and hd(x) == "cat" then
        return(x)
      else
        return({"string", x})
      end
    end
    if one63(xs) then
      return(string(hd(xs)))
    else
      return(reduce(function (a, b)
        return({"cat", string(a), "\" \"", string(b)})
      end, xs))
    end
  end
  nexus["lumen/runtime"].space = space
  local function apply(f, args)
    local _g131 = stash(args)
    return(f(unpack(_g131)))
  end
  nexus["lumen/runtime"].apply = apply
  local id_count = 0
  nexus["lumen/runtime"]["id-count"] = id_count
  local function make_id()
    id_count = id_count + 1
    return("_g" .. id_count)
  end
  nexus["lumen/runtime"]["make-id"] = make_id
  local function _37message_handler(msg)
    local i = search(msg, ": ")
    return(sub(msg, i + 2))
  end
  nexus["lumen/runtime"]["%message-handler"] = _37message_handler
  local function toplevel63()
    return(one63(environment))
  end
  nexus["lumen/runtime"]["toplevel?"] = toplevel63
  local function module_key(spec)
    if atom63(spec) then
      return(string(spec))
    else
      return(reduce(function (a, b)
        return(module_key(a) .. "/" .. module_key(b))
      end, spec))
    end
  end
  nexus["lumen/runtime"]["module-key"] = module_key
  local function module(spec)
    return(modules[module_key(spec)])
  end
  nexus["lumen/runtime"].module = module
  local function setenv(k, ...)
    local _g138 = unstash({...})
    local keys = sub(_g138, 0)
    if string63(k) then
      local frame = last(environment)
      local x = frame[k] or {}
      local _g139 = keys
      local _g141 = nil
      for _g141 in next, _g139 do
        local v = _g139[_g141]
        x[_g141] = v
      end
      if toplevel63() then
        local m = module(current_module)
        m.export[k] = x
      end
      frame[k] = x
    end
  end
  nexus["lumen/runtime"].setenv = setenv
end)();
(function ()
  nexus["lumen/lib"] = {}
  local _g149 = nexus["lumen/runtime"]
  local unstash = _g149.unstash
  local char = _g149.char
  local in63 = _g149["in?"]
  local read_file = _g149["read-file"]
  local inner = _g149.inner
  local series = _g149.series
  local hd = _g149.hd
  local module_key = _g149["module-key"]
  local atom63 = _g149["atom?"]
  local string = _g149.string
  local substring = _g149.substring
  local string_literal63 = _g149["string-literal?"]
  local _43 = _g149["+"]
  local _6061 = _g149["<="]
  local _ = _g149["-"]
  local _6261 = _g149[">="]
  local map = _g149.map
  local _42 = _g149["*"]
  local one63 = _g149["one?"]
  local none63 = _g149["none?"]
  local _47 = _g149["/"]
  local split = _g149.split
  local _60 = _g149["<"]
  local _61 = _g149["="]
  local _62 = _g149[">"]
  local apply = _g149.apply
  local tl = _g149.tl
  local some63 = _g149["some?"]
  local make_id = _g149["make-id"]
  local nil63 = _g149["nil?"]
  local replicate = _g149.replicate
  local join = _g149.join
  local keys = _g149.keys
  local write = _g149.write
  local add = _g149.add
  local search = _g149.search
  local string63 = _g149["string?"]
  local toplevel63 = _g149["toplevel?"]
  local write_file = _g149["write-file"]
  local boolean63 = _g149["boolean?"]
  local iterate = _g149.iterate
  local keys63 = _g149["keys?"]
  local code = _g149.code
  local keep = _g149.keep
  local _37 = _g149["%"]
  local cat = _g149.cat
  local stash = _g149.stash
  local id_literal63 = _g149["id-literal?"]
  local pair = _g149.pair
  local function63 = _g149["function?"]
  local last = _g149.last
  local setenv = _g149.setenv
  local sort = _g149.sort
  local module = _g149.module
  local table63 = _g149["table?"]
  local _37message_handler = _g149["%message-handler"]
  local space = _g149.space
  local reduce = _g149.reduce
  local empty63 = _g149["empty?"]
  local drop = _g149.drop
  local number = _g149.number
  local now = _g149.now
  local today = _g149.today
  local exit = _g149.exit
  local is63 = _g149["is?"]
  local composite63 = _g149["composite?"]
  local length = _g149.length
  local find = _g149.find
  local number63 = _g149["number?"]
  local list63 = _g149["list?"]
  local sub = _g149.sub
  local reverse = _g149.reverse
  local function getenv(k, p)
    if string63(k) then
      local b = find(function (e)
        return(e[k])
      end, reverse(environment))
      if is63(b) then
        if p then
          return(b[p])
        else
          return(b)
        end
      end
    end
  end
  nexus["lumen/lib"].getenv = getenv
  local function macro_function(k)
    return(getenv(k, "macro"))
  end
  nexus["lumen/lib"]["macro-function"] = macro_function
  local function macro63(k)
    return(is63(macro_function(k)))
  end
  nexus["lumen/lib"]["macro?"] = macro63
  local function special63(k)
    return(is63(getenv(k, "special")))
  end
  nexus["lumen/lib"]["special?"] = special63
  local function special_form63(form)
    return(list63(form) and special63(hd(form)))
  end
  nexus["lumen/lib"]["special-form?"] = special_form63
  local function statement63(k)
    return(special63(k) and getenv(k, "stmt"))
  end
  nexus["lumen/lib"]["statement?"] = statement63
  local function symbol_expansion(k)
    return(getenv(k, "symbol"))
  end
  nexus["lumen/lib"]["symbol-expansion"] = symbol_expansion
  local function symbol63(k)
    return(is63(symbol_expansion(k)))
  end
  nexus["lumen/lib"]["symbol?"] = symbol63
  local function variable63(k)
    local b = find(function (frame)
      return(frame[k] or frame._scope)
    end, reverse(environment))
    return(table63(b) and is63(b.variable))
  end
  nexus["lumen/lib"]["variable?"] = variable63
  local function global63(k)
    return(getenv(k, "global"))
  end
  nexus["lumen/lib"]["global?"] = global63
  local function bound63(x)
    return(macro63(x) or special63(x) or symbol63(x) or variable63(x) or global63(x))
  end
  nexus["lumen/lib"]["bound?"] = bound63
  local function escape(str)
    local str1 = "\""
    local i = 0
    while i < length(str) do
      local c = char(str, i)
      local _g236
      if c == "\n" then
        _g236 = "\\n"
      else
        local _g237
        if c == "\"" then
          _g237 = "\\\""
        else
          local _g238
          if c == "\\" then
            _g238 = "\\\\"
          else
            _g238 = c
          end
          _g237 = _g238
        end
        _g236 = _g237
      end
      local c1 = _g236
      str1 = str1 .. c1
      i = i + 1
    end
    return(str1 .. "\"")
  end
  nexus["lumen/lib"].escape = escape
  local function quoted(form)
    if string63(form) then
      return(escape(form))
    else
      if atom63(form) then
        return(form)
      else
        return(join({"list"}, map(quoted, form)))
      end
    end
  end
  nexus["lumen/lib"].quoted = quoted
  local function literal(s)
    if string_literal63(s) then
      return(s)
    else
      return(quoted(s))
    end
  end
  nexus["lumen/lib"].literal = literal
  local function stash42(args)
    if keys63(args) then
      local l = {"%object", "\"_stash\"", true}
      local _g169 = args
      local k = nil
      for k in next, _g169 do
        local v = _g169[k]
        if not number63(k) then
          add(l, literal(k))
          add(l, v)
        end
      end
      return(join(args, {l}))
    else
      return(args)
    end
  end
  nexus["lumen/lib"]["stash*"] = stash42
  local function index(x)
    if number63(x) and target ~= "lua" then
      if target == "js" then
        x = x - 1
      else
        x = x + 1
      end
    end
    return(x)
  end
  nexus["lumen/lib"].index = index
  local function bind(lh, rh)
    if composite63(lh) and list63(rh) then
      local id = make_id()
      return(join({{id, rh}}, bind(lh, id)))
    else
      if atom63(lh) then
        return({{lh, rh}})
      else
        local bs = {}
        local _g173 = lh
        local k = nil
        for k in next, _g173 do
          local v = _g173[k]
          local _g239
          if k == "&" then
            _g239 = {"sub", rh, length(lh)}
          else
            _g239 = {"get", rh, {"quote", index(k)}}
          end
          local x = _g239
          local _g240
          if v == true then
            _g240 = k
          else
            _g240 = v
          end
          local _g175 = _g240
          bs = join(bs, bind(_g175, x))
        end
        return(bs)
      end
    end
  end
  nexus["lumen/lib"].bind = bind
  local function bind42(args, body)
    local args1 = {}
    local function rest()
      if target == "js" then
        return({"unstash", {{"get", {"get", {"get", "Array", {"quote", "prototype"}}, {"quote", "slice"}}, {"quote", "call"}}, "arguments", length(args1)}})
      else
        add(args1, "|...|")
        return({"unstash", {"list", "|...|"}})
      end
    end
    if atom63(args) then
      return({args1, {join({"let", {args, rest()}}, body)}})
    else
      local bs = {}
      local k63 = keys63(args)
      local r = make_id()
      local _g178 = args
      local k = nil
      for k in next, _g178 do
        local v = _g178[k]
        if number63(k) then
          if atom63(v) then
            add(args1, v)
          else
            local x = make_id()
            add(args1, x)
            bs = join(bs, {v, x})
          end
        end
      end
      if k63 then
        bs = join(bs, {r, rest()})
        bs = join(bs, {keys(args), r})
      end
      return({args1, {join({"let", bs}, body)}})
    end
  end
  nexus["lumen/lib"]["bind*"] = bind42
  local function quoting63(depth)
    return(number63(depth))
  end
  nexus["lumen/lib"]["quoting?"] = quoting63
  local function quasiquoting63(depth)
    return(quoting63(depth) and depth > 0)
  end
  nexus["lumen/lib"]["quasiquoting?"] = quasiquoting63
  local function can_unquote63(depth)
    return(quoting63(depth) and depth == 1)
  end
  nexus["lumen/lib"]["can-unquote?"] = can_unquote63
  local function quasisplice63(x, depth)
    return(list63(x) and can_unquote63(depth) and hd(x) == "unquote-splicing")
  end
  nexus["lumen/lib"]["quasisplice?"] = quasisplice63
  local function macroexpand(form)
    if symbol63(form) then
      return(macroexpand(symbol_expansion(form)))
    else
      if atom63(form) then
        return(form)
      else
        local x = hd(form)
        if x == "%local" then
          local _g146 = form[1]
          local name = form[2]
          local value = form[3]
          return({"%local", name, macroexpand(value)})
        else
          if x == "%function" then
            local _g147 = form[1]
            local args = form[2]
            local body = sub(form, 2)
            add(environment, {_scope = true})
            local _g187 = args
            local _g188 = 0
            while _g188 < length(_g187) do
              local _g185 = _g187[_g188 + 1]
              setenv(_g185, {_stash = true, variable = true})
              _g188 = _g188 + 1
            end
            local _g186 = join({"%function", args}, macroexpand(body))
            drop(environment)
            return(_g186)
          else
            if x == "%local-function" or x == "%global-function" then
              local _g148 = form[1]
              local _g189 = form[2]
              local _g190 = form[3]
              local _g191 = sub(form, 3)
              add(environment, {_scope = true})
              local _g194 = _g190
              local _g195 = 0
              while _g195 < length(_g194) do
                local _g192 = _g194[_g195 + 1]
                setenv(_g192, {_stash = true, variable = true})
                _g195 = _g195 + 1
              end
              local _g193 = join({x, _g189, _g190}, macroexpand(_g191))
              drop(environment)
              return(_g193)
            else
              if macro63(x) then
                return(macroexpand(apply(macro_function(x), tl(form))))
              else
                return(map(macroexpand, form))
              end
            end
          end
        end
      end
    end
  end
  nexus["lumen/lib"].macroexpand = macroexpand
  local quasiexpand
  nexus["lumen/lib"].quasiexpand = quasiexpand
  local quasiquote_list
  nexus["lumen/lib"]["quasiquote-list"] = quasiquote_list
  quasiquote_list = function (form, depth)
    local xs = {{"list"}}
    local _g197 = form
    local k = nil
    for k in next, _g197 do
      local v = _g197[k]
      if not number63(k) then
        local _g241
        if quasisplice63(v, depth) then
          _g241 = quasiexpand(v[2])
        else
          _g241 = quasiexpand(v, depth)
        end
        local _g199 = _g241
        last(xs)[k] = _g199
      end
    end
    series(function (x)
      if quasisplice63(x, depth) then
        local _g201 = quasiexpand(x[2])
        add(xs, _g201)
        return(add(xs, {"list"}))
      else
        return(add(last(xs), quasiexpand(x, depth)))
      end
    end, form)
    local pruned = keep(function (x)
      return(length(x) > 1 or not (hd(x) == "list") or keys63(x))
    end, xs)
    return(join({"join*"}, pruned))
  end
  nexus["lumen/lib"]["quasiquote-list"] = quasiquote_list
  quasiexpand = function (form, depth)
    if quasiquoting63(depth) then
      if atom63(form) then
        return({"quote", form})
      else
        if can_unquote63(depth) and hd(form) == "unquote" then
          return(quasiexpand(form[2]))
        else
          if hd(form) == "unquote" or hd(form) == "unquote-splicing" then
            return(quasiquote_list(form, depth - 1))
          else
            if hd(form) == "quasiquote" then
              return(quasiquote_list(form, depth + 1))
            else
              return(quasiquote_list(form, depth))
            end
          end
        end
      end
    else
      if atom63(form) then
        return(form)
      else
        if hd(form) == "quote" then
          return(form)
        else
          if hd(form) == "quasiquote" then
            return(quasiexpand(form[2], 1))
          else
            return(map(function (x)
              return(quasiexpand(x, depth))
            end, form))
          end
        end
      end
    end
  end
  nexus["lumen/lib"].quasiexpand = quasiexpand
  indent_level = 0
  local function indentation()
    return(apply(cat, replicate(indent_level, "  ")))
  end
  nexus["lumen/lib"].indentation = indentation
  local reserved = {[">"] = true, ["with"] = true, ["+"] = true, ["var"] = true, ["-"] = true, ["/"] = true, ["try"] = true, ["delete"] = true, ["continue"] = true, ["return"] = true, ["false"] = true, ["do"] = true, ["finally"] = true, ["typeof"] = true, ["new"] = true, [">="] = true, ["then"] = true, ["<="] = true, ["for"] = true, ["and"] = true, ["catch"] = true, ["%"] = true, ["case"] = true, ["*"] = true, ["or"] = true, ["if"] = true, ["function"] = true, ["in"] = true, ["true"] = true, ["nil"] = true, ["default"] = true, ["switch"] = true, ["end"] = true, ["void"] = true, ["else"] = true, ["until"] = true, ["local"] = true, ["while"] = true, ["repeat"] = true, ["="] = true, ["not"] = true, ["throw"] = true, ["this"] = true, ["instanceof"] = true, ["=="] = true, ["<"] = true, ["break"] = true, ["debugger"] = true, ["elseif"] = true}
  nexus["lumen/lib"].reserved = reserved
  local function reserved63(x)
    return(reserved[x])
  end
  nexus["lumen/lib"]["reserved?"] = reserved63
  local function numeric63(n)
    return(n > 47 and n < 58)
  end
  nexus["lumen/lib"]["numeric?"] = numeric63
  local function valid_code63(n)
    return(numeric63(n) or n > 64 and n < 91 or n > 96 and n < 123 or n == 95)
  end
  nexus["lumen/lib"]["valid-code?"] = valid_code63
  local function valid_id63(id)
    if none63(id) or reserved63(id) then
      return(false)
    else
      local i = 0
      while i < length(id) do
        if not valid_code63(code(id, i)) then
          return(false)
        end
        i = i + 1
      end
      return(true)
    end
  end
  nexus["lumen/lib"]["valid-id?"] = valid_id63
  local function id(id)
    local id1 = ""
    local i = 0
    while i < length(id) do
      local c = char(id, i)
      local n = code(c)
      local _g242
      if c == "-" then
        _g242 = "_"
      else
        local _g243
        if valid_code63(n) then
          _g243 = c
        else
          local _g244
          if i == 0 then
            _g244 = "_" .. n
          else
            _g244 = n
          end
          _g243 = _g244
        end
        _g242 = _g243
      end
      local c1 = _g242
      id1 = id1 .. c1
      i = i + 1
    end
    return(id1)
  end
  nexus["lumen/lib"].id = id
  local function key(k)
    local function wrap(s)
      if target == "lua" then
        return("[" .. s .. "]")
      else
        return(s)
      end
    end
    local i = inner(k)
    if valid_id63(i) then
      return(i)
    else
      return(wrap(k))
    end
  end
  nexus["lumen/lib"].key = key
  local function imported(spec, ...)
    local _g218 = unstash({...})
    local _g219 = _g218.all
    local m = make_id()
    local k = module_key(spec)
    local imports = {}
    if nexus[k] then
      local _g220 = module(spec).export
      local n = nil
      for n in next, _g220 do
        if not number63(n) then
          local b = _g220[n]
          if b.variable and (_g219 or b.export) then
            add(imports, {"%local", n, {"get", m, {"quote", n}}})
          end
        end
      end
    end
    if some63(imports) then
      return(join({{"%local", m, {"get", "nexus", {"quote", k}}}}, imports))
    end
  end
  nexus["lumen/lib"].imported = imported
  local function link(name, form)
    if toplevel63() then
      local k = module_key(current_module)
      return({"do", form, {"set", {"get", {"get", "nexus", {"quote", k}}, {"quote", name}}, name}})
    else
      return(form)
    end
  end
  nexus["lumen/lib"].link = link
  local function extend(t, ...)
    local _g222 = unstash({...})
    local xs = sub(_g222, 0)
    return(join(t, xs))
  end
  nexus["lumen/lib"].extend = extend
  local function exclude(t, ...)
    local _g223 = unstash({...})
    local keys = sub(_g223, 0)
    local t1 = {}
    local _g224 = t
    local k = nil
    for k in next, _g224 do
      local v = _g224[k]
      if not keys[k] then
        t1[k] = v
      end
    end
    return(t1)
  end
  nexus["lumen/lib"].exclude = exclude
  local function quote_binding(b)
    if is63(b.symbol) then
      return(extend(b, {_stash = true, symbol = {"quote", b.symbol}}))
    else
      if b.macro and b.form then
        return(exclude(extend(b, {_stash = true, macro = b.form}), {_stash = true, form = true}))
      else
        if b.special and b.form then
          return(exclude(extend(b, {_stash = true, special = b.form}), {_stash = true, form = true}))
        else
          if is63(b.variable) then
            return(b)
          else
            if is63(b.global) then
              return(b)
            end
          end
        end
      end
    end
  end
  nexus["lumen/lib"]["quote-binding"] = quote_binding
  local function mapo(f, t)
    local o = {}
    local _g228 = t
    local k = nil
    for k in next, _g228 do
      if not number63(k) then
        local v = _g228[k]
        local x = f(v)
        if is63(x) then
          add(o, literal(k))
          add(o, x)
        end
      end
    end
    return(o)
  end
  nexus["lumen/lib"].mapo = mapo
  local function quote_frame(t)
    return(join({"%object"}, mapo(function (b)
      return(join({"table"}, quote_binding(b)))
    end, t)))
  end
  nexus["lumen/lib"]["quote-frame"] = quote_frame
  local function quote_environment(env)
    return(join({"list"}, map(quote_frame, env)))
  end
  nexus["lumen/lib"]["quote-environment"] = quote_environment
  local function quote_module(m)
    local _g233 = {"table"}
    _g233.export = quote_frame(m.export)
    _g233.import = quoted(m.import)
    _g233.alias = quoted(m.alias)
    return(_g233)
  end
  nexus["lumen/lib"]["quote-module"] = quote_module
  local function quote_modules()
    return(join({"table"}, map(quote_module, modules)))
  end
  nexus["lumen/lib"]["quote-modules"] = quote_modules
  local function initial_environment()
    return({{["define-module"] = getenv("define-module")}})
  end
  nexus["lumen/lib"]["initial-environment"] = initial_environment
end)();
(function ()
  nexus["lumen/reader"] = {}
  local _g245 = nexus["lumen/runtime"]
  local unstash = _g245.unstash
  local char = _g245.char
  local in63 = _g245["in?"]
  local read_file = _g245["read-file"]
  local inner = _g245.inner
  local series = _g245.series
  local hd = _g245.hd
  local module_key = _g245["module-key"]
  local atom63 = _g245["atom?"]
  local string = _g245.string
  local substring = _g245.substring
  local string_literal63 = _g245["string-literal?"]
  local _43 = _g245["+"]
  local _6061 = _g245["<="]
  local _ = _g245["-"]
  local _6261 = _g245[">="]
  local map = _g245.map
  local _42 = _g245["*"]
  local one63 = _g245["one?"]
  local none63 = _g245["none?"]
  local _47 = _g245["/"]
  local split = _g245.split
  local _60 = _g245["<"]
  local _61 = _g245["="]
  local _62 = _g245[">"]
  local apply = _g245.apply
  local tl = _g245.tl
  local some63 = _g245["some?"]
  local make_id = _g245["make-id"]
  local nil63 = _g245["nil?"]
  local replicate = _g245.replicate
  local join = _g245.join
  local keys = _g245.keys
  local write = _g245.write
  local add = _g245.add
  local search = _g245.search
  local string63 = _g245["string?"]
  local toplevel63 = _g245["toplevel?"]
  local write_file = _g245["write-file"]
  local boolean63 = _g245["boolean?"]
  local iterate = _g245.iterate
  local keys63 = _g245["keys?"]
  local code = _g245.code
  local keep = _g245.keep
  local _37 = _g245["%"]
  local cat = _g245.cat
  local stash = _g245.stash
  local id_literal63 = _g245["id-literal?"]
  local pair = _g245.pair
  local function63 = _g245["function?"]
  local last = _g245.last
  local setenv = _g245.setenv
  local sort = _g245.sort
  local module = _g245.module
  local table63 = _g245["table?"]
  local _37message_handler = _g245["%message-handler"]
  local space = _g245.space
  local reduce = _g245.reduce
  local empty63 = _g245["empty?"]
  local drop = _g245.drop
  local number = _g245.number
  local now = _g245.now
  local today = _g245.today
  local exit = _g245.exit
  local is63 = _g245["is?"]
  local composite63 = _g245["composite?"]
  local length = _g245.length
  local find = _g245.find
  local number63 = _g245["number?"]
  local list63 = _g245["list?"]
  local sub = _g245.sub
  local reverse = _g245.reverse
  local delimiters = {["("] = true, [")"] = true, [";"] = true, ["\n"] = true}
  nexus["lumen/reader"].delimiters = delimiters
  local whitespace = {["\n"] = true, [" "] = true, ["\t"] = true}
  nexus["lumen/reader"].whitespace = whitespace
  local function make_stream(str)
    return({pos = 0, string = str, len = length(str)})
  end
  nexus["lumen/reader"]["make-stream"] = make_stream
  local function peek_char(s)
    if s.pos < s.len then
      return(char(s.string, s.pos))
    end
  end
  nexus["lumen/reader"]["peek-char"] = peek_char
  local function read_char(s)
    local c = peek_char(s)
    if c then
      s.pos = s.pos + 1
      return(c)
    end
  end
  nexus["lumen/reader"]["read-char"] = read_char
  local function skip_non_code(s)
    while true do
      local c = peek_char(s)
      if nil63(c) then
        break
      else
        if whitespace[c] then
          read_char(s)
        else
          if c == ";" then
            while c and not (c == "\n") do
              c = read_char(s)
            end
            skip_non_code(s)
          else
            break
          end
        end
      end
    end
  end
  nexus["lumen/reader"]["skip-non-code"] = skip_non_code
  local read_table = {}
  nexus["lumen/reader"]["read-table"] = read_table
  local eof = {}
  nexus["lumen/reader"].eof = eof
  local function read(s)
    skip_non_code(s)
    local c = peek_char(s)
    if is63(c) then
      return((read_table[c] or read_table[""])(s))
    else
      return(eof)
    end
  end
  nexus["lumen/reader"].read = read
  local function read_all(s)
    local l = {}
    while true do
      local form = read(s)
      if form == eof then
        break
      end
      add(l, form)
    end
    return(l)
  end
  nexus["lumen/reader"]["read-all"] = read_all
  local function read_from_string(str)
    local x = read(make_stream(str))
    if x ~= eof then
      return(x)
    end
  end
  nexus["lumen/reader"]["read-from-string"] = read_from_string
  local function key63(atom)
    return(string63(atom) and length(atom) > 1 and char(atom, length(atom) - 1) == ":")
  end
  nexus["lumen/reader"]["key?"] = key63
  local function flag63(atom)
    return(string63(atom) and length(atom) > 1 and char(atom, 0) == ":")
  end
  nexus["lumen/reader"]["flag?"] = flag63
  read_table[""] = function (s)
    local str = ""
    local dot63 = false
    while true do
      local c = peek_char(s)
      if c and (not whitespace[c] and not delimiters[c]) then
        if c == "." then
          dot63 = true
        end
        str = str .. c
        read_char(s)
      else
        break
      end
    end
    local n = number(str)
    if is63(n) then
      return(n)
    else
      if str == "true" then
        return(true)
      else
        if str == "false" then
          return(false)
        else
          if str == "_" then
            return(make_id())
          else
            if dot63 and not one63(str) then
              return(reduce(function (a, b)
                return({"get", b, {"quote", a}})
              end, reverse(split(str, "."))))
            else
              return(str)
            end
          end
        end
      end
    end
  end
  read_table["("] = function (s)
    read_char(s)
    local l = {}
    while true do
      skip_non_code(s)
      local c = peek_char(s)
      if c and not (c == ")") then
        local x = read(s)
        if key63(x) then
          local k = sub(x, 0, length(x) - 1)
          local v = read(s)
          l[k] = v
        else
          if flag63(x) then
            l[sub(x, 1)] = true
          else
            add(l, x)
          end
        end
      else
        if c then
          read_char(s)
          break
        else
          error("Expected ) at " .. s.pos)
        end
      end
    end
    return(l)
  end
  read_table[")"] = function (s)
    error("Unexpected ) at " .. s.pos)
  end
  read_table["\""] = function (s)
    read_char(s)
    local str = "\""
    while true do
      local c = peek_char(s)
      if c and not (c == "\"") then
        if c == "\\" then
          str = str .. read_char(s)
        end
        str = str .. read_char(s)
      else
        if c then
          read_char(s)
          break
        else
          error("Expected \" at " .. s.pos)
        end
      end
    end
    return(str .. "\"")
  end
  read_table["|"] = function (s)
    read_char(s)
    local str = "|"
    while true do
      local c = peek_char(s)
      if c and not (c == "|") then
        str = str .. read_char(s)
      else
        if c then
          read_char(s)
          break
        else
          error("Expected | at " .. s.pos)
        end
      end
    end
    return(str .. "|")
  end
  read_table["'"] = function (s)
    read_char(s)
    return({"quote", read(s)})
  end
  read_table["`"] = function (s)
    read_char(s)
    return({"quasiquote", read(s)})
  end
  read_table[","] = function (s)
    read_char(s)
    if peek_char(s) == "@" then
      read_char(s)
      return({"unquote-splicing", read(s)})
    else
      return({"unquote", read(s)})
    end
  end
end)();
(function ()
  nexus["lumen/compiler"] = {}
  local _g274 = nexus["lumen/runtime"]
  local unstash = _g274.unstash
  local char = _g274.char
  local in63 = _g274["in?"]
  local read_file = _g274["read-file"]
  local inner = _g274.inner
  local series = _g274.series
  local hd = _g274.hd
  local module_key = _g274["module-key"]
  local atom63 = _g274["atom?"]
  local string = _g274.string
  local substring = _g274.substring
  local string_literal63 = _g274["string-literal?"]
  local _43 = _g274["+"]
  local _6061 = _g274["<="]
  local _ = _g274["-"]
  local _6261 = _g274[">="]
  local map = _g274.map
  local _42 = _g274["*"]
  local one63 = _g274["one?"]
  local none63 = _g274["none?"]
  local _47 = _g274["/"]
  local split = _g274.split
  local _60 = _g274["<"]
  local _61 = _g274["="]
  local _62 = _g274[">"]
  local apply = _g274.apply
  local tl = _g274.tl
  local some63 = _g274["some?"]
  local make_id = _g274["make-id"]
  local nil63 = _g274["nil?"]
  local replicate = _g274.replicate
  local join = _g274.join
  local keys = _g274.keys
  local write = _g274.write
  local add = _g274.add
  local search = _g274.search
  local string63 = _g274["string?"]
  local toplevel63 = _g274["toplevel?"]
  local write_file = _g274["write-file"]
  local boolean63 = _g274["boolean?"]
  local iterate = _g274.iterate
  local keys63 = _g274["keys?"]
  local code = _g274.code
  local keep = _g274.keep
  local _37 = _g274["%"]
  local cat = _g274.cat
  local stash = _g274.stash
  local id_literal63 = _g274["id-literal?"]
  local pair = _g274.pair
  local function63 = _g274["function?"]
  local last = _g274.last
  local setenv = _g274.setenv
  local sort = _g274.sort
  local module = _g274.module
  local table63 = _g274["table?"]
  local _37message_handler = _g274["%message-handler"]
  local space = _g274.space
  local reduce = _g274.reduce
  local empty63 = _g274["empty?"]
  local drop = _g274.drop
  local number = _g274.number
  local now = _g274.now
  local today = _g274.today
  local exit = _g274.exit
  local is63 = _g274["is?"]
  local composite63 = _g274["composite?"]
  local length = _g274.length
  local find = _g274.find
  local number63 = _g274["number?"]
  local list63 = _g274["list?"]
  local sub = _g274.sub
  local reverse = _g274.reverse
  local _g277 = nexus["lumen/lib"]
  local quote_modules = _g277["quote-modules"]
  local getenv = _g277.getenv
  local link = _g277.link
  local bind = _g277.bind
  local initial_environment = _g277["initial-environment"]
  local id = _g277.id
  local valid_id63 = _g277["valid-id?"]
  local mapo = _g277.mapo
  local imported = _g277.imported
  local variable63 = _g277["variable?"]
  local quote_environment = _g277["quote-environment"]
  local stash42 = _g277["stash*"]
  local quoted = _g277.quoted
  local symbol63 = _g277["symbol?"]
  local macro63 = _g277["macro?"]
  local reserved63 = _g277["reserved?"]
  local quasiexpand = _g277.quasiexpand
  local macroexpand = _g277.macroexpand
  local macro_function = _g277["macro-function"]
  local bind42 = _g277["bind*"]
  local bound63 = _g277["bound?"]
  local special63 = _g277["special?"]
  local special_form63 = _g277["special-form?"]
  local key = _g277.key
  local symbol_expansion = _g277["symbol-expansion"]
  local statement63 = _g277["statement?"]
  local indentation = _g277.indentation
  local _g278 = nexus["lumen/reader"]
  local read_from_string = _g278["read-from-string"]
  local read_table = _g278["read-table"]
  local read = _g278.read
  local read_all = _g278["read-all"]
  local make_stream = _g278["make-stream"]
  local _g282 = {}
  _g282.lua = "not "
  _g282.js = "!"
  local _g280 = {}
  local _g283 = {}
  _g283.lua = "not "
  _g283.js = "!"
  _g280["not"] = _g283
  local _g285 = {}
  _g285["/"] = true
  _g285["%"] = true
  _g285["*"] = true
  local _g287 = {}
  _g287["+"] = true
  _g287["-"] = true
  local _g291 = {}
  _g291.lua = ".."
  _g291.js = "+"
  local _g289 = {}
  local _g292 = {}
  _g292.lua = ".."
  _g292.js = "+"
  _g289.cat = _g292
  local _g294 = {}
  _g294["<"] = true
  _g294["<="] = true
  _g294[">"] = true
  _g294[">="] = true
  local _g298 = {}
  _g298.lua = "=="
  _g298.js = "==="
  local _g300 = {}
  _g300.lua = "~="
  _g300.js = "!="
  local _g296 = {}
  local _g301 = {}
  _g301.lua = "=="
  _g301.js = "==="
  _g296["="] = _g301
  local _g302 = {}
  _g302.lua = "~="
  _g302.js = "!="
  _g296["~="] = _g302
  local _g306 = {}
  _g306.lua = "and"
  _g306.js = "&&"
  local _g304 = {}
  local _g307 = {}
  _g307.lua = "and"
  _g307.js = "&&"
  _g304["and"] = _g307
  local _g311 = {}
  _g311.lua = "or"
  _g311.js = "||"
  local _g309 = {}
  local _g312 = {}
  _g312.lua = "or"
  _g312.js = "||"
  _g309["or"] = _g312
  local infix = {_g280, _g285, _g287, _g289, _g294, _g296, _g304, _g309}
  nexus["lumen/compiler"].infix = infix
  local function unary63(form)
    local op = form[1]
    local args = sub(form, 1)
    return(one63(args) and in63(op, {"not", "-"}))
  end
  nexus["lumen/compiler"]["unary?"] = unary63
  local function precedence(form)
    if list63(form) and not unary63(form) then
      local _g315 = infix
      local i = 0
      while i < length(_g315) do
        local level = _g315[i + 1]
        if level[hd(form)] then
          return(i)
        end
        i = i + 1
      end
    end
    return(0)
  end
  nexus["lumen/compiler"].precedence = precedence
  local function getop(op)
    return(find(function (level)
      local x = level[op]
      if x == true then
        return(op)
      else
        if is63(x) then
          return(x[target])
        end
      end
    end, infix))
  end
  nexus["lumen/compiler"].getop = getop
  local function infix63(x)
    return(is63(getop(x)))
  end
  nexus["lumen/compiler"]["infix?"] = infix63
  local compile
  nexus["lumen/compiler"].compile = compile
  local function compile_args(args)
    local str = "("
    local _g320 = args
    local i = 0
    while i < length(_g320) do
      local arg = _g320[i + 1]
      str = str .. compile(arg)
      if i < length(args) - 1 then
        str = str .. ", "
      end
      i = i + 1
    end
    return(str .. ")")
  end
  nexus["lumen/compiler"]["compile-args"] = compile_args
  local function compile_atom(x)
    if x == "nil" and target == "lua" then
      return(x)
    else
      if x == "nil" then
        return("undefined")
      else
        if id_literal63(x) then
          return(inner(x))
        else
          if string_literal63(x) then
            return(x)
          else
            if string63(x) then
              return(id(x))
            else
              if boolean63(x) then
                if x then
                  return("true")
                else
                  return("false")
                end
              else
                if number63(x) then
                  return(x .. "")
                else
                  error("Cannot compile atom: " .. string(x))
                end
              end
            end
          end
        end
      end
    end
  end
  nexus["lumen/compiler"]["compile-atom"] = compile_atom
  local function terminator(stmt63)
    if not stmt63 then
      return("")
    else
      if target == "js" then
        return(";\n")
      else
        return("\n")
      end
    end
  end
  nexus["lumen/compiler"].terminator = terminator
  local function compile_special(form, stmt63)
    local x = form[1]
    local args = sub(form, 1)
    local _g324 = getenv(x)
    local special = _g324.special
    local self_tr63 = _g324.tr
    local stmt = _g324.stmt
    local tr = terminator(stmt63 and not self_tr63)
    return(apply(special, args) .. tr)
  end
  nexus["lumen/compiler"]["compile-special"] = compile_special
  local function parenthesize_call63(x)
    return(list63(x) and (hd(x) == "%function" or precedence(x) > 0))
  end
  nexus["lumen/compiler"]["parenthesize-call?"] = parenthesize_call63
  local function compile_call(form)
    local f = hd(form)
    local f1 = compile(f)
    local args = compile_args(stash42(tl(form)))
    if parenthesize_call63(f) then
      return("(" .. f1 .. ")" .. args)
    else
      return(f1 .. args)
    end
  end
  nexus["lumen/compiler"]["compile-call"] = compile_call
  local function op_delims(parent, child, ...)
    local _g327 = unstash({...})
    local right = _g327.right
    local _g389
    if right then
      _g389 = _6261
    else
      _g389 = _62
    end
    if _g389(precedence(child), precedence(parent)) then
      return({"(", ")"})
    else
      return({"", ""})
    end
  end
  nexus["lumen/compiler"]["op-delims"] = op_delims
  local function compile_infix(form)
    local op = form[1]
    local _g329 = sub(form, 1)
    local a = _g329[1]
    local b = _g329[2]
    local _g330 = op_delims(form, a)
    local ao = _g330[1]
    local ac = _g330[2]
    local _g331 = op_delims(form, b, {_stash = true, right = true})
    local bo = _g331[1]
    local bc = _g331[2]
    local _g332 = compile(a)
    local _g333 = compile(b)
    local _g334 = getop(op)
    if unary63(form) then
      return(_g334 .. ao .. _g332 .. ac)
    else
      return(ao .. _g332 .. ac .. " " .. _g334 .. " " .. bo .. _g333 .. bc)
    end
  end
  nexus["lumen/compiler"]["compile-infix"] = compile_infix
  local function compile_function(args, body, ...)
    local _g335 = unstash({...})
    local name = _g335.name
    local prefix = _g335.prefix
    local _g390
    if name then
      _g390 = compile(name)
    else
      _g390 = ""
    end
    local id = _g390
    local _g336 = prefix or ""
    local _g337 = compile_args(args)
    indent_level = indent_level + 1
    local _g339 = compile(body, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local _g338 = _g339
    local ind = indentation()
    local _g391
    if target == "js" then
      _g391 = ""
    else
      _g391 = "end"
    end
    local tr = _g391
    if name then
      tr = tr .. "\n"
    end
    if target == "js" then
      return("function " .. id .. _g337 .. " {\n" .. _g338 .. ind .. "}" .. tr)
    else
      return(_g336 .. "function " .. id .. _g337 .. "\n" .. _g338 .. ind .. tr)
    end
  end
  nexus["lumen/compiler"]["compile-function"] = compile_function
  local function can_return63(form)
    return(is63(form) and (atom63(form) or not (hd(form) == "return") and not statement63(hd(form))))
  end
  nexus["lumen/compiler"]["can-return?"] = can_return63
  compile = function (form, ...)
    local _g341 = unstash({...})
    local stmt = _g341.stmt
    if nil63(form) then
      return("")
    else
      if special_form63(form) then
        return(compile_special(form, stmt))
      else
        local tr = terminator(stmt)
        local _g392
        if stmt then
          _g392 = indentation()
        else
          _g392 = ""
        end
        local ind = _g392
        local _g393
        if atom63(form) then
          _g393 = compile_atom(form)
        else
          local _g394
          if infix63(hd(form)) then
            _g394 = compile_infix(form)
          else
            _g394 = compile_call(form)
          end
          _g393 = _g394
        end
        local _g342 = _g393
        return(ind .. _g342 .. tr)
      end
    end
  end
  nexus["lumen/compiler"].compile = compile
  local lower
  nexus["lumen/compiler"].lower = lower
  local function lower_statement(form, tail63)
    local hoist = {}
    local e = lower(form, hoist, true, tail63)
    if some63(hoist) and is63(e) then
      return(join({"do"}, join(hoist, {e})))
    else
      if is63(e) then
        return(e)
      else
        if length(hoist) > 1 then
          return(join({"do"}, hoist))
        else
          return(hd(hoist))
        end
      end
    end
  end
  nexus["lumen/compiler"]["lower-statement"] = lower_statement
  local function lower_body(body, tail63)
    return(lower_statement(join({"do"}, body), tail63))
  end
  nexus["lumen/compiler"]["lower-body"] = lower_body
  local function lower_do(args, hoist, stmt63, tail63)
    local _g346 = sub(args, 0, length(args) - 1)
    local _g347 = 0
    while _g347 < length(_g346) do
      local x = _g346[_g347 + 1]
      add(hoist, lower(x, hoist, stmt63))
      _g347 = _g347 + 1
    end
    local e = lower(last(args), hoist, stmt63, tail63)
    if tail63 and can_return63(e) then
      return({"return", e})
    else
      return(e)
    end
  end
  nexus["lumen/compiler"]["lower-do"] = lower_do
  local function lower_if(args, hoist, stmt63, tail63)
    local cond = args[1]
    local _g349 = args[2]
    local _g350 = args[3]
    if stmt63 or tail63 then
      local _g396
      if _g350 then
        _g396 = {lower_body({_g350}, tail63)}
      end
      return(add(hoist, join({"%if", lower(cond, hoist), lower_body({_g349}, tail63)}, _g396)))
    else
      local e = make_id()
      add(hoist, {"%local", e})
      local _g395
      if _g350 then
        _g395 = {lower({"set", e, _g350})}
      end
      add(hoist, join({"%if", lower(cond, hoist), lower({"set", e, _g349})}, _g395))
      return(e)
    end
  end
  nexus["lumen/compiler"]["lower-if"] = lower_if
  local function lower_short(x, args, hoist)
    local a = args[1]
    local b = args[2]
    local hoist1 = {}
    local b1 = lower(b, hoist1)
    if some63(hoist1) then
      local id = make_id()
      local _g397
      if x == "and" then
        _g397 = {"%if", id, b, id}
      else
        _g397 = {"%if", id, id, b}
      end
      return(lower({"do", {"%local", id, a}, _g397}, hoist))
    else
      return({x, lower(a, hoist), b1})
    end
  end
  nexus["lumen/compiler"]["lower-short"] = lower_short
  local function lower_try(args, hoist, tail63)
    return(add(hoist, {"%try", lower_body(args, tail63)}))
  end
  nexus["lumen/compiler"]["lower-try"] = lower_try
  local function lower_while(args, hoist)
    local c = args[1]
    local body = sub(args, 1)
    return(add(hoist, {"while", lower(c, hoist), lower_body(body)}))
  end
  nexus["lumen/compiler"]["lower-while"] = lower_while
  local function lower_for(args, hoist)
    local t = args[1]
    local k = args[2]
    local body = sub(args, 2)
    return(add(hoist, {"%for", lower(t, hoist), k, lower_body(body)}))
  end
  nexus["lumen/compiler"]["lower-for"] = lower_for
  local function lower_function(args)
    local a = args[1]
    local body = sub(args, 1)
    return({"%function", a, lower_body(body, true)})
  end
  nexus["lumen/compiler"]["lower-function"] = lower_function
  local function lower_definition(kind, args, hoist)
    local name = args[1]
    local _g357 = args[2]
    local body = sub(args, 2)
    return(add(hoist, {kind, name, _g357, lower_body(body, true)}))
  end
  nexus["lumen/compiler"]["lower-definition"] = lower_definition
  local function lower_call(form, hoist)
    local _g359 = map(function (x)
      return(lower(x, hoist))
    end, form)
    if some63(_g359) then
      return(_g359)
    end
  end
  nexus["lumen/compiler"]["lower-call"] = lower_call
  local function lower_infix63(form)
    return(infix63(hd(form)) and length(form) > 3)
  end
  nexus["lumen/compiler"]["lower-infix?"] = lower_infix63
  local function lower_infix(form, hoist)
    local x = form[1]
    local args = sub(form, 1)
    return(lower(reduce(function (a, b)
      return({x, b, a})
    end, reverse(args)), hoist))
  end
  nexus["lumen/compiler"]["lower-infix"] = lower_infix
  local function lower_special(form, hoist)
    local e = lower_call(form, hoist)
    if e then
      return(add(hoist, e))
    end
  end
  nexus["lumen/compiler"]["lower-special"] = lower_special
  lower = function (form, hoist, stmt63, tail63)
    if atom63(form) then
      return(form)
    else
      if empty63(form) then
        return({"%array"})
      else
        if nil63(hoist) then
          return(lower_statement(form))
        else
          if lower_infix63(form) then
            return(lower_infix(form, hoist))
          else
            local x = form[1]
            local args = sub(form, 1)
            if x == "do" then
              return(lower_do(args, hoist, stmt63, tail63))
            else
              if x == "%if" then
                return(lower_if(args, hoist, stmt63, tail63))
              else
                if x == "%try" then
                  return(lower_try(args, hoist, tail63))
                else
                  if x == "while" then
                    return(lower_while(args, hoist))
                  else
                    if x == "%for" then
                      return(lower_for(args, hoist))
                    else
                      if x == "%function" then
                        return(lower_function(args))
                      else
                        if in63(x, {"%local-function", "%global-function"}) then
                          return(lower_definition(x, args, hoist))
                        else
                          if in63(x, {"and", "or"}) then
                            return(lower_short(x, args, hoist))
                          else
                            if statement63(x) then
                              return(lower_special(form, hoist))
                            else
                              return(lower_call(form, hoist))
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  nexus["lumen/compiler"].lower = lower
  local function process(form)
    return(lower(macroexpand(form)))
  end
  nexus["lumen/compiler"].process = process
  current_module = nil
  local function module_path(spec)
    return(module_key(spec) .. ".l")
  end
  nexus["lumen/compiler"]["module-path"] = module_path
  local function encapsulate(body)
    return({{"%function", {}, process(join({"do"}, body))}})
  end
  nexus["lumen/compiler"].encapsulate = encapsulate
  local function compile_file(file)
    local str = read_file(file)
    local body = read_all(make_stream(str))
    local form = encapsulate(body)
    return(compile(form) .. ";\n")
  end
  nexus["lumen/compiler"]["compile-file"] = compile_file
  local function run(code)
    local f,e = load(code)
    if f then
      return(f())
    else
      error(e .. " in " .. code)
    end
  end
  nexus["lumen/compiler"].run = run
  local compiling63 = false
  nexus["lumen/compiler"]["compiling?"] = compiling63
  local compiler_output = ""
  nexus["lumen/compiler"]["compiler-output"] = compiler_output
  local function conclude(code)
    if compiling63 then
      compiler_output = compiler_output .. code
    else
      return(run(code))
    end
  end
  nexus["lumen/compiler"].conclude = conclude
  local function _37compile_module(spec)
    local path = module_path(spec)
    local mod0 = current_module
    local env0 = environment
    current_module = spec
    environment = initial_environment()
    local code = compile_file(path)
    current_module = mod0
    environment = env0
    return(conclude(code))
  end
  nexus["lumen/compiler"]["%compile-module"] = _37compile_module
  local function open_module(spec, ...)
    local _g373 = unstash({...})
    local _g374 = _g373.all
    local m = module(spec)
    local frame = last(environment)
    local _g375 = m.export
    local k = nil
    for k in next, _g375 do
      if not number63(k) then
        local v = _g375[k]
        if v.export or _g374 then
          frame[k] = v
        end
      end
    end
  end
  nexus["lumen/compiler"]["open-module"] = open_module
  local function load_module(spec, ...)
    local _g376 = unstash({...})
    local _g377 = _g376.all
    if not module(spec) then
      _37compile_module(spec)
    end
    return(open_module(spec, {_stash = true, all = _g377}))
  end
  nexus["lumen/compiler"]["load-module"] = load_module
  local function in_module(spec)
    load_module(spec, {_stash = true, all = true})
    local m = module(spec)
    series(open_module, m.import)
    current_module = spec
  end
  nexus["lumen/compiler"]["in-module"] = in_module
  local function import_modules(specs)
    local imports = {}
    local bindings = {}
    local _g380 = specs or {}
    local _g381 = 0
    while _g381 < length(_g380) do
      local spec = _g380[_g381 + 1]
      load_module(spec)
      local m = module(spec)
      if m.alias then
        local _g382 = import_modules(m.alias)
        local aliased = _g382[1]
        local bs = _g382[2]
        imports = join(imports, aliased)
        bindings = join(bindings, bs)
      else
        local _g383 = imported(spec)
        add(imports, spec)
        bindings = join(bindings, _g383)
      end
      _g381 = _g381 + 1
    end
    return({imports, bindings})
  end
  nexus["lumen/compiler"]["import-modules"] = import_modules
  local function compile_module(spec)
    compiling63 = true
    _37compile_module(spec)
    return(compiler_output)
  end
  nexus["lumen/compiler"]["compile-module"] = compile_module
  local function declare(form)
    return(conclude(compile(process(form), {_stash = true, stmt = true})))
  end
  nexus["lumen/compiler"].declare = declare
  local function reimported()
    local imports = {}
    local m = module(current_module)
    series(function (spec)
      imports = join(imports, imported(spec))
    end, m.import)
    return(join(imports, imported(current_module, {_stash = true, all = true})))
  end
  nexus["lumen/compiler"].reimported = reimported
  _37result = nil
  local function eval(form)
    local previous = target
    target = "lua"
    local body = join(reimported(), {{"set", "%result", form}})
    local code = compile(encapsulate(body))
    target = previous
    run(code)
    return(_37result)
  end
  nexus["lumen/compiler"].eval = eval
end)();
(function ()
  nexus["lumen/special"] = {}
  local _g398 = nexus["lumen/runtime"]
  local unstash = _g398.unstash
  local char = _g398.char
  local in63 = _g398["in?"]
  local read_file = _g398["read-file"]
  local inner = _g398.inner
  local series = _g398.series
  local hd = _g398.hd
  local module_key = _g398["module-key"]
  local atom63 = _g398["atom?"]
  local string = _g398.string
  local substring = _g398.substring
  local string_literal63 = _g398["string-literal?"]
  local _43 = _g398["+"]
  local _6061 = _g398["<="]
  local _ = _g398["-"]
  local _6261 = _g398[">="]
  local map = _g398.map
  local _42 = _g398["*"]
  local one63 = _g398["one?"]
  local none63 = _g398["none?"]
  local _47 = _g398["/"]
  local split = _g398.split
  local _60 = _g398["<"]
  local _61 = _g398["="]
  local _62 = _g398[">"]
  local apply = _g398.apply
  local tl = _g398.tl
  local some63 = _g398["some?"]
  local make_id = _g398["make-id"]
  local nil63 = _g398["nil?"]
  local replicate = _g398.replicate
  local join = _g398.join
  local keys = _g398.keys
  local write = _g398.write
  local add = _g398.add
  local search = _g398.search
  local string63 = _g398["string?"]
  local toplevel63 = _g398["toplevel?"]
  local write_file = _g398["write-file"]
  local boolean63 = _g398["boolean?"]
  local iterate = _g398.iterate
  local keys63 = _g398["keys?"]
  local code = _g398.code
  local keep = _g398.keep
  local _37 = _g398["%"]
  local cat = _g398.cat
  local stash = _g398.stash
  local id_literal63 = _g398["id-literal?"]
  local pair = _g398.pair
  local function63 = _g398["function?"]
  local last = _g398.last
  local setenv = _g398.setenv
  local sort = _g398.sort
  local module = _g398.module
  local table63 = _g398["table?"]
  local _37message_handler = _g398["%message-handler"]
  local space = _g398.space
  local reduce = _g398.reduce
  local empty63 = _g398["empty?"]
  local drop = _g398.drop
  local number = _g398.number
  local now = _g398.now
  local today = _g398.today
  local exit = _g398.exit
  local is63 = _g398["is?"]
  local composite63 = _g398["composite?"]
  local length = _g398.length
  local find = _g398.find
  local number63 = _g398["number?"]
  local list63 = _g398["list?"]
  local sub = _g398.sub
  local reverse = _g398.reverse
  local _g401 = nexus["lumen/lib"]
  local quote_modules = _g401["quote-modules"]
  local getenv = _g401.getenv
  local link = _g401.link
  local bind = _g401.bind
  local initial_environment = _g401["initial-environment"]
  local id = _g401.id
  local valid_id63 = _g401["valid-id?"]
  local mapo = _g401.mapo
  local imported = _g401.imported
  local variable63 = _g401["variable?"]
  local quote_environment = _g401["quote-environment"]
  local stash42 = _g401["stash*"]
  local quoted = _g401.quoted
  local symbol63 = _g401["symbol?"]
  local macro63 = _g401["macro?"]
  local reserved63 = _g401["reserved?"]
  local quasiexpand = _g401.quasiexpand
  local macroexpand = _g401.macroexpand
  local macro_function = _g401["macro-function"]
  local bind42 = _g401["bind*"]
  local bound63 = _g401["bound?"]
  local special63 = _g401["special?"]
  local special_form63 = _g401["special-form?"]
  local key = _g401.key
  local symbol_expansion = _g401["symbol-expansion"]
  local statement63 = _g401["statement?"]
  local indentation = _g401.indentation
  local _g402 = nexus["lumen/compiler"]
  local compile = _g402.compile
  local compile_function = _g402["compile-function"]
  local import_modules = _g402["import-modules"]
  local eval = _g402.eval
  local load_module = _g402["load-module"]
  local open_module = _g402["open-module"]
  local compile_module = _g402["compile-module"]
  local declare = _g402.declare
  local in_module = _g402["in-module"]
end)();
(function ()
  nexus["lumen/core"] = {}
  local _g589 = nexus["lumen/runtime"]
  local unstash = _g589.unstash
  local char = _g589.char
  local in63 = _g589["in?"]
  local read_file = _g589["read-file"]
  local inner = _g589.inner
  local series = _g589.series
  local hd = _g589.hd
  local module_key = _g589["module-key"]
  local atom63 = _g589["atom?"]
  local string = _g589.string
  local substring = _g589.substring
  local string_literal63 = _g589["string-literal?"]
  local _43 = _g589["+"]
  local _6061 = _g589["<="]
  local _ = _g589["-"]
  local _6261 = _g589[">="]
  local map = _g589.map
  local _42 = _g589["*"]
  local one63 = _g589["one?"]
  local none63 = _g589["none?"]
  local _47 = _g589["/"]
  local split = _g589.split
  local _60 = _g589["<"]
  local _61 = _g589["="]
  local _62 = _g589[">"]
  local apply = _g589.apply
  local tl = _g589.tl
  local some63 = _g589["some?"]
  local make_id = _g589["make-id"]
  local nil63 = _g589["nil?"]
  local replicate = _g589.replicate
  local join = _g589.join
  local keys = _g589.keys
  local write = _g589.write
  local add = _g589.add
  local search = _g589.search
  local string63 = _g589["string?"]
  local toplevel63 = _g589["toplevel?"]
  local write_file = _g589["write-file"]
  local boolean63 = _g589["boolean?"]
  local iterate = _g589.iterate
  local keys63 = _g589["keys?"]
  local code = _g589.code
  local keep = _g589.keep
  local _37 = _g589["%"]
  local cat = _g589.cat
  local stash = _g589.stash
  local id_literal63 = _g589["id-literal?"]
  local pair = _g589.pair
  local function63 = _g589["function?"]
  local last = _g589.last
  local setenv = _g589.setenv
  local sort = _g589.sort
  local module = _g589.module
  local table63 = _g589["table?"]
  local _37message_handler = _g589["%message-handler"]
  local space = _g589.space
  local reduce = _g589.reduce
  local empty63 = _g589["empty?"]
  local drop = _g589.drop
  local number = _g589.number
  local now = _g589.now
  local today = _g589.today
  local exit = _g589.exit
  local is63 = _g589["is?"]
  local composite63 = _g589["composite?"]
  local length = _g589.length
  local find = _g589.find
  local number63 = _g589["number?"]
  local list63 = _g589["list?"]
  local sub = _g589.sub
  local reverse = _g589.reverse
  local _g592 = nexus["lumen/lib"]
  local quote_modules = _g592["quote-modules"]
  local getenv = _g592.getenv
  local link = _g592.link
  local bind = _g592.bind
  local initial_environment = _g592["initial-environment"]
  local id = _g592.id
  local valid_id63 = _g592["valid-id?"]
  local mapo = _g592.mapo
  local imported = _g592.imported
  local variable63 = _g592["variable?"]
  local quote_environment = _g592["quote-environment"]
  local stash42 = _g592["stash*"]
  local quoted = _g592.quoted
  local symbol63 = _g592["symbol?"]
  local macro63 = _g592["macro?"]
  local reserved63 = _g592["reserved?"]
  local quasiexpand = _g592.quasiexpand
  local macroexpand = _g592.macroexpand
  local macro_function = _g592["macro-function"]
  local bind42 = _g592["bind*"]
  local bound63 = _g592["bound?"]
  local special63 = _g592["special?"]
  local special_form63 = _g592["special-form?"]
  local key = _g592.key
  local symbol_expansion = _g592["symbol-expansion"]
  local statement63 = _g592["statement?"]
  local indentation = _g592.indentation
  local _g593 = nexus["lumen/compiler"]
  local compile = _g593.compile
  local compile_function = _g593["compile-function"]
  local import_modules = _g593["import-modules"]
  local eval = _g593.eval
  local load_module = _g593["load-module"]
  local open_module = _g593["open-module"]
  local compile_module = _g593["compile-module"]
  local declare = _g593.declare
  local in_module = _g593["in-module"]
  target = "lua"
end)();
(function ()
  nexus["lumen/boot"] = {}
  local _g916 = nexus["lumen/runtime"]
  local unstash = _g916.unstash
  local char = _g916.char
  local in63 = _g916["in?"]
  local read_file = _g916["read-file"]
  local inner = _g916.inner
  local series = _g916.series
  local hd = _g916.hd
  local module_key = _g916["module-key"]
  local atom63 = _g916["atom?"]
  local string = _g916.string
  local substring = _g916.substring
  local string_literal63 = _g916["string-literal?"]
  local _43 = _g916["+"]
  local _6061 = _g916["<="]
  local _ = _g916["-"]
  local _6261 = _g916[">="]
  local map = _g916.map
  local _42 = _g916["*"]
  local one63 = _g916["one?"]
  local none63 = _g916["none?"]
  local _47 = _g916["/"]
  local split = _g916.split
  local _60 = _g916["<"]
  local _61 = _g916["="]
  local _62 = _g916[">"]
  local apply = _g916.apply
  local tl = _g916.tl
  local some63 = _g916["some?"]
  local make_id = _g916["make-id"]
  local nil63 = _g916["nil?"]
  local replicate = _g916.replicate
  local join = _g916.join
  local keys = _g916.keys
  local write = _g916.write
  local add = _g916.add
  local search = _g916.search
  local string63 = _g916["string?"]
  local toplevel63 = _g916["toplevel?"]
  local write_file = _g916["write-file"]
  local boolean63 = _g916["boolean?"]
  local iterate = _g916.iterate
  local keys63 = _g916["keys?"]
  local code = _g916.code
  local keep = _g916.keep
  local _37 = _g916["%"]
  local cat = _g916.cat
  local stash = _g916.stash
  local id_literal63 = _g916["id-literal?"]
  local pair = _g916.pair
  local function63 = _g916["function?"]
  local last = _g916.last
  local setenv = _g916.setenv
  local sort = _g916.sort
  local module = _g916.module
  local table63 = _g916["table?"]
  local _37message_handler = _g916["%message-handler"]
  local space = _g916.space
  local reduce = _g916.reduce
  local empty63 = _g916["empty?"]
  local drop = _g916.drop
  local number = _g916.number
  local now = _g916.now
  local today = _g916.today
  local exit = _g916.exit
  local is63 = _g916["is?"]
  local composite63 = _g916["composite?"]
  local length = _g916.length
  local find = _g916.find
  local number63 = _g916["number?"]
  local list63 = _g916["list?"]
  local sub = _g916.sub
  local reverse = _g916.reverse
  local _g919 = nexus["lumen/lib"]
  local quote_modules = _g919["quote-modules"]
  local getenv = _g919.getenv
  local link = _g919.link
  local bind = _g919.bind
  local initial_environment = _g919["initial-environment"]
  local id = _g919.id
  local valid_id63 = _g919["valid-id?"]
  local mapo = _g919.mapo
  local imported = _g919.imported
  local variable63 = _g919["variable?"]
  local quote_environment = _g919["quote-environment"]
  local stash42 = _g919["stash*"]
  local quoted = _g919.quoted
  local symbol63 = _g919["symbol?"]
  local macro63 = _g919["macro?"]
  local reserved63 = _g919["reserved?"]
  local quasiexpand = _g919.quasiexpand
  local macroexpand = _g919.macroexpand
  local macro_function = _g919["macro-function"]
  local bind42 = _g919["bind*"]
  local bound63 = _g919["bound?"]
  local special63 = _g919["special?"]
  local special_form63 = _g919["special-form?"]
  local key = _g919.key
  local symbol_expansion = _g919["symbol-expansion"]
  local statement63 = _g919["statement?"]
  local indentation = _g919.indentation
  local _g920 = nexus["lumen/compiler"]
  local compile = _g920.compile
  local compile_function = _g920["compile-function"]
  local import_modules = _g920["import-modules"]
  local eval = _g920.eval
  local load_module = _g920["load-module"]
  local open_module = _g920["open-module"]
  local compile_module = _g920["compile-module"]
  local declare = _g920.declare
  local in_module = _g920["in-module"]
  modules = {["lumen/lib"] = {export = {["quote-modules"] = {export = true, variable = true}, reserved = {variable = true}, getenv = {export = true, variable = true}, ["with-indent"] = {export = true, macro = function (form)
    local result = make_id()
    return({"do", {"inc", "indent-level"}, {"let", {result, form}, {"dec", "indent-level"}, result}})
  end}, ["can-unquote?"] = {variable = true}, ["indent-level"] = {global = true, export = true}, link = {export = true, variable = true}, bind = {export = true, variable = true}, ["initial-environment"] = {export = true, variable = true}, id = {export = true, variable = true}, ["valid-id?"] = {export = true, variable = true}, exclude = {variable = true}, mapo = {export = true, variable = true}, imported = {export = true, variable = true}, ["quote-module"] = {variable = true}, ["variable?"] = {export = true, variable = true}, ["quote-environment"] = {export = true, variable = true}, ["stash*"] = {export = true, variable = true}, quoted = {export = true, variable = true}, ["symbol?"] = {export = true, variable = true}, ["valid-code?"] = {variable = true}, index = {variable = true}, ["quoting?"] = {variable = true}, ["macro?"] = {export = true, variable = true}, ["reserved?"] = {export = true, variable = true}, ["quasiquote-list"] = {variable = true}, escape = {variable = true}, ["quote-frame"] = {variable = true}, quasiexpand = {export = true, variable = true}, macroexpand = {export = true, variable = true}, ["quote-binding"] = {variable = true}, ["macro-function"] = {export = true, variable = true}, ["numeric?"] = {variable = true}, ["bind*"] = {export = true, variable = true}, ["quasisplice?"] = {variable = true}, ["bound?"] = {export = true, variable = true}, extend = {variable = true}, ["special?"] = {export = true, variable = true}, ["global?"] = {variable = true}, ["special-form?"] = {export = true, variable = true}, key = {export = true, variable = true}, literal = {variable = true}, ["symbol-expansion"] = {export = true, variable = true}, ["statement?"] = {export = true, variable = true}, indentation = {export = true, variable = true}, ["quasiquoting?"] = {variable = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}}, ["lumen/core"] = {export = {["with-frame"] = {export = true, macro = function (...)
    local _g936 = unstash({...})
    local scope = _g936.scope
    local body = sub(_g936, 0)
    local x = make_id()
    local _g937 = {"table"}
    _g937._scope = scope
    return({"do", {"add", "environment", _g937}, {"let", {x, join({"do"}, body)}, {"drop", "environment"}, x}})
  end}, ["define-special"] = {export = true, macro = function (name, args, ...)
    local _g938 = unstash({...})
    local body = sub(_g938, 0)
    local form = join({"fn", args}, body)
    local keys = sub(body, length(body))
    local _g939 = {"setenv", {"quote", name}}
    _g939.special = form
    _g939.form = {"quote", form}
    eval(join(_g939, keys))
    return(nil)
  end}, ["define*"] = {export = true, macro = function (name, x, ...)
    local _g940 = unstash({...})
    local body = sub(_g940, 0)
    setenv(name, {_stash = true, export = true, global = true})
    if some63(body) then
      local _g941 = bind42(x, body)
      local args = _g941[1]
      local _g942 = _g941[2]
      return(join({"%global-function", name, args}, _g942))
    else
      if target == "js" then
        return({"set", {"get", "global", {"quote", id(name)}}, x})
      else
        return({"set", name, x})
      end
    end
  end}, ["let-macro"] = {export = true, macro = function (definitions, ...)
    local _g943 = unstash({...})
    local body = sub(_g943, 0)
    add(environment, {})
    map(function (m)
      return(macroexpand(join({"define-macro"}, m)))
    end, definitions)
    local _g944 = join({"do"}, macroexpand(body))
    drop(environment)
    return(_g944)
  end}, ["let-symbol"] = {export = true, macro = function (expansions, ...)
    local _g946 = unstash({...})
    local body = sub(_g946, 0)
    add(environment, {})
    map(function (_g949)
      local name = _g949[1]
      local exp = _g949[2]
      return(macroexpand({"define-symbol", name, exp}))
    end, pair(expansions))
    local _g947 = join({"do"}, macroexpand(body))
    drop(environment)
    return(_g947)
  end}, when = {export = true, macro = function (cond, ...)
    local _g950 = unstash({...})
    local body = sub(_g950, 0)
    return({"if", cond, join({"do"}, body)})
  end}, define = {export = true, macro = function (name, x, ...)
    local _g951 = unstash({...})
    local body = sub(_g951, 0)
    setenv(name, {_stash = true, variable = true})
    if some63(body) and target == "js" then
      return(link(name, {"%local", name, join({"fn", x}, body)}))
    else
      if some63(body) then
        local _g952 = bind42(x, body)
        local args = _g952[1]
        local _g953 = _g952[2]
        return(link(name, join({"%local-function", name, args}, _g953)))
      else
        return(link(name, {"%local", name, x}))
      end
    end
  end}, ["join!"] = {export = true, macro = function (a, ...)
    local _g954 = unstash({...})
    local bs = sub(_g954, 0)
    return({"set", a, join({"join*", a}, bs)})
  end}, ["if"] = {export = true, macro = function (...)
    local branches = unstash({...})
    local function step(_g956)
      local a = _g956[1]
      local b = _g956[2]
      local c = sub(_g956, 2)
      if is63(b) then
        return({join({"%if", a, b}, step(c))})
      else
        if is63(a) then
          return({a})
        end
      end
    end
    return(hd(step(branches)))
  end}, ["cat!"] = {export = true, macro = function (a, ...)
    local _g957 = unstash({...})
    local bs = sub(_g957, 0)
    return({"set", a, join({"cat", a}, bs)})
  end}, quasiquote = {export = true, macro = function (form)
    return(quasiexpand(form, 1))
  end}, ["define-symbol"] = {export = true, macro = function (name, expansion)
    setenv(name, {_stash = true, symbol = expansion})
    return(nil)
  end}, list = {export = true, macro = function (...)
    local body = unstash({...})
    local l = join({"%array"}, body)
    if not keys63(body) then
      return(l)
    else
      local id = make_id()
      local init = {}
      local _g960 = body
      local k = nil
      for k in next, _g960 do
        if not number63(k) then
          local v = _g960[k]
          add(init, {"set", {"get", id, {"quote", k}}, v})
        end
      end
      return(join({"let", {id, l}}, join(init, {id})))
    end
  end}, let = {export = true, macro = function (bindings, ...)
    local _g961 = unstash({...})
    local body = sub(_g961, 0)
    if length(bindings) < 2 then
      return(join({"do"}, body))
    else
      local renames = {}
      local locals = {}
      local lh = bindings[1]
      local rh = bindings[2]
      local _g962 = bind(lh, rh)
      local _g963 = 0
      while _g963 < length(_g962) do
        local _g964 = _g962[_g963 + 1]
        local id = _g964[1]
        local val = _g964[2]
        if bound63(id) or reserved63(id) or toplevel63() then
          local id1 = make_id()
          add(renames, id)
          add(renames, id1)
          id = id1
        else
          setenv(id, {_stash = true, variable = true})
        end
        add(locals, {"%local", id, val})
        _g963 = _g963 + 1
      end
      return(join({"do"}, join(locals, {{"let-symbol", renames, join({"let", sub(bindings, 2)}, body)}})))
    end
  end}, fn = {export = true, macro = function (args, ...)
    local _g965 = unstash({...})
    local body = sub(_g965, 0)
    local _g966 = bind42(args, body)
    local _g967 = _g966[1]
    local _g968 = _g966[2]
    return(join({"%function", _g967}, _g968))
  end}, at = {export = true, macro = function (l, i)
    if target == "lua" and number63(i) then
      i = i + 1
    else
      if target == "lua" then
        i = {"+", i, 1}
      end
    end
    return({"get", l, i})
  end}, ["with-bindings"] = {export = true, macro = function (_g971, ...)
    local names = _g971[1]
    local _g970 = unstash({...})
    local body = sub(_g970, 0)
    local x = make_id()
    local _g973 = {"setenv", x}
    _g973.variable = true
    local _g972 = {"with-frame", {"each", {x}, names, _g973}}
    _g972.scope = true
    return(join(_g972, body))
  end}, language = {export = true, macro = function ()
    return({"quote", target})
  end}, pr = {export = true, macro = function (...)
    local xs = unstash({...})
    return({"print", space(xs)})
  end}, unless = {export = true, macro = function (cond, ...)
    local _g975 = unstash({...})
    local body = sub(_g975, 0)
    return({"if", {"not", cond}, join({"do"}, body)})
  end}, each = {export = true, macro = function (b, t, ...)
    local _g976 = unstash({...})
    local body = sub(_g976, 0)
    local k = b[1]
    local v = b[2]
    local t1 = make_id()
    local _g1036
    if nil63(v) then
      local _g1037
      if b.i then
        _g1037 = "i"
      else
        _g1037 = make_id()
      end
      local i = _g1037
      _g1036 = {"let", {i, 0}, {"while", {"<", i, {"length", t1}}, join({"let", {k, {"at", t1, i}}}, body), {"inc", i}}}
    else
      local _g977 = {"target"}
      _g977.lua = {"not", {"number?", k}}
      _g977.js = {"isNaN", {"parseInt", k}}
      _g1036 = {"let", {k, "nil"}, {"%for", t1, k, {"when", _g977, join({"let", {v, {"get", t1, k}}}, body)}}}
    end
    return({"let", {t1, t}, _g1036})
  end}, ["set-of"] = {export = true, macro = function (...)
    local xs = unstash({...})
    local l = {}
    local _g978 = xs
    local _g979 = 0
    while _g979 < length(_g978) do
      local x = _g978[_g979 + 1]
      l[x] = true
      _g979 = _g979 + 1
    end
    return(join({"table"}, l))
  end}, guard = {export = true, macro = function (expr)
    if target == "js" then
      return({{"fn", {}, {"%try", {"list", true, expr}}}})
    else
      local e = make_id()
      local x = make_id()
      local ex = "|" .. e .. "," .. x .. "|"
      return({"let", {ex, {"xpcall", {"fn", {}, expr}, "%message-handler"}}, {"list", e, x}})
    end
  end}, inc = {export = true, macro = function (n, by)
    return({"set", n, {"+", n, by or 1}})
  end}, ["set*"] = {export = true, macro = function (name, value)
    return(link(name, {"set", name, value}))
  end}, ["define-module"] = {export = true, macro = function (spec, ...)
    local _g983 = unstash({...})
    local body = sub(_g983, 0)
    local exp = body.export
    local imp = body.import
    local alias = body.alias
    local _g984 = import_modules(imp)
    local imports = _g984[1]
    local bindings = _g984[2]
    local k = module_key(spec)
    modules[k] = {export = {}, import = imports, alias = alias}
    local _g985 = exp or {}
    local _g986 = 0
    while _g986 < length(_g985) do
      local x = _g985[_g986 + 1]
      setenv(x, {_stash = true, export = true})
      _g986 = _g986 + 1
    end
    return(join({"do", {"set", {"get", "nexus", {"quote", k}}, {"table"}}}, bindings))
  end}, ["define-macro"] = {export = true, macro = function (name, args, ...)
    local _g987 = unstash({...})
    local body = sub(_g987, 0)
    local form = join({"fn", args}, body)
    local _g988 = {"setenv", {"quote", name}}
    _g988.macro = form
    _g988.form = {"quote", form}
    eval(_g988)
    return(nil)
  end}, table = {export = true, macro = function (...)
    local body = unstash({...})
    return(join({"%object"}, mapo(function (x)
      return(x)
    end, body)))
  end}, quote = {export = true, macro = function (form)
    return(quoted(form))
  end}, all = {export = true, macro = function (_g992, t, ...)
    local k = _g992[1]
    local v = _g992[2]
    local _g991 = unstash({...})
    local body = sub(_g991, 0)
    local x = make_id()
    local n = make_id()
    local _g1038
    if target == "lua" then
      _g1038 = body
    else
      _g1038 = {join({"let", {n, {"parseInt", k}, k, {"if", {"isNaN", n}, k, n}}}, body)}
    end
    return({"let", {x, t, k, "nil"}, {"%for", x, k, join({"let", {v, {"get", x, k}}}, _g1038)}})
  end}, dec = {export = true, macro = function (n, by)
    return({"set", n, {"-", n, by or 1}})
  end}, target = {export = true, macro = function (...)
    local clauses = unstash({...})
    return(clauses[target])
  end, global = true}, ["join*"] = {export = true, macro = function (...)
    local xs = unstash({...})
    return(reduce(function (a, b)
      return({"join", a, b})
    end, xs))
  end}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "compiler"}}}, ["lumen/reader"] = {export = {["read-from-string"] = {export = true, variable = true}, ["peek-char"] = {variable = true}, ["flag?"] = {variable = true}, ["read-table"] = {export = true, variable = true}, eof = {variable = true}, ["key?"] = {variable = true}, ["define-reader"] = {export = true, macro = function (_g996, ...)
    local char = _g996[1]
    local stream = _g996[2]
    local _g995 = unstash({...})
    local body = sub(_g995, 0)
    return({"set", {"get", "read-table", char}, join({"fn", {stream}}, body)})
  end}, read = {export = true, variable = true}, ["read-all"] = {export = true, variable = true}, delimiters = {variable = true}, ["make-stream"] = {export = true, variable = true}, whitespace = {variable = true}, ["skip-non-code"] = {variable = true}, ["read-char"] = {variable = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}}, ["lumen/main"] = {export = {}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "reader"}, {"lumen", "compiler"}}}, ["lumen/boot"] = {export = {["%initial-modules"] = {macro = function ()
    return(quote_modules())
  end}, ["%initial-environment"] = {macro = function ()
    return(quote_environment(initial_environment()))
  end}, modules = {export = true, global = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "compiler"}}}, ["lumen/runtime"] = {export = {unstash = {export = true, variable = true}, char = {export = true, variable = true}, ["in?"] = {export = true, variable = true}, ["read-file"] = {export = true, variable = true}, inner = {export = true, variable = true}, series = {export = true, variable = true}, hd = {export = true, variable = true}, ["module-key"] = {export = true, variable = true}, ["atom?"] = {export = true, variable = true}, string = {export = true, variable = true}, substring = {export = true, variable = true}, ["string-literal?"] = {export = true, variable = true}, ["+"] = {export = true, variable = true}, ["<="] = {export = true, variable = true}, ["-"] = {export = true, variable = true}, [">="] = {export = true, variable = true}, map = {export = true, variable = true}, ["*"] = {export = true, variable = true}, ["one?"] = {export = true, variable = true}, ["none?"] = {export = true, variable = true}, ["/"] = {export = true, variable = true}, split = {export = true, variable = true}, ["<"] = {export = true, variable = true}, ["="] = {export = true, variable = true}, [">"] = {export = true, variable = true}, apply = {export = true, variable = true}, tl = {export = true, variable = true}, ["some?"] = {export = true, variable = true}, ["make-id"] = {export = true, variable = true}, ["nil?"] = {export = true, variable = true}, replicate = {export = true, variable = true}, join = {export = true, variable = true}, keys = {export = true, variable = true}, write = {export = true, variable = true}, add = {export = true, variable = true}, search = {export = true, variable = true}, ["string?"] = {export = true, variable = true}, ["toplevel?"] = {export = true, variable = true}, ["write-file"] = {export = true, variable = true}, ["boolean?"] = {export = true, variable = true}, iterate = {export = true, variable = true}, ["keys?"] = {export = true, variable = true}, code = {export = true, variable = true}, keep = {export = true, variable = true}, ["%"] = {export = true, variable = true}, cat = {export = true, variable = true}, shift = {variable = true}, stash = {export = true, variable = true}, ["id-literal?"] = {export = true, variable = true}, pair = {export = true, variable = true}, ["id-count"] = {variable = true}, ["function?"] = {export = true, variable = true}, last = {export = true, variable = true}, setenv = {export = true, variable = true}, sort = {export = true, variable = true}, module = {export = true, variable = true}, ["table?"] = {export = true, variable = true}, ["%message-handler"] = {export = true, variable = true}, space = {export = true, variable = true}, reduce = {export = true, variable = true}, ["empty?"] = {export = true, variable = true}, drop = {export = true, variable = true}, number = {export = true, variable = true}, now = {export = true, variable = true}, today = {export = true, variable = true}, exit = {export = true, variable = true}, ["is?"] = {export = true, variable = true}, ["composite?"] = {export = true, variable = true}, length = {export = true, variable = true}, find = {export = true, variable = true}, ["number?"] = {export = true, variable = true}, ["list?"] = {export = true, variable = true}, sub = {export = true, variable = true}, reverse = {export = true, variable = true}}, import = {{"lumen", "special"}, {"lumen", "core"}}}, ["lumen/system"] = {export = {nexus = {global = true, export = true}}, import = {{"lumen", "special"}, {"lumen", "core"}}}, ["lumen/special"] = {export = {["while"] = {export = true, tr = true, special = function (cond, form)
    local _g1000 = compile(cond)
    indent_level = indent_level + 1
    local _g1001 = compile(form, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local body = _g1001
    local ind = indentation()
    if target == "js" then
      return(ind .. "while (" .. _g1000 .. ") {\n" .. body .. ind .. "}\n")
    else
      return(ind .. "while " .. _g1000 .. " do\n" .. body .. ind .. "end\n")
    end
  end, stmt = true, foo = true}, get = {export = true, special = function (t, k)
    local _g1003 = compile(t)
    local k1 = compile(k)
    if target == "lua" and char(_g1003, 0) == "{" then
      _g1003 = "(" .. _g1003 .. ")"
    end
    if string_literal63(k) and valid_id63(inner(k)) then
      return(_g1003 .. "." .. inner(k))
    else
      return(_g1003 .. "[" .. k1 .. "]")
    end
  end, foo = true}, set = {special = function (lh, rh)
    local _g1005 = compile(lh)
    local _g1039
    if nil63(rh) then
      _g1039 = "nil"
    else
      _g1039 = rh
    end
    local _g1006 = compile(_g1039)
    return(indentation() .. _g1005 .. " = " .. _g1006)
  end, foo = true, export = true, stmt = true}, ["return"] = {special = function (x)
    local _g1040
    if nil63(x) then
      _g1040 = "return"
    else
      _g1040 = "return(" .. compile(x) .. ")"
    end
    local _g1008 = _g1040
    return(indentation() .. _g1008)
  end, foo = true, export = true, stmt = true}, ["%function"] = {export = true, special = function (args, body)
    return(compile_function(args, body))
  end, foo = true}, ["%if"] = {export = true, tr = true, special = function (cond, cons, alt)
    local _g1011 = compile(cond)
    indent_level = indent_level + 1
    local _g1013 = compile(cons, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local _g1012 = _g1013
    local _g1041
    if alt then
      indent_level = indent_level + 1
      local _g1015 = compile(alt, {_stash = true, stmt = true})
      indent_level = indent_level - 1
      _g1041 = _g1015
    end
    local _g1014 = _g1041
    local ind = indentation()
    local str = ""
    if target == "js" then
      str = str .. ind .. "if (" .. _g1011 .. ") {\n" .. _g1012 .. ind .. "}"
    else
      str = str .. ind .. "if " .. _g1011 .. " then\n" .. _g1012
    end
    if _g1014 and target == "js" then
      str = str .. " else {\n" .. _g1014 .. ind .. "}"
    else
      if _g1014 then
        str = str .. ind .. "else\n" .. _g1014
      end
    end
    if target == "lua" then
      return(str .. ind .. "end\n")
    else
      return(str .. "\n")
    end
  end, stmt = true, foo = true}, ["%array"] = {export = true, special = function (...)
    local forms = unstash({...})
    local _g1042
    if target == "lua" then
      _g1042 = "{"
    else
      _g1042 = "["
    end
    local open = _g1042
    local _g1043
    if target == "lua" then
      _g1043 = "}"
    else
      _g1043 = "]"
    end
    local close = _g1043
    local str = ""
    local _g1016 = forms
    local i = 0
    while i < length(_g1016) do
      local x = _g1016[i + 1]
      str = str .. compile(x)
      if i < length(forms) - 1 then
        str = str .. ", "
      end
      i = i + 1
    end
    return(open .. str .. close)
  end, foo = true}, ["%global-function"] = {export = true, tr = true, special = function (name, args, body)
    if target == "lua" then
      local x = compile_function(args, body, {_stash = true, name = name})
      return(indentation() .. x)
    else
      return(compile({"set", name, {"%function", args, body}}, {_stash = true, stmt = true}))
    end
  end, stmt = true, foo = true}, ["%try"] = {export = true, tr = true, special = function (form)
    local ind = indentation()
    indent_level = indent_level + 1
    local _g1019 = compile(form, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local body = _g1019
    local e = make_id()
    local hf = {"return", {"%array", false, {"get", e, "\"message\""}}}
    indent_level = indent_level + 1
    local _g1020 = compile(hf, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local h = _g1020
    return(ind .. "try {\n" .. body .. ind .. "}\n" .. ind .. "catch (" .. e .. ") {\n" .. h .. ind .. "}\n")
  end, stmt = true, foo = true}, ["%for"] = {export = true, tr = true, special = function (t, k, form)
    local _g1022 = compile(t)
    local ind = indentation()
    indent_level = indent_level + 1
    local _g1023 = compile(form, {_stash = true, stmt = true})
    indent_level = indent_level - 1
    local body = _g1023
    if target == "lua" then
      return(ind .. "for " .. k .. " in next, " .. _g1022 .. " do\n" .. body .. ind .. "end\n")
    else
      return(ind .. "for (" .. k .. " in " .. _g1022 .. ") {\n" .. body .. ind .. "}\n")
    end
  end, stmt = true, foo = true}, ["not"] = {}, ["break"] = {special = function ()
    return(indentation() .. "break")
  end, foo = true, export = true, stmt = true}, ["%object"] = {export = true, special = function (...)
    local forms = unstash({...})
    local str = "{"
    local _g1044
    if target == "lua" then
      _g1044 = " = "
    else
      _g1044 = ": "
    end
    local sep = _g1044
    local pairs = pair(forms)
    local n_1 = length(pairs) - 1
    local _g1025 = pairs
    local i = 0
    while i < length(_g1025) do
      local _g1026 = _g1025[i + 1]
      local k = _g1026[1]
      local v = _g1026[2]
      if not string63(k) then
        error("Illegal key: " .. string(k))
      end
      str = str .. key(k) .. sep .. compile(v)
      if i < n_1 then
        str = str .. ", "
      end
      i = i + 1
    end
    return(str .. "}")
  end, foo = true}, ["do"] = {export = true, tr = true, special = function (...)
    local forms = unstash({...})
    local str = ""
    local _g1027 = forms
    local _g1028 = 0
    while _g1028 < length(_g1027) do
      local x = _g1027[_g1028 + 1]
      str = str .. compile(x, {_stash = true, stmt = true})
      _g1028 = _g1028 + 1
    end
    return(str)
  end, stmt = true, foo = true}, ["%local-function"] = {export = true, tr = true, special = function (name, args, body)
    local x = compile_function(args, body, {_stash = true, prefix = "local ", name = name})
    return(indentation() .. x)
  end, stmt = true, foo = true}, error = {special = function (x)
    local _g1045
    if target == "js" then
      _g1045 = "throw new " .. compile({"Error", x})
    else
      _g1045 = "error(" .. compile(x) .. ")"
    end
    local e = _g1045
    return(indentation() .. e)
  end, foo = true, export = true, stmt = true}, ["%local"] = {special = function (name, value)
    local id = compile(name)
    local value1 = compile(value)
    local _g1046
    if is63(value) then
      _g1046 = " = " .. value1
    else
      _g1046 = ""
    end
    local rh = _g1046
    local _g1047
    if target == "js" then
      _g1047 = "var "
    else
      _g1047 = "local "
    end
    local keyword = _g1047
    local ind = indentation()
    return(ind .. keyword .. id .. rh)
  end, foo = true, export = true, stmt = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "compiler"}}}, lumen = {export = {}, import = {{"lumen", "special"}}, alias = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}}, user = {export = {}, import = {"lumen", {"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}}}, ["lumen/compiler"] = {export = {["lower-call"] = {variable = true}, ["can-return?"] = {variable = true}, precedence = {variable = true}, ["op-delims"] = {variable = true}, compile = {export = true, variable = true}, ["compile-function"] = {export = true, variable = true}, ["lower-statement"] = {variable = true}, process = {variable = true}, ["unary?"] = {variable = true}, ["import-modules"] = {export = true, variable = true}, eval = {export = true, variable = true}, ["lower-do"] = {variable = true}, ["load-module"] = {export = true, variable = true}, ["current-module"] = {global = true, export = true}, ["lower-if"] = {variable = true}, ["%result"] = {global = true, export = true}, ["open-module"] = {export = true, variable = true}, ["lower-special"] = {variable = true}, ["compile-module"] = {export = true, variable = true}, ["%compile-module"] = {variable = true}, run = {variable = true}, ["compiler-output"] = {variable = true}, ["lower-short"] = {variable = true}, getop = {variable = true}, ["lower-infix"] = {variable = true}, conclude = {variable = true}, ["compile-special"] = {variable = true}, terminator = {variable = true}, ["compile-infix"] = {variable = true}, ["compile-file"] = {variable = true}, encapsulate = {variable = true}, ["module-path"] = {variable = true}, ["lower-try"] = {variable = true}, lower = {variable = true}, infix = {variable = true}, ["compile-call"] = {variable = true}, reimported = {variable = true}, ["compile-args"] = {variable = true}, ["compile-atom"] = {variable = true}, declare = {export = true, variable = true}, ["lower-function"] = {variable = true}, ["lower-while"] = {variable = true}, ["lower-for"] = {variable = true}, ["lower-infix?"] = {variable = true}, ["compiling?"] = {variable = true}, ["parenthesize-call?"] = {variable = true}, ["in-module"] = {export = true, variable = true}, ["lower-definition"] = {variable = true}, ["lower-body"] = {variable = true}, ["infix?"] = {variable = true}}, import = {{"lumen", "runtime"}, {"lumen", "special"}, {"lumen", "core"}, {"lumen", "lib"}, {"lumen", "reader"}}}}
  environment = {{["define-module"] = {export = true, macro = function (spec, ...)
    local _g1032 = unstash({...})
    local body = sub(_g1032, 0)
    local exp = body.export
    local imp = body.import
    local alias = body.alias
    local _g1033 = import_modules(imp)
    local imports = _g1033[1]
    local bindings = _g1033[2]
    local k = module_key(spec)
    modules[k] = {export = {}, import = imports, alias = alias}
    local _g1034 = exp or {}
    local _g1035 = 0
    while _g1035 < length(_g1034) do
      local x = _g1034[_g1035 + 1]
      setenv(x, {_stash = true, export = true})
      _g1035 = _g1035 + 1
    end
    return(join({"do", {"set", {"get", "nexus", {"quote", k}}, {"table"}}}, bindings))
  end}}}
end)();
(function ()
  nexus.user = {}
  local _g1048 = nexus["lumen/runtime"]
  local unstash = _g1048.unstash
  local char = _g1048.char
  local in63 = _g1048["in?"]
  local read_file = _g1048["read-file"]
  local inner = _g1048.inner
  local series = _g1048.series
  local hd = _g1048.hd
  local module_key = _g1048["module-key"]
  local atom63 = _g1048["atom?"]
  local string = _g1048.string
  local substring = _g1048.substring
  local string_literal63 = _g1048["string-literal?"]
  local _43 = _g1048["+"]
  local _6061 = _g1048["<="]
  local _ = _g1048["-"]
  local _6261 = _g1048[">="]
  local map = _g1048.map
  local _42 = _g1048["*"]
  local one63 = _g1048["one?"]
  local none63 = _g1048["none?"]
  local _47 = _g1048["/"]
  local split = _g1048.split
  local _60 = _g1048["<"]
  local _61 = _g1048["="]
  local _62 = _g1048[">"]
  local apply = _g1048.apply
  local tl = _g1048.tl
  local some63 = _g1048["some?"]
  local make_id = _g1048["make-id"]
  local nil63 = _g1048["nil?"]
  local replicate = _g1048.replicate
  local join = _g1048.join
  local keys = _g1048.keys
  local write = _g1048.write
  local add = _g1048.add
  local search = _g1048.search
  local string63 = _g1048["string?"]
  local toplevel63 = _g1048["toplevel?"]
  local write_file = _g1048["write-file"]
  local boolean63 = _g1048["boolean?"]
  local iterate = _g1048.iterate
  local keys63 = _g1048["keys?"]
  local code = _g1048.code
  local keep = _g1048.keep
  local _37 = _g1048["%"]
  local cat = _g1048.cat
  local stash = _g1048.stash
  local id_literal63 = _g1048["id-literal?"]
  local pair = _g1048.pair
  local function63 = _g1048["function?"]
  local last = _g1048.last
  local setenv = _g1048.setenv
  local sort = _g1048.sort
  local module = _g1048.module
  local table63 = _g1048["table?"]
  local _37message_handler = _g1048["%message-handler"]
  local space = _g1048.space
  local reduce = _g1048.reduce
  local empty63 = _g1048["empty?"]
  local drop = _g1048.drop
  local number = _g1048.number
  local now = _g1048.now
  local today = _g1048.today
  local exit = _g1048.exit
  local is63 = _g1048["is?"]
  local composite63 = _g1048["composite?"]
  local length = _g1048.length
  local find = _g1048.find
  local number63 = _g1048["number?"]
  local list63 = _g1048["list?"]
  local sub = _g1048.sub
  local reverse = _g1048.reverse
end)();
(function ()
  nexus["lumen/main"] = {}
  local _g2 = nexus["lumen/runtime"]
  local unstash = _g2.unstash
  local char = _g2.char
  local in63 = _g2["in?"]
  local module = _g2.module
  local inner = _g2.inner
  local series = _g2.series
  local hd = _g2.hd
  local module_key = _g2["module-key"]
  local atom63 = _g2["atom?"]
  local string = _g2.string
  local substring = _g2.substring
  local length = _g2.length
  local _43 = _g2["+"]
  local _6061 = _g2["<="]
  local _ = _g2["-"]
  local _6261 = _g2[">="]
  local map = _g2.map
  local _42 = _g2["*"]
  local one63 = _g2["one?"]
  local none63 = _g2["none?"]
  local _37message_handler = _g2["%message-handler"]
  local split = _g2.split
  local _60 = _g2["<"]
  local _61 = _g2["="]
  local _62 = _g2[">"]
  local apply = _g2.apply
  local find = _g2.find
  local some63 = _g2["some?"]
  local make_id = _g2["make-id"]
  local number = _g2.number
  local replicate = _g2.replicate
  local join = _g2.join
  local keys = _g2.keys
  local write = _g2.write
  local add = _g2.add
  local search = _g2.search
  local string63 = _g2["string?"]
  local toplevel63 = _g2["toplevel?"]
  local write_file = _g2["write-file"]
  local boolean63 = _g2["boolean?"]
  local composite63 = _g2["composite?"]
  local keys63 = _g2["keys?"]
  local code = _g2.code
  local keep = _g2.keep
  local now = _g2.now
  local cat = _g2.cat
  local stash = _g2.stash
  local id_literal63 = _g2["id-literal?"]
  local today = _g2.today
  local tl = _g2.tl
  local function63 = _g2["function?"]
  local read_file = _g2["read-file"]
  local sort = _g2.sort
  local _37 = _g2["%"]
  local table63 = _g2["table?"]
  local last = _g2.last
  local _47 = _g2["/"]
  local reduce = _g2.reduce
  local empty63 = _g2["empty?"]
  local drop = _g2.drop
  local setenv = _g2.setenv
  local nil63 = _g2["nil?"]
  local space = _g2.space
  local exit = _g2.exit
  local is63 = _g2["is?"]
  local list63 = _g2["list?"]
  local string_literal63 = _g2["string-literal?"]
  local iterate = _g2.iterate
  local number63 = _g2["number?"]
  local pair = _g2.pair
  local sub = _g2.sub
  local reverse = _g2.reverse
  local _g5 = nexus["lumen/reader"]
  local read = _g5.read
  local read_table = _g5["read-table"]
  local read_from_string = _g5["read-from-string"]
  local read_all = _g5["read-all"]
  local make_stream = _g5["make-stream"]
  local _g6 = nexus["lumen/compiler"]
  local compile = _g6.compile
  local compile_function = _g6["compile-function"]
  local import_modules = _g6["import-modules"]
  local eval = _g6.eval
  local load_module = _g6["load-module"]
  local compile_module = _g6["compile-module"]
  local open_module = _g6["open-module"]
  local declare = _g6.declare
  local in_module = _g6["in-module"]
  local function rep(str)
    local _g1053,_g1054 = xpcall(function ()
      return(eval(read_from_string(str)))
    end, _37message_handler)
    local _g1052 = {_g1053, _g1054}
    local _g1 = _g1052[1]
    local x = _g1052[2]
    if is63(x) then
      return(print(string(x)))
    end
  end
  nexus["lumen/main"].rep = rep
  local function repl()
    local function step(str)
      rep(str)
      return(write("> "))
    end
    write("> ")
    while true do
      local str = io.read()
      if str then
        step(str)
      else
        break
      end
    end
  end
  nexus["lumen/main"].repl = repl
  local function usage()
    print("usage: lumen [options] <module>")
    print("options:")
    print("  -o <output>\tOutput file")
    print("  -t <target>\tTarget language (default: lua)")
    print("  -e <expr>\tExpression to evaluate")
    return(exit())
  end
  nexus["lumen/main"].usage = usage
  local function main()
    local args = arg
    if hd(args) == "-h" or hd(args) == "--help" then
      usage()
    end
    local spec = nil
    local output = nil
    local target1 = nil
    local expr = nil
    local _g1060 = args
    local i = 0
    while i < length(_g1060) do
      local arg = _g1060[i + 1]
      if arg == "-o" or arg == "-t" or arg == "-e" then
        if i == length(args) - 1 then
          print("missing argument for" .. " " .. string(arg))
        else
          i = i + 1
          local val = args[i + 1]
          if arg == "-o" then
            output = val
          else
            if arg == "-t" then
              target1 = val
            else
              if arg == "-e" then
                expr = val
              end
            end
          end
        end
      else
        if nil63(spec) and "-" ~= char(arg, 0) then
          spec = arg
        end
      end
      i = i + 1
    end
    if output then
      if target1 then
        target = target1
      end
      return(write_file(output, compile_module(spec)))
    else
      in_module(spec or "user")
      if expr then
        return(rep(expr))
      else
        return(repl())
      end
    end
  end
  nexus["lumen/main"].main = main
  main()
end)();
