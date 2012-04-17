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
  
  self.sbsSearch = wx.wxStaticBoxSizer( wx.wxStaticBox( lframe, wx.wxID_ANY, "Searching for urls" ), wx.wxVERTICAL )
  
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

return frmSettings