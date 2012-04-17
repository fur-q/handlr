taskkill /im "HANDLR.EXE"
cd ..
lua squish.lua --no-minify
cd build
del *.o *.o.d *.h
lua bin2c.lua build-handlr.lua > handlr.h
g++ -c -o handlr.o -DHAVE_W32API_H  -D_UNICODE  -D__WXMSW__ -DwxLUA_USEBINDING_WXADV=1 -DwxLUA_USEBINDING_WXAUI=0 -DwxLUA_USEBINDING_WXBASE=1 -DwxLUA_USEBINDING_WXCORE=1 -DwxLUA_USEBINDING_WXGL=0 -DwxLUA_USEBINDING_WXHTML=0 -DwxLUA_USEBINDING_WXMEDIA=0 -DwxLUA_USEBINDING_WXNET=0 -DwxLUA_USEBINDING_WXRICHTEXT=0 -DwxLUA_USEBINDING_WXSTC=0 -DwxLUA_USEBINDING_WXXML=0 -DwxLUA_USEBINDING_WXXRC=0 -Iinclude -Os -mthreads -ffunction-sections -fdata-sections  -MThandlr.o -MFhandlr.o.d -MD -MP handlr.cpp
windres --use-temp-file -ihandlr.rc -ohandlr_rc.o  --define HAVE_W32API_H  --define _UNICODE --define __WXMSW__ --include-dir include --define wxLUA_USEBINDING_WXADV=1 --define wxLUA_USEBINDING_WXAUI=0 --define wxLUA_USEBINDING_WXBASE=1 --define wxLUA_USEBINDING_WXCORE=1 --define wxLUA_USEBINDING_WXGL=0 --define wxLUA_USEBINDING_WXHTML=0 --define wxLUA_USEBINDING_WXMEDIA=0 --define wxLUA_USEBINDING_WXNET=0 --define wxLUA_USEBINDING_WXRICHTEXT=0 --define wxLUA_USEBINDING_WXSTC=0 --define wxLUA_USEBINDING_WXXML=0 --define wxLUA_USEBINDING_WXXRC=0
g++ -s -o handlr.exe handlr.o handlr_rc.o  -mthreads -Llib/wx -Llib/wxlua -mwindows -Wl,--subsystem,windows -Wl,--gc-sections -lwxlua_msw28u_wxbindadv -lwxlua_msw28u_wxbindbase -lwxlua_msw28u_wxbindcore -lwxlua_msw28u_wxlua -llua5.1 -lwxmsw28u_adv -lwxbase28u_net -lwxbase28u_xml -lwxmsw28u_core -lwxbase28u -lwxtiff -lwxjpeg -lwxpng -lwxzlib -lwxregexu -lwxexpat -lkernel32 -luser32 -lgdi32 -lcomdlg32 -lwinspool -lwinmm -lshell32 -lcomctl32 -lole32 -loleaut32 -luuid -lrpcrt4 -ladvapi32 -lwsock32 -lodbc32
move handlr.exe ../release
upx --best --lzma ../release/handlr.exe