package.preload['frmSettings'] = (function (...)
local frmSettings = {
  frame = nil
}

function frmSettings:Show()
  if not self.frame then
    self:Init()
  end
  self:Load()
  self.frame:Show()
end

function frmSettings:Init()
  self.frame = wx.wxFrame(wx.NULL,
    wx.wxID_ANY,
    "Settings",
    wx.wxDefaultPosition,
    wx.wxSize( -1,-1 ),
    wx.wxCAPTION + wx.wxCLOSE_BOX + wx.wxFRAME_NO_TASKBAR + wx.wxRESIZE_BORDER + wx.wxSYSTEM_MENU + wx.wxTAB_TRAVERSAL
  )
  local lframe = self.frame
  lframe:SetSizeHints( wx.wxDefaultSize, wx.wxDefaultSize )
  lframe:SetIcon(wx.wxIcon("HANDLR_ICON", wx.wxBITMAP_TYPE_ICO_RESOURCE))
  
  self.vszSettings = wx.wxBoxSizer( wx.wxVERTICAL )
  
  self.sbsOpen = wx.wxStaticBoxSizer( wx.wxStaticBox( lframe, wx.wxID_ANY, "Opening URLs" ), wx.wxVERTICAL )
  
  self.hszAuto = wx.wxBoxSizer( wx.wxHORIZONTAL )
  
  self.chkAuto = wx.wxCheckBox( lframe, wx.wxID_ANY, "Automatically open fewer than", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.chkAuto:SetValue(true)
  self.chkAuto:SetForegroundColour( wx.wxSystemSettings.GetColour( wx.wxSYS_COLOUR_WINDOWTEXT ) )
  
  self.hszAuto:Add( self.chkAuto, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxLEFT), 5 )
  
  self.txtAuto = wx.wxTextCtrl( lframe, wx.wxID_ANY, "", wx.wxDefaultPosition, wx.wxSize( 32,-1 ), wx.wxTE_RIGHT )
  self.hszAuto:Add( self.txtAuto, 0,  bit.bor(wx.wxBOTTOM,wx.wxTOP), 5 )
  
  self.lblAuto = wx.wxStaticText( lframe, wx.wxID_ANY, "URLs", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.lblAuto:Wrap( -1 )
  self.hszAuto:Add( self.lblAuto, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxLEFT), 3 )
  
  self.sbsOpen:Add( self.hszAuto, 0,  bit.bor(wx.wxLEFT,wx.wxRIGHT), 5 )
  
  self.hszConfirm = wx.wxBoxSizer( wx.wxHORIZONTAL )
  
  self.chkConfirm = wx.wxCheckBox( lframe, wx.wxID_ANY, "Confirm before opening more than", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.chkConfirm:SetValue(true)
  self.chkConfirm:SetForegroundColour( wx.wxSystemSettings.GetColour( wx.wxSYS_COLOUR_WINDOWTEXT ) )
  
  self.hszConfirm:Add( self.chkConfirm, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxLEFT), 5 )
  
  self.txtConfirm = wx.wxTextCtrl( lframe, wx.wxID_ANY, "", wx.wxDefaultPosition, wx.wxSize( 32,-1 ), wx.wxTE_RIGHT )
  self.hszConfirm:Add( self.txtConfirm, 0,  bit.bor(wx.wxBOTTOM,wx.wxTOP), 5 )
  
  self.lblConfirm = wx.wxStaticText( lframe, wx.wxID_ANY, "URLs", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.lblConfirm:Wrap( -1 )
  self.hszConfirm:Add( self.lblConfirm, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxLEFT), 3 )
  
  self.sbsOpen:Add( self.hszConfirm, 0,  bit.bor(wx.wxEXPAND,wx.wxLEFT,wx.wxRIGHT), 5 )
    
  self.vszSettings:Add( self.sbsOpen, 0,  bit.bor(wx.wxALL,wx.wxEXPAND), 5 )
  
  self.sbsSearch = wx.wxStaticBoxSizer( wx.wxStaticBox( lframe, wx.wxID_ANY, "Searching for URLs" ), wx.wxVERTICAL )
  
  self.fgsSearch = wx.wxFlexGridSizer( 0, 2, 0, 0 )
  self.fgsSearch:SetFlexibleDirection( wx.wxBOTH )
  self.fgsSearch:SetNonFlexibleGrowMode( wx.wxFLEX_GROWMODE_SPECIFIED )
  
  self.lblPrefixes = wx.wxStaticText( lframe, wx.wxID_ANY, "URL prefixes to search for:", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.lblPrefixes:Wrap( -1 )
  self.fgsSearch:Add( self.lblPrefixes, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxALL), 5 )
  
  self.txtPrefixes = wx.wxTextCtrl( lframe, wx.wxID_ANY, "", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.fgsSearch:Add( self.txtPrefixes, 0,  bit.bor(wx.wxALL,wx.wxEXPAND), 5 )
  
  self.lblSubdomains = wx.wxStaticText( lframe, wx.wxID_ANY, "Subdomains to search for:", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.lblSubdomains:Wrap( -1 )
  self.fgsSearch:Add( self.lblSubdomains, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxALL), 5 )
  
  self.txtSubdomains = wx.wxTextCtrl( lframe, wx.wxID_ANY, "", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.fgsSearch:Add( self.txtSubdomains, 0,  bit.bor(wx.wxALL,wx.wxEXPAND), 5 )
  
  self.lblAttrs = wx.wxStaticText( lframe, wx.wxID_ANY, "HTML attributes to parse:", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.lblAttrs:Wrap( -1 )
  self.fgsSearch:Add( self.lblAttrs, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxALL), 5 )
  
  self.txtAttrs = wx.wxTextCtrl( lframe, wx.wxID_ANY, "", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.fgsSearch:Add( self.txtAttrs, 0,  bit.bor(wx.wxALL,wx.wxEXPAND), 5 )
  
  self.lblLowercase = wx.wxStaticText( lframe, wx.wxID_ANY, "Convert links to lowercase:", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.lblLowercase:Wrap( -1 )
  self.fgsSearch:Add( self.lblLowercase, 0,  bit.bor(wx.wxALIGN_CENTER_VERTICAL,wx.wxALL), 5 )
  
  self.chcLowercaseChoices = {"Never", "If all uppercase", "Always, except filename", "Always"}
  self.chcLowercase = wx.wxChoice( lframe, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, self.chcLowercaseChoices, 0 )
  self.chcLowercase:SetSelection( 0 )
  self.fgsSearch:Add( self.chcLowercase, 0, wx.wxALL, 5 )
    
  self.sbsSearch:Add( self.fgsSearch, 0,  bit.bor(wx.wxEXPAND,wx.wxLEFT,wx.wxRIGHT), 5 )
    
  self.vszSettings:Add( self.sbsSearch, 0,  bit.bor(wx.wxALL,wx.wxEXPAND), 5 )
  
  self.hszButtons = wx.wxBoxSizer( wx.wxHORIZONTAL )
    
  self.hszButtons:Add( 0, 0, 1, wx.wxEXPAND, 5 )
  
  self.btnSave = wx.wxButton( lframe, wx.wxID_ANY, "Save", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.hszButtons:Add( self.btnSave, 0, wx.wxALL, 5 )
  
  self.btnCancel = wx.wxButton( lframe, wx.wxID_ANY, "Cancel", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.hszButtons:Add( self.btnCancel, 0, wx.wxALL, 5 )
    
  self.vszSettings:Add( self.hszButtons, 1, wx.wxEXPAND, 5 )
  
  lframe:SetSizer( self.vszSettings )
  lframe:Layout()
  self.vszSettings:Fit( lframe )
  
  lframe:Centre( wx.wxBOTH )

  -- events

  for _,v in pairs({"Auto", "Confirm"}) do
    self["chk"..v]:Connect(wx.wxEVT_COMMAND_CHECKBOX_CLICKED,
      function(e)
        if e:IsChecked() then
          self["txt"..v]:Enable(true) 
        else 
          self["txt"..v]:Disable()
        end
      end
    )

    self["txt"..v]:Connect(wx.wxEVT_COMMAND_TEXT_UPDATED,
      function(e)
        self["txt"..v]:ChangeValue(self["txt"..v]:GetValue():gsub("[^%d]", ""))
      end
    )
  end

  self.btnSave:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, 
    function(e)
      self:Save()
      self.frame:Destroy()
      self.frame = nil
    end
  )

  self.btnCancel:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED, 
    function(e)
      self.frame:Destroy()
      self.frame = nil
    end
  )

  lframe:Connect(wx.wxEVT_CLOSE_WINDOW, 
    function(e) 
      self.frame:Destroy()
      self.frame = nil
    end
  )

end

function frmSettings:Load()
  local evt = wx.wxCommandEvent(wx.wxEVT_COMMAND_CHECKBOX_CLICKED)
  if not cfg.auto_urls then
    self.chkAuto:SetValue(false)
    wx.wxPostEvent(self.chkAuto, evt)
  else self.txtAuto:SetValue(tostring(cfg.auto_urls)) end
  if not cfg.conf_urls then
    self.chkConfirm:SetValue(false)
    wx.wxPostEvent(self.chkConfirm, evt)
  else self.txtConfirm:SetValue(tostring(cfg.conf_urls)) end
  for k,v in pairs({"Prefixes", "Subdomains", "Attrs"}) do
    self["txt"..v]:SetValue(table.concat(cfg[v:lower()], " "))
  end
  self.chcLowercase:SetSelection(cfg.convert)
end

function frmSettings:Save()
  local new = {}
  if not self.chkAuto:GetValue() or self.chkAuto:GetValue() == "" then 
    new.auto_urls = false
  else 
    new.auto_urls = tonumber(self.txtAuto:GetValue())
  end
  if not self.chkConfirm:GetValue() or self.chkConfirm:GetValue() == "" then
    new.conf_urls = false
  else 
    new.conf_urls = tonumber(self.txtConfirm:GetValue())
  end
  for k,v in pairs({"Prefixes", "Subdomains", "Attrs"}) do
    new[v:lower()] = string.split(self["txt"..v]:GetValue(), " ")
  end
  new.convert = self.chcLowercase:GetSelection()
  cfg:update(new)
  cfg:save()
end

return frmSettings end)
package.preload['frmUrls'] = (function (...)
local frmUrls = {
  clip = wx.wxClipboard.Get(),
  tobj = wx.wxTextDataObject(),
  urls = {},
  search = {},
  search_html = {},
  frame = nil
}

frmUrls.hfmt = wx.wxDataFormat("HTML Format")
frmUrls.hobj = wx.wxLuaDataObjectSimple(frmUrls.hfmt)
frmUrls.hobj.data = ""
function frmUrls.hobj:GetDataHere() return true, self.data end
function frmUrls.hobj:GetDataSize() return self.data:len() end
function frmUrls.hobj:SetData(d) self.data = d return true end

function frmUrls:Show()
  if not self.frame then self:Init() end
  self.lstUrls:InsertItems(self.urls, 0)
  self.frame:Show()
  self.frame:Raise()
end

function frmUrls:Init()
  self.frame = wx.wxFrame(wx.NULL,
    wx.wxID_ANY,
    "Select links to open...",
    wx.wxDefaultPosition,
    wx.wxSize( 360,300 ),
    wx.wxCAPTION + wx.wxCLOSE_BOX + wx.wxFRAME_NO_TASKBAR + wx.wxRESIZE_BORDER + wx.wxSYSTEM_MENU + wx.wxTAB_TRAVERSAL
  )
  local lframe = self.frame
  lframe:SetSizeHints( wx.wxDefaultSize, wx.wxDefaultSize )
  lframe:SetIcon(wx.wxIcon("HANDLR_ICON", wx.wxBITMAP_TYPE_ICO_RESOURCE))
  
  self.vszUrls = wx.wxBoxSizer( wx.wxVERTICAL )
  
  self.lstUrls = wx.wxListBox( lframe, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, {}, wx.wxLB_MULTIPLE )
  self.vszUrls:Add( self.lstUrls, 1,  bit.bor(wx.wxALL,wx.wxEXPAND), 5 )
  
  self.hszButtons = wx.wxBoxSizer( wx.wxHORIZONTAL )
  
  self.btnCancel = wx.wxButton( lframe, wx.wxID_ANY, "Cancel", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.hszButtons:Add( self.btnCancel, 0, wx.wxALL, 5 )
  
  self.hszButtons:Add( 0, 0, 1, wx.wxEXPAND, 5 )
  
  self.btnSelected = wx.wxButton( lframe, wx.wxID_ANY, "Open selected", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxBU_EXACTFIT )
  self.hszButtons:Add( self.btnSelected, 0, wx.wxALL, 5 )
  
  self.btnAll = wx.wxButton( lframe, wx.wxID_ANY, "Open all", wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
  self.hszButtons:Add( self.btnAll, 0, wx.wxALL, 5 )
    
  self.vszUrls:Add( self.hszButtons, 0, wx.wxEXPAND, 5 )
    
  lframe:SetSizer( self.vszUrls )
  lframe:Layout()
  
  lframe:Centre( wx.wxBOTH )

  -- events

  lframe:Connect(wx.wxEVT_CLOSE_WINDOW, 
    function(e) self:Close() end
  )

  self.btnSelected:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED,
    function(e)
      local _, sel = self.lstUrls:GetSelections()
      local urls = {}
      for _,k in pairs(sel) do table.insert(urls, self.urls[k+1]) end
      self:OpenUrls(urls)
      self:Close()
    end
  )

  self.btnAll:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED,
    function(e)
      self:OpenUrls(self.urls)
      self:Close()
    end
  )

  self.btnCancel:Connect(wx.wxEVT_COMMAND_BUTTON_CLICKED,
    function(e)
      self:Close()
    end
  )

end

-- build list of URL patterns to search clipboard for
function frmUrls:BuildSearch()
  self.search, self.search_html = {}, {}
  for _,v in pairs(cfg.prefixes) do 
    table.insert(self.search, string.insens(v).."://[^%s\"']+")
  end
  for _,v in pairs(cfg.subdomains) do 
    table.insert(self.search, string.insens(v)..".[^%s\"']+") 
  end
  for _,v in pairs(cfg.attrs) do 
    for _,w in pairs(self.search) do
      table.insert(self.search_html, string.insens(v).."=[\"']?("..w..")")
    end
  end
end

-- extract URLs from contents of text/HTML on the clipboard
function frmUrls:GetUrls()
  -- parse text on clipboard
  if self.clip:GetData(self.tobj) then
    local data = self.tobj:GetText()
    for _,v in pairs(self.search) do
      for url in data:gmatch(v) do table.insert(self.urls, url) end
    end
  end
  -- parse html on clipboard
  if self.clip:GetData(self.hobj) then
    for _,v in pairs(self.search_html) do
      for url in self.hobj.data:gmatch(v) do table.insert(self.urls, url) end
    end
  end
  for k,v in pairs(self.urls) do
    -- convert URLs to lowercase
    if cfg.convert == 1 then
      if not v:match("[a-z]") then self.urls[k] = v:lower() end
    elseif cfg.convert == 2 then
      local u = string.split(v, "/")
      if #u > 2 then
        for i = 1,#u-1 do u[i] = u[i]:lower() end
        self.urls[k] = table.concat(u, "/")
      end
    elseif cfg.convert == 3 then
      self.urls[k] = v:lower()
    end
    -- prepend http:// to URLs with no prefix for better dupe removal
    if not v:match("://") then self.urls[k] = "http://"..self.urls[k] end
  end
  -- remove duplicates
  self.urls = table.uniq(self.urls)
end

-- check min/max URLs in the config against self.urls, and open them
function frmUrls:OpenUrls(urls)
  if cfg.conf_urls and #urls >= cfg.conf_urls then
    local ok = wx.wxMessageBox(
      "OK to open "..#urls.." URLs?", "Confirm", wx.wxYES_NO
    )
    if ok == wx.wxNO then return end
  end
  for _,v in pairs(urls) do wx.wxLaunchDefaultBrowser(v) end
  self.urls = {}
end

-- destroy this frame
function frmUrls:Close()
  self.urls = {}
  self.frame:Destroy()
  self.frame = nil
end

return frmUrls end)
package.preload['pl.utils'] = (function (...)
--- Generally useful routines.
-- @class module
-- @name pl.utils
local format,gsub,byte = string.format,string.gsub,string.byte
local clock = os.clock
local stdout = io.stdout
local append = table.insert

local collisions = {}

--[[
module ('pl.utils')
]]

local utils = {}

utils._VERSION = "0.9.0"

utils.dir_separator = _G.package.config:sub(1,1)

--- end this program gracefully.
-- @param code The exit code
-- @param msg A message to be printed
-- @param ... extra arguments for fprintf
-- @see utils.fprintf
function utils.quit(code,msg,...)
    if type(code) == 'string' then
        msg = code
        code = -1
    end
    utils.fprintf(io.stderr,msg,...)
    io.stderr:write('\n')
    os.exit(code)
end

--- print an arbitrary number of arguments using a format.
--  @param fmt The format (see string.format)
function utils.printf(fmt,...)
    utils.fprintf(stdout,fmt,...)
end

--- write an arbitrary number of arguments to a file using a format.
-- @param fmt The format (see string.format)
function utils.fprintf(f,fmt,...)
    utils.assert_string(2,fmt)
    f:write(format(fmt,...))
end

local function import_symbol(T,k,v,libname)
    local key = rawget(T,k)
    -- warn about collisions!
    if key and k ~= '_M' and k ~= '_NAME' and k ~= '_PACKAGE' and k ~= '_VERSION' then
        utils.printf("warning: '%s.%s' overrides existing symbol\n",libname,k)
    end
    rawset(T,k,v)
end

local function lookup_lib(T,t)
    for k,v in pairs(T) do
        if v == t then return k end
    end
    return '?'
end

local already_imported = {}

--- take a table and 'inject' it into the local namespace.
-- @param t The Table
-- @param T An optional destination table (defaults to callers environment)
function utils.import(t,T)
    T = T or _G
    t = t or utils
    if type(t) == 'string' then
        t = require (t)
    end
    local libname = lookup_lib(T,t)
    if already_imported[t] then return end
    already_imported[t] = libname
    for k,v in pairs(t) do
        import_symbol(T,k,v,libname)
    end
end

utils.patterns = {
    FLOAT = '[%+%-%d]%d*%.?%d*[eE]?[%+%-]?%d*',
    INTEGER = '[+%-%d]%d*',
    IDEN = '[%a_][%w_]*',
    FILE = '[%a%.\\][:%][%w%._%-\\]*'
}

--- escape any 'magic' characters in a string
-- @param s The input string
function utils.escape(s)
    utils.assert_string(1,s)
    return (s:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]','%%%1'))
end

--- return either of two values, depending on a condition.
-- @param cond A condition
-- @param value1 Value returned if cond is true
-- @param value2 Value returned if cond is false (can be optional)
function utils.choose(cond,value1,value2)
    if cond then return value1
    else return value2
    end
end

--- return the contents of a file as a string
-- @param filename The file path
-- @return file contents
function utils.readfile(filename,is_bin)
    local mode = is_bin and 'b' or ''
    utils.assert_string(1,filename)
    local f,err = io.open(filename,'r'..mode)
    if not f then return utils.raise (err) end
    local res,err = f:read('*a')
    f:close()
    if not res then return raise (err) end
    return res
end

--- write a string to a file
-- @param filename The file path
-- @param str The string
function utils.writefile(filename,str)
    utils.assert_string(1,filename)
    utils.assert_string(2,str)
    local f,err = io.open(filename,'w')
    if not f then return raise(err) end
    f:write(str)
    f:close()
    return true
end

--- return the contents of a file as a list of lines
-- @param filename The file path
-- @return file contents as a table
function utils.readlines(filename)
    utils.assert_string(1,filename)
    local f,err = io.open(filename,'r')
    if not f then return raise(err) end
    local res = {}
    for line in f:lines() do
        append(res,line)
    end
    f:close()
    return res
end

--- split a string into a list of strings separated by a delimiter.
-- @param s The input string
-- @param re A regular expression; defaults to spaces
-- @return a list-like table
function utils.split(s,re)
    utils.assert_string(1,s)
    local i1 = 1
    local ls = {}
    if not re then re = '%s+' end
    if re == '' then return {s} end
    while true do
        local i2,i3 = s:find(re,i1)
        if not i2 then
            local last = s:sub(i1)
            if last ~= '' then append(ls,last) end
            if #ls == 1 and ls[1] == '' then
                return {}
            else
                return ls
            end
        end
        append(ls,s:sub(i1,i2-1))
        i1 = i3+1
    end
end


--- split a string into a number of values.
-- @param s the string
-- @param re the delimiter, default space
-- @return n values
-- @usage first,next = splitv('jane:doe',':')
-- @see split
function utils.splitv (s,re)
    return unpack(utils.split(s,re))
end

if not loadin then
    function loadin(env,str,src)
        local chunk,err
        if type(str) == 'string' then
            chunk,err = loadstring(str,src)
        else
            chunk,err = load(str,src)
        end
        if chunk then setfenv(chunk,env) end
        return chunk,err
    end
end

if not table.pack then
    function table.pack (...)
        return {n=select('#',...); ...}
    end
end
if not table.pack then table.pack = pack end
if not pack then pack = table.pack end

--- take an arbitrary set of arguments and make into a table.
-- This returns the table and the size; works fine for nil arguments
-- @param ... arguments
-- @return table
-- @return table size
-- @usage local t,n = utils.args(...)

--- 'memoize' a function (cache returned value for next call).
-- This is useful if you have a function which is relatively expensive,
-- but you don't know in advance what values will be required, so
-- building a table upfront is wasteful/impossible.
-- @param func a function of at least one argument
-- @return a function with at least one argument, which is used as the key.
function utils.memoize(func)
    return setmetatable({}, {
        __index = function(self, k, ...)
            local v = func(k,...)
            self[k] = v
            return v
        end,
        __call = function(self, k) return self[k] end
    })
end

--- is the object either a function or a callable object?.
function utils.is_callable (obj)
    return type(obj) == 'function' or getmetatable(obj) and getmetatable(obj).__call
end

--- is the object of the specified type?.
-- If the type is a string, then use type, otherwise compare with metatable
-- @param obj an object
-- @param tp a type
function utils.is_type (obj,tp)
    if type(tp) == 'string' then return type(obj) == tp end
    local mt = getmetatable(obj)
    return tp == mt
end

utils.stdmt = { List = {}, Map = {}, Set = {}, MultiMap = {} }

local _function_factories = {}

function utils.add_function_factory (mt,fun)
    _function_factories[mt] = fun
end

local function _string_lambda(f)
    local raise = utils.raise
    if f:find '^|' then
        local args,body = f:match '|([^|]*)|(.+)'
        if not args then return raise 'bad string lambda' end
        local fstr = 'return function('..args..') return '..body..' end'
        local fn,err = loadstring(fstr)
        if not fn then return raise(err) end
        fn = fn()
        return fn
    else return raise 'not a string lambda'
    end
end

utils.string_lambda = utils.memoize(_string_lambda)

local ops

--- process a function argument. 
-- This is used throughout Penlight and defines what is meant by a function: 
-- Something that is callable, or an operator string as defined by <code>pl.operator</code>, 
-- such as '>' or '#'.
-- @param idx argument index
-- @param f a function, operator string, or callable object
-- @param msg optional error message
-- @return a callable
-- @see utils.is_callable
function utils.function_arg (idx,f)
    utils.assert_arg(1,idx,'number')
    if not msg then msg = " must be callable" end
    local tp = type(f)
    if tp == 'function' then return f end  -- no worries!
    -- ok, a string can correspond to an operator (like '==')
    if tp == 'string' then
        if not ops then ops = require 'pl.operator'.optable end
        local fn = ops[f]
        if fn then return fn end
    elseif tp == 'table' or tp == 'userdata' then
        local mt = getmetatable(f)
        if not mt then error('not a callable object') end
        local ff = _function_factories[mt]
        if not ff then
            if not mt.__call then error('not a callable object',2) end
            return f
        else
            return ff(f) -- we have a function factory for this type!
        end
    end
    if idx > 0 then        
        error("argument "..idx..": "..msg,2)
    else
        error(msg,2)    
    end
end

--- bind the first argument of the function to a value.
-- @param fn a function of at least two values (may be an operator string)
-- @param p a value
-- @return a function such that f(x) is fn(p,x)
-- @see pl.func.curry
function utils.bind1 (fn,p)
    fn = utils.function_arg(1,fn)
    return function(...) return fn(p,...) end
end

--- assert that the given argument is in fact of the correct type.
-- @param n argument index
-- @param val the value
-- @param tp the type
-- @param verify an optional verfication function
-- @param msg an optional custom message
-- @param lev optional stack position for trace, default 2
-- @usage assert_arg(1,t,'table')
-- @usage assert_arg(n,val,'string',path.isdir,'not a directory')
function utils.assert_arg (n,val,tp,verify,msg,lev)
    if type(val) ~= tp then
        error(("argument %d expected a '%s', got a '%s'"):format(n,tp,type(val)),2)
    end
    if verify and not verify(val) then
        error(("argument %d: '%s' %s"):format(n,val,msg),lev or 2)
    end
end

--- assert the common case that the argument is a string.
-- @param n argument index
-- @param val a value that must be a string
function utils.assert_string (n,val)
    utils.assert_arg(n,val,'string',nil,nil,nil,3)
end

local err_mode = 'default'

--- control the error strategy used by Penlight. 
-- Controls how <code>utils.raise</code> works; the default is for it
-- to return nil and the error string, but if the mode is 'error' then
-- it will throw an error. If mode is 'quit' it will immediately terminate
-- the program.
-- @param mode - either 'default', 'quit'  or 'error'
-- @see utils.raise
function utils.on_error (mode)
    err_mode = mode
end

--- used by Penlight functions to return errors.  Its global behaviour is controlled
-- by <code>utils.on_error</code>
-- @param err the error string.
-- @see utils.on_error
function utils.raise (err)
    if err_mode == 'default' then return nil,err
    elseif err_mode == 'quit' then quit(err)
    else error(err,2)
    end
end

return utils


 end)
package.preload['pl.lexer'] = (function (...)
--- Lexical scanner for creating a sequence of tokens from text. <br>
-- <p><code>lexer.scan(s)</code> returns an iterator over all tokens found in the 
-- string <code>s</code>. This iterator returns two values, a token type string 
-- (such as 'string' for quoted string, 'iden' for identifier) and the value of the 
-- token.
-- <p>
-- Versions specialized for Lua and C are available; these also handle block comments
-- and classify keywords as 'keyword' tokens. For example: 
-- <pre class=example>
-- > s = 'for i=1,n do'
-- > for t,v in lexer.lua(s)  do print(t,v) end
-- keyword for
-- iden    i 
-- =       = 
-- number  1
-- ,       , 
-- iden    n
-- keyword do 
-- </pre>
-- See the Guide for further <a href="../../index.html#lexer">discussion</a> <br>
-- @class module
-- @name pl.lexer

local yield,wrap = coroutine.yield,coroutine.wrap
local strfind = string.find
local strsub = string.sub
local append = table.insert
--[[
module ('pl.lexer',utils._module)
]]

local function assert_arg(idx,val,tp)
    if type(val) ~= tp then
        error("argument "..idx.." must be "..tp, 2)
    end
end

local lexer = {}

local NUMBER1 = '^[%+%-]?%d+%.?%d*[eE][%+%-]?%d+'
local NUMBER2 = '^[%+%-]?%d+%.?%d*'
local NUMBER3 = '^0x[%da-fA-F]+'
local IDEN = '^[%a_][%w_]*'
local WSPACE = '^%s+'
local STRING1 = "^'.-[^\\]'"
local STRING2 = '^".-[^\\]"'
local STRING3 = '^[\'"][\'"]'
local PREPRO = '^#.-[^\\]\n'

local plain_matches,lua_matches,cpp_matches,lua_keyword,cpp_keyword

local function tdump(tok)
    return yield(tok,tok)
end

local function ndump(tok,options)
    if options and options.number then
        tok = tonumber(tok)
    end
    return yield("number",tok)
end

-- regular strings, single or double quotes; usually we want them
-- without the quotes
local function sdump(tok,options)
    if options and options.string then
        tok = tok:sub(2,-2)
    end
    return yield("string",tok)
end

-- long Lua strings need extra work to get rid of the quotes
local function sdump_l(tok,options)
    if options and options.string then
        tok = tok:sub(3,-3)
    end
    return yield("string",tok)
end

local function chdump(tok,options)
    if options and options.string then
        tok = tok:sub(2,-2)
    end
    return yield("char",tok)
end

local function cdump(tok)
    return yield('comment',tok)
end

-- handling line comments - want to trim off the excess whitespace (and linefeed)
-- and make it a separate space token. Needed because these patterns grab 
-- upto and including the line end.
local function cdump_line(tok)
    local s1 = tok:find '%s*$'
    yield("comment",tok:sub(1,s1-1))
    return yield("space",tok:sub(s1))
end

local function wsdump (tok)
    return yield("space",tok)
end

local function pdump (tok)
    return yield('prepro',tok)
end

local function plain_vdump(tok)
    return yield("iden",tok)
end

local function lua_vdump(tok)
    if lua_keyword[tok] then
        return yield("keyword",tok)
    else
        return yield("iden",tok)
    end
end

local function cpp_vdump(tok)
    if cpp_keyword[tok] then
        return yield("keyword",tok)
    else
        return yield("iden",tok)
    end
end

--- create a plain token iterator from a string or file-like object.
-- @param s the string
-- @param matches an optional match table (set of pattern-action pairs)
-- @param filter a table of token types to exclude, by default {space=true}
-- @param options a table of options; by default, {number=true,string=true},
-- which means convert numbers and strip string quotes.
function lexer.scan (s,matches,filter,options)
    --assert_arg(1,s,'string')
    local file = type(s) ~= 'string' and s
    filter = filter or {space=true}
    options = options or {number=true,string=true}
    if filter then
        if filter.space then filter[wsdump] = true end
        if filter.comments then
            filter[cdump] = true
            filter[cdump_line] = true
        end
    end
    if not matches then
        if not plain_matches then
            plain_matches = {
                {WSPACE,wsdump},
                {NUMBER3,ndump},
                {IDEN,plain_vdump},
                {NUMBER1,ndump},
                {NUMBER2,ndump},
                {STRING3,sdump},
                {STRING1,sdump},
                {STRING2,sdump},
                {'^.',tdump}
            }
        end
        matches = plain_matches
    end
    function lex ()
        local i1,i2,idx,res1,res2,tok,pat,fun,capt
        local line = 1
        if file then s = file:read()..'\n' end
        local sz = #s
        local idx = 1
        --print('sz',sz)
        while true do
            for _,m in ipairs(matches) do
                pat = m[1]
                fun = m[2]
                i1,i2 = strfind(s,pat,idx)
                if i1 then
                    tok = strsub(s,i1,i2)
                    idx = i2 + 1
                    if not (filter and filter[fun]) then
                        lexer.finished = idx > sz
                        res1,res2 = fun(tok,options)
                    end
                    if res1 then
                        local tp = type(res1)
                        -- insert a token list
                        if tp=='table' then
                            yield('','')
                            for _,t in ipairs(res1) do
                                yield(t[1],t[2])
                            end
                        elseif tp == 'string' then -- or search up to some special pattern
                            i1,i2 = strfind(s,res1,idx)
                            if i1 then
                                tok = strsub(s,i1,i2)
                                idx = i2 + 1
                                yield('',tok)
                            else
                                yield('','')
                                idx = sz + 1
                            end
                            --if idx > sz then return end
                        else
                            yield(line,idx)
                        end
                    end
                    if idx > sz then
                        if file then
                            repeat -- next non-empty line
                                line = line + 1
                                s = file:read()
                                if not s then return end
                            until not s:match '^%s*$'
                            s = s .. '\n'
                            idx ,sz = 1,#s
                            break
                        else
                            return
                        end
                    else break end
                end
            end
        end
    end
    return wrap(lex)
end

local function isstring (s)
    return type(s) == 'string'
end

--- insert tokens into a stream.
-- @param tok a token stream
-- @param a1 a string is the type, a table is a token list and
-- a function is assumed to be a token-like iterator (returns type & value)
-- @param a2 a string is the value
function lexer.insert (tok,a1,a2)
    if not a1 then return end
    local ts
    if isstring(a1) and isstring(a2) then
        ts = {{a1,a2}}
    elseif type(a1) == 'function' then
        ts = {}
        for t,v in a1() do
            append(ts,{t,v})
        end
    else
        ts = a1
    end
    tok(ts)
end

--- get everything in a stream upto a newline.
-- @param tok a token stream
-- @return a string
function lexer.getline (tok)
    local t,v = tok('.-\n')
    return v
end

--- get current line number. <br>
-- Only available if the input source is a file-like object.
-- @param tok a token stream
-- @return the line number and current column
function lexer.lineno (tok)
    return tok(0)
end

--- get the rest of the stream.
-- @param tok a token stream
-- @return a string
function lexer.getrest (tok)
    local t,v = tok('.+')
    return v
end

--- get the Lua keywords as a set-like table.
-- So <code>res["and"]</code> etc would be <code>true</code>.
-- @return a table
function lexer.get_keywords ()
    if not lua_keyword then
        lua_keyword = {
            ["and"] = true, ["break"] = true,  ["do"] = true,
            ["else"] = true, ["elseif"] = true, ["end"] = true,
            ["false"] = true, ["for"] = true, ["function"] = true,
            ["if"] = true, ["in"] = true,  ["local"] = true, ["nil"] = true,
            ["not"] = true, ["or"] = true, ["repeat"] = true,
            ["return"] = true, ["then"] = true, ["true"] = true,
            ["until"] = true,  ["while"] = true
        }
    end
    return lua_keyword
end


--- create a Lua token iterator from a string or file-like object.
-- Will return the token type and value.
-- @param s the string
-- @param filter a table of token types to exclude, by default {space=true,comments=true}
-- @param options a table of options; by default, {number=true,string=true},
-- which means convert numbers and strip string quotes.
function lexer.lua(s,filter,options)
    filter = filter or {space=true,comments=true}
    lexer.get_keywords()
    if not lua_matches then
        lua_matches = {
            {WSPACE,wsdump},
            {NUMBER3,ndump},
            {IDEN,lua_vdump},
            {NUMBER1,ndump},
            {NUMBER2,ndump},
            {STRING3,sdump},
            {STRING1,sdump},
            {STRING2,sdump},
            {'^%-%-.-\n',cdump_line},
            {'^%[%[.+%]%]',sdump_l},
            {'^%-%-%[%[.+%]%]',cdump},
            {'^==',tdump},
            {'^~=',tdump},
            {'^<=',tdump},
            {'^>=',tdump},
            {'^%.%.%.',tdump},
            {'^.',tdump}
        }
    end
    return lexer.scan(s,lua_matches,filter,options)
end

--- create a C/C++ token iterator from a string or file-like object.
-- Will return the token type type and value.
-- @param s the string
-- @param filter a table of token types to exclude, by default {space=true,comments=true}
-- @param options a table of options; by default, {number=true,string=true},
-- which means convert numbers and strip string quotes.
function lexer.cpp(s,filter,options)
    filter = filter or {comments=true}
    if not cpp_keyword then
        cpp_keyword = {
            ["class"] = true, ["break"] = true,  ["do"] = true, ["sizeof"] = true,
            ["else"] = true, ["continue"] = true, ["struct"] = true,
            ["false"] = true, ["for"] = true, ["public"] = true, ["void"] = true,
            ["private"] = true, ["protected"] = true, ["goto"] = true,
            ["if"] = true, ["static"] = true,  ["const"] = true, ["typedef"] = true,
            ["enum"] = true, ["char"] = true, ["int"] = true, ["bool"] = true,
            ["long"] = true, ["float"] = true, ["true"] = true, ["delete"] = true,
            ["double"] = true,  ["while"] = true, ["new"] = true, 
            ["namespace"] = true, ["try"] = true, ["catch"] = true,
            ["switch"] = true, ["case"] = true, ["extern"] = true,
            ["return"] = true,["default"] = true,['unsigned']  = true,['signed'] = true,
            ["union"] =  true, ["volatile"] = true, ["register"] = true,["short"] = true,
        }
    end
    if not cpp_matches then
        cpp_matches = {
            {WSPACE,wsdump},
            {PREPRO,pdump},
            {NUMBER3,ndump},
            {IDEN,cpp_vdump},
            {NUMBER1,ndump},
            {NUMBER2,ndump},
            {STRING3,sdump},
            {STRING1,chdump},
            {STRING2,sdump},
            {'^//.-\n',cdump_line},
            {'^/%*.-%*/',cdump},
            {'^==',tdump},
            {'^!=',tdump},
            {'^<=',tdump},
            {'^>=',tdump},
            {'^->',tdump},
            {'^&&',tdump},
            {'^||',tdump},
            {'^%+%+',tdump},
            {'^%-%-',tdump},
            {'^%+=',tdump},
            {'^%-=',tdump},
            {'^%*=',tdump},
            {'^/=',tdump},
            {'^|=',tdump},
            {'^%^=',tdump},
            {'^::',tdump},
            {'^.',tdump}
        }
    end
    return lexer.scan(s,cpp_matches,filter,options)
end

--- get a list of parameters separated by a delimiter from a stream.
-- @param tok the token stream
-- @param endtoken end of list (default ')'). Can be '\n'
-- @param delim separator (default ',')
-- @return a list of token lists.
function lexer.get_separated_list(tok,endtoken,delim)
    endtoken = endtoken or ')'
    delim = delim or ','
    local parm_values = {}
    local level = 1 -- used to count ( and )
    local tl = {}
    local function tappend (tl,t,val)
        val = val or t
        append(tl,{t,val})
    end
    local is_end
    if endtoken == '\n' then
        is_end = function(tok,val)
            return tok == 'space' and val:find '\n'
        end
    else
        is_end = function (tok)
            return tok == endtoken
        end
    end
    while true do
        token,value=tok()
        if not token then return end -- end of stream is an error!
        if token == '(' then
            level = level + 1
            tappend(tl,'(')
        elseif token == ')' then
            level = level - 1
            if level == 0 then -- finished with parm list
                append(parm_values,tl)
                break
            else
                tappend(tl,')')
            end
        elseif token == delim and level == 1 then
            append(parm_values,tl) -- a new parm
            tl = {}
        elseif is_end(token,value) and level == 1 then
            append(parm_values,tl)
            break
        else
            tappend(tl,token,value)
        end
    end
    return parm_values
end

--- get the next non-space token from the stream.
-- @param tok the token stream.
function lexer.skipws (tok)
    local t,v = tok()
    while t == 'space' do
        t,v = tok()
    end
    return t,v
end

local skipws = lexer.skipws

--- get the next token, which must be of the expected type.
-- Throws an error if this type does not match!
-- @param tok the token stream
-- @param expected_type the token type
-- @param no_skip_ws whether we should skip whitespace
function lexer.expecting (tok,expected_type,no_skip_ws)
    assert_arg(1,tok,'function')
    assert_arg(2,expected_type,'string')
    local t,v
    if no_skip_ws then
        t,v = tok()
    else
        t,v = skipws(tok)
    end
    if t ~= expected_type then error ("expecting "..expected_type,2) end
    return v
end

return lexer
 end)
package.preload['pl.pretty'] = (function (...)
--- Pretty-printing Lua tables.
-- @class module
-- @name pl.pretty

local append = table.insert
local concat = table.concat
local utils = require 'pl.utils'
local lexer = require 'pl.lexer'
local assert_arg = utils.assert_arg

--[[
module('pl.pretty',utils._module)
]]

local pretty = {}

--- read a string representation of a Lua table.
-- Uses loadstring, but tries to be cautious about loading arbitrary code!
-- It is expecting a string of the form '{...}', with perhaps some whitespace
-- before or after the curly braces. An empty environment is used, and
-- any occurance of the keyword 'function' will be considered a problem.
-- @param s {string} string of the form '{...}', with perhaps some whitespace
--		before or after the curly braces.
function pretty.read(s)
    assert_arg(1,s,'string')
    if not s:find '^%s*%b{}%s*$' then return nil,"not a Lua table" end
    if s:find '[^\'"%w_]function[^\'"%w_]' then
        local tok = lexer.lua(s)
        for t,v in tok do
            if t == 'keyword' then
                return nil,"cannot have Lua keywords in table definition"
            end
        end
    end
    local chunk,err = loadin({},'return '..s,'tbl')
    if not chunk then return nil,err end
    return chunk()
end

local function quote_if_necessary (v)
    if not v then return ''
    else
        if v:find ' ' then v = '"'..v..'"' end
    end
    return v
end

local keywords


---	Create a string representation of a Lua table.
--	@param tbl {table} Table to serialize to a string.
--	@param space {string} (optional) The indent to use.
--		Defaults to two spaces.
--	@param not_clever {bool} (optional) Use for plain output, e.g {['key']=1}.
--		Defaults to false.
function pretty.write (tbl,space,not_clever)
    assert_arg(1,tbl,'table')
    if not keywords then
        keywords = lexer.get_keywords()
    end
    space = space or '  '
    local lines = {}
    local line = ''
    local tables = {}

    local function is_identifier (s)
        return (s:find('^[%a_][%w_]*$')) and not keywords[s]
    end

    local function put(s)
        if #s > 0 then
            line = line..s
        end
    end

    local function putln (s)
        if #line > 0 then
            line = line..s
            append(lines,line)
            line = ''
        else
            append(lines,s)
        end
    end

    local function eat_last_comma ()
        local n,lastch = #lines
        local lastch = lines[n]:sub(-1,-1)
        if lastch == ',' then
            lines[n] = lines[n]:sub(1,-2)
        end
    end

    local function quote (s)
        return ('%q'):format(tostring(s))
    end

    local function index (numkey,key)
        if not numkey then key = quote(key) end
        return '['..key..']'
    end

    local writeit
    writeit = function (t,oldindent,indent)
        local tp = type(t)
        if tp ~= 'string' and  tp ~= 'table' then
            putln(quote_if_necessary(tostring(t))..',')
        elseif tp == 'string' then
            if t:find('\n') then
                putln('[[\n'..t..']],')
            else
                putln(quote(t)..',')
            end
        elseif tp == 'table' then
            if tables[t] then
                putln('<cycle>,')
                return
            end
            tables[t] = true
            local newindent = indent..space
            putln('{')
            local max = 0
            if not not_clever then
                for i,val in ipairs(t) do
                    put(indent)
                    writeit(val,indent,newindent)
                    max = i
                end
            end
            for key,val in pairs(t) do
                local numkey = type(key) == 'number'
                if not_clever then
                    key = tostring(key)
                    put(indent..index(numkey,key)..' = ')
                    writeit(val,indent,newindent)
                else
                    if not numkey or key < 1 or key > max then -- non-array indices
                        if numkey or not is_identifier(key) then
                            key = index(numkey,key)
                        end
                        put(indent..key..' = ')
                        writeit(val,indent,newindent)
                    end
                end
            end
            eat_last_comma()
            putln(oldindent..'},')
        else
            putln(tostring(t)..',')
        end
    end
    writeit(tbl,'',space)
    eat_last_comma()
    return concat(lines,#space > 0 and '\n' or '')
end

---	Dump a Lua table out to a file or stdout.
--	@param t {table} The table to write to a file or stdout.
--	@param ... {string} (optional) File name to write too. Defaults to writing
--		to stdout.
function pretty.dump (t,...)
    if select('#',...) == 0 then
        print(pretty.write(t))
        return true
    else
        return utils.writefile((select(1,...)),pretty.write(t))
    end
end

return pretty
 end)
-- handlr 0.4.0 (20120416)
-- http://b23.be/handlr
-- strawman at b23 dot be

-- TODO:
-- ~~ use wxConfig instead of pl.pretty?
-- ++ write tests

function table.contains(tbl, val)
  for _,v in pairs(tbl) do
    if v == val then return true end
  end
  return false
end

function table.uniq(tbl)
  local new = {}
  for _,v in pairs(tbl) do
    if not table.contains(new, v) then table.insert(new, v) end
  end
  return new
end

function string.split(str, dlm)
  new = {}
  for str in str:gmatch("[^"..dlm.."]+") do table.insert(new,str) end
  return new
end

function string.insens(str)
  return str.gsub(str, "%w", function(c)
    return(string.format("[%s%s]", c:lower(), c:upper()))
  end)
end

--

require("wx")
local frmUrls     = require("frmUrls")
local frmSettings = require("frmSettings")
local pp          = require("pl.pretty")
local NO_PORTABLE = false  -- do this with getenv

-- config

cfg = {
  auto_urls  = 2,
  conf_urls  = 10,
  prefixes   = {"http", "https"},
  subdomains = {"www"},
  attrs      = {"href", "src"},
  convert    = 0
}

setmetatable(cfg, {__index = {

  file = "",

  dir = function()
    return NO_PORTABLE and 
    wx.wxStandardPaths.Get():GetUserDataDir() or
    wx.wxStandardPaths.Get():GetLocalDataDir()
  end,

  update = function(self,tbl)
    for k,v in pairs(tbl) do self[k] = v end
  end,

  load = function(self, file)
    if not file then file = self.dir() .. "/handlr.cfg" end
    getmetatable(self).__index.file = file
    local cnf = io.open(file, "r")
    if not cnf then return end
    local str = cnf:read("*all")
    cnf:close()
    local tbl = pp.read(str)
    if not tbl then return end
    self:update(tbl)
  end,

  save = function(self, file)
    if not file then file = self.file end
    pp.dump(self, file)
    frmUrls:BuildSearch()
  end

}})

-- tray icon

local trayicon = wx.wxTaskBarIcon()
function trayicon:init()
  self:SetIcon(wx.wxIcon("HANDLR_ICON", wx.wxBITMAP_TYPE_ICO_RESOURCE), "handlr")

  self.menu = wx.wxMenu()
  self.menu_opts  = wx.wxMenuItem(self.menu, wx.wxID_ANY, "Settings")
  self.menu_about = wx.wxMenuItem(self.menu, wx.wxID_ANY, "About")
  self.menu_quit  = wx.wxMenuItem(self.menu, wx.wxID_ANY, "Quit")
  self.menu:Append(self.menu_opts)
  self.menu:Append(self.menu_about)
  self.menu:Append(self.menu_quit)

  self:Connect(wx.wxEVT_TASKBAR_RIGHT_DOWN, 
    function(e)
      self.PopupMenu(self, self.menu)
    end
  )

  self:Connect(wx.wxEVT_TASKBAR_LEFT_DOWN,
    function(e) 
      frmUrls:GetUrls()
      if #frmUrls.urls == 0 then
        -- show notification
        return
      end
      if cfg.auto_urls and #frmUrls.urls <= cfg.auto_urls then
        frmUrls:OpenUrls(frmUrls.urls)
        return
      end
      frmUrls:Show()
    end
  )

  self:Connect(self.menu_opts:GetId(), wx.wxEVT_COMMAND_MENU_SELECTED,
    function(e) frmSettings:Show() end
  )

  self:Connect(self.menu_about:GetId(), wx.wxEVT_COMMAND_MENU_SELECTED,
    function(e) wx.wxLaunchDefaultBrowser("http://b23.be/handlr") end
  )

  self:Connect(self.menu_quit:GetId(), wx.wxEVT_COMMAND_MENU_SELECTED,
    function(e) wx.wxGetApp():ExitMainLoop() end
  )

end

-- let's go

cfg:load()
frmUrls:BuildSearch()
trayicon:init()
wx.wxGetApp():MainLoop()