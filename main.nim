import os, terminal, strutils

proc logError*(msg: string="500", error = Exception) =
    styledEcho (fgRed, "[ERROR] " & msg)
    raise newException(error, msg)

proc logWarn*(msg: string="500") =
    styledEcho(fgYellow, "[WARN] " & msg)

proc write*(args: varargs[string]) =
    for a in args:
        stdout.write(a)
    stdout.flushFile()

proc print*(args: varargs[string]) =
    for a in args:
        stdout.write(a)
    stdout.write("\n")
    stdout.flushFile(stdout)

# proc input*(args: varargs[string]): string = Future

proc start*(symbol: string = "*", name: string = "Example"): string =
    if symbol.len != 1:
        logError("Only one symbol", ValueError)
    
    var full_text = symbol.repeat(name.len) & "\n"
    full_text &= name & "\n"
    full_text &= symbol.repeat(name.len)
    return full_text

proc pause*(lang: string = "en", color: ForegroundColor) =
    case lang.toLower()
    of "ru":
        styledEcho(color, "Нажмите Enter...")
    of "ua":
        styledEcho(color, "Натисніть Enter...")
    of "deu":
        styledEcho(color, "Drücken Sie die Enter...")
    else: # English
        styledEcho(color, "Press Enter...")
    discard stdin.readLine()

proc progressBar*(current: int, total: int, width=30) = # \r[#####-----] 
    let percent = current.float / total.float
    let filled = int(percent * width)
    stdout.write("\r[" & "#".repeat(filled) & "-".repeat(width - filled) & "] ")
    stdout.write($int(percent * 100) & "%")
    stdout.flushFile(stdout)
    