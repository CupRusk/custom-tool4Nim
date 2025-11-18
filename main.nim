import os, terminal, strutils

proc logError*(msg: string, error = Exception) =
    echo "[ERROR] ", msg
    raise newException(error, msg)

proc write*(args: varargs[string]) =
    for a in args:
        stdout.write(a)
    stdout.flushFile()


proc start*(symbol: string = "*", name: string = "Example"): string =
    if symbol.len != 1:
        logError("Only one symbol", ValueError)
    
    var full_text = symbol.repeat(name.len) & "\n"
    full_text &= name & "\n"
    full_text &= symbol.repeat(name.len)
    return full_text

proc pause*(lang: string="en", color: ForegroundColor) =
    if lang.toLower() == "ru":
        styledEcho(color, "Нажмите Enter...")
    else: 
        styledEcho(color, "Press Enter...")
    discard stdin.readLine()


write("Hui"); write("\n",start("*", "Nipi"), "\n"); pause("ru", fgRed); logError("Хуй")