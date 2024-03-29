-- handlr 0.5 (2012/05/03)
-- http://b23.be/handlr
-- by strawman at b23 dot be

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
  local new = {}
  for s in str:gmatch("[^"..dlm.."]+") do table.insert(new,s) end
  return new
end

function string.insens(str)
  return str.gsub(str, "%a", function(c)
    return(string.format("[%s%s]", c:lower(), c:upper()))
  end)
end

--

require("wx")
local frmUrls     = require("frmUrls")
local frmSettings = require("frmSettings")
local pp          = require("pl.pretty")

IS_WINDOWS = wx.wxPlatformInfo.Get():GetOperatingSystemFamilyName() == "Windows"

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

  dir = H_DIR or wx.wxStandardPaths.Get():GetLocalDataDir(),

  update = function(self,tbl)
    for k,v in pairs(tbl) do self[k] = v end
  end,

  load = function(self, file)
    if not file then file = self.dir .. "/handlr.cfg" end
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
  
  if IS_WINDOWS then
    self:SetIcon(wx.wxIcon("HANDLR_ICON", wx.wxBITMAP_TYPE_ICO_RESOURCE), "handlr")
  else
    -- get directory
    self:SetIcon(wx.wxIcon("handlr.png"), wxBITMAP_TYPE_PNG)
  end

  self.menu = wx.wxMenu()
  self.menu_opts  = wx.wxMenuItem(self.menu, wx.wxID_ANY, "Settings")
  self.menu_about = wx.wxMenuItem(self.menu, wx.wxID_ANY, "About")
  self.menu_quit  = wx.wxMenuItem(self.menu, wx.wxID_ANY, "Exit")
  self.menu:Append(self.menu_opts)
  self.menu:AppendSeparator()
  self.menu:Append(self.menu_about)
  self.menu:Append(self.menu_quit)

  self.none = wx.wxMenu()
  self.none:Append(wx.wxMenuItem(self.none, wx.wxID_ANY, "No URLs on clipboard."))

  self:Connect(wx.wxEVT_TASKBAR_RIGHT_DOWN, 
    function(e)
      self.PopupMenu(self, self.menu)
    end
  )

  self:Connect(wx.wxEVT_TASKBAR_LEFT_DOWN,
    function(e) 
      frmUrls:GetUrls()
      if #frmUrls.urls == 0 then
        self.PopupMenu(self, self.none)
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