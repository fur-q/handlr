# handlr
[http://b23.be/handlr](http://b23.be/handlr)

## What it does

handlr is a tool for batch opening URLs.  It sits in your systray and finds any URLs in your clipboard, presents them all, and gives the ability to send some or all of them to the default browser.

Firefox and Chrome users can also copy a segment of a webpage, and handlr will find any URLs contained within the HTML.  (Opera doesn't put HTML content onto the clipboard, and IE/Safari haven't been tested.)

Handlr is written in [wxLua](http://wxlua.sourceforge.net).  A Windows build is available in the Downloads section.

## What it doesn't do (yet)

- No Unicode support (appears to be a wxLua issue, working on it)
- No Linux build (should build fine, but HTML clipboard support probably won't work)
- No website (coming soon)
- No cross-platform build system (coming soon)
- No automated tests