import os, strutils
import std/terminal

proc logError*(msg: string="500", errType: typedesc[Exception] = Exception) =
    styledEcho(fgRed, "[ERROR] " & msg)
    raise newException(errType, msg)

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
    stdout.flushFile()

proc start*(symbol: char = '*', name: string = "Example"): string =
    var line = repeat(symbol, name.len)
    return line & "\n" & name & "\n" & line

proc pause*(lang: string = "en", color: ForegroundColor = fgWhite) =
    case lang.toLower()
    of "ru": styledEcho(color, "Нажмите Enter...")
    of "ua": styledEcho(color, "Натисніть Enter...")
    of "du": styledEcho(color, "Drücken Sie die Enter...")
    else:    styledEcho(color, "Press Enter...")
    discard stdin.readLine()

proc progressBar*(current: int, total: int, width: float=30.0) =
    if total == 0: return
    let percent = current.float / total.float
    let filled = int(percent * width)
    stdout.write("\r[" & "#".repeat(filled) & "-".repeat(int(width) - filled) & "] ")
    stdout.write($int(percent * 100) & "%")
    stdout.flushFile()