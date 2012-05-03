# handlr
[http://b23.be/handlr](http://b23.be/handlr)

## What it does

handlr is a tool for batch opening URLs.  It sits in your systray and finds any URLs in your clipboard, presents them all, and gives the ability to send some or all of them to the default browser.

Firefox and Chrome users can also copy a segment of a webpage, and handlr will find any URLs contained within the HTML.  Any other application (such as Thunderbird) which uses the same HTML clipboard format will work equally well.

handlr is written in Lua, using wxWidgets via [wxLua](http://wxlua.sourceforge.net).  A Windows build is available in the Downloads section.

## What it doesn't do (yet)

- No Linux build (coming soon)
- No website (coming soon)
- No proper build system
- No automated tests