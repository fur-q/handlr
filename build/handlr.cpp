#include "wx/wxprec.h"

#ifdef __BORLANDC__
    #pragma hdrstop
#endif

#ifndef WX_PRECOMP
    #include "wx/wx.h"
#endif

#ifdef __WXGTK__
#include <locale.h>
#endif

#include "wx/app.h"
#include "wx/image.h"
#include "wx/file.h"
#include "wx/filename.h"
#include "wxlua/include/wxlua.h"
#include "wxlua/include/wxlstate.h"

#include "wxbind/include/wxbinddefs.h"
WXLUA_DECLARE_BIND_STD

class HandlrApp : public wxApp {
public:
    bool OnInit();
    int  OnExit();
    void OnLua(wxLuaEvent &event);
    void OutputPrint(const wxString& str);
    wxLuaState m_wxlState;

private:
    DECLARE_EVENT_TABLE();
};

DECLARE_APP(HandlrApp)

IMPLEMENT_APP(HandlrApp)

BEGIN_EVENT_TABLE(HandlrApp, wxApp)
    EVT_LUA_PRINT       (wxID_ANY, HandlrApp::OnLua)
    EVT_LUA_ERROR       (wxID_ANY, HandlrApp::OnLua)
END_EVENT_TABLE()

bool HandlrApp::OnInit() {
#ifdef __WXGTK__
    setlocale(LC_NUMERIC, "C");
#endif
    wxInitAllImageHandlers();
    WXLUA_IMPLEMENT_BIND_STD

    wxLuaState::sm_wxAppMainLoop_will_run = true;

    m_wxlState = wxLuaState(this, wxID_ANY);
    if (!m_wxlState.Ok())
        return false;

#include "handlr.h"
//    m_wxlState.RunBuffer((const char*)B1,sizeof(B1),wxT("handlr.lua"));

    wxWindowList::compatibility_iterator node = wxTopLevelWindows.GetFirst();
    if (node)
        return true;

    return false;
}

int HandlrApp::OnExit() {
    if (m_wxlState.Ok())
        m_wxlState.CloseLuaState(true);

    return wxApp::OnExit();
}

void HandlrApp::OnLua(wxLuaEvent &event) {
    OutputPrint(event.GetString());
}

void HandlrApp::OutputPrint(const wxString& str) {
#ifdef __WXMSW__
    wxMessageBox(str);
#else
    wxPrintf(wxT("%s\n"), str.c_str());
#endif
}
