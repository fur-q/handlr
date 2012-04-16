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

function string.split(str)
  new = {}
  for str in str:gmatch("%w+") do table.insert(new,str) end
  return new
end

--

package.path = package.path..";D:/mirror/dev/handlr/?.lua"  -- deleteme

require("wx")
local frmUrls     = require("frmUrls")
local frmSettings = require("frmSettings")
local pp          = require("pl.pretty")
local PORTABLE    = true

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
  file = nil,
  dir = function()
    return PORTABLE and 
    wx.wxStandardPaths.Get():GetLocalDataDir() or
    wx.wxStandardPaths.Get():GetUserDataDir()
  end,
  update = function(self,tbl)
    for k,v in pairs(tbl) do self[k] = v end
  end,
  load = function(self, file)
    if not file then file = self.dir() .. "/handlr.cfg" end
    self.file = file
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
        -- show balloon notification
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