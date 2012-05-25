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

  if IS_WINDOWS then
    lframe:SetIcon(wx.wxIcon("HANDLR_ICON", wx.wxBITMAP_TYPE_ICO_RESOURCE))
  else
    lframe:SetIcon(wx.wxIcon("handlr.png"))
  end
  
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
    table.insert(self.search, string.insens(v).."://[^%s/$.?#]+%.[^%s\"']+")
  end
  for _,v in pairs(cfg.subdomains) do 
    table.insert(self.search, string.insens(v).."%.[^%s\"']+") 
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

return frmUrls