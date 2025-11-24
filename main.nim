import strutils
import std/terminal

proc logError*(msg: string="500", errType: typedesc[Exception] = Exception) =
    styledEcho(fgRed, "[ERROR] " & msg)
    raise newException(errType, msg)

proc logWarn*(msg: string="500") =
    styledEcho(fgYellow, "[WARN] " & msg)

proc logInfo*(msg: string="500") = 
    echo("[INFO]" & msg)

proc write*(args: varargs[string]) =
    for a in args:
        stdout.write(a)
    stdout.flushFile()

proc print*(args: varargs[string]) =
    for a in args:
        stdout.write(a)
    stdout.write("\n")
    stdout.flushFile()

proc title*(symbol: char = '*', name: string = "Example"): string =
    var line = repeat(symbol, name.len)
    return line & "\n" & name & "\n" & line

proc pause*(lang: string = "en", color: ForegroundColor = fgWhite) =
    case lang.toLower()
    of "ru": styledEcho(color, "Нажмите Enter...")
    of "ua": styledEcho(color, "Натисніть Enter...")
    of "du": styledEcho(color, "Drücken Sie die Enter...")
    else:    styledEcho(color, "Press Enter...")
    discard stdin.readLine()
type AnswerMode* = enum # работает в связке с proc answer, хотел сделать на int 
# но сделал свой типы, буду чаще это использовать, в питоне так нельзя было.
    amStrict
    amLoose
    amExtended

proc answer*(question: string = "Continue? (y/n): ",mode: AnswerMode = amStrict): bool =
    stdout.write(question)
    stdout.flushFile()

    let ans = stdin.readLine().strip().toLower()

    let strictList = @["да", "д", "y", "ye", "yes"]

    let extendedList = @[
        "ага", "угу", "конечно", "канеш", "yes!", "yep",
        "sure", "ok", "okay", "дааа", "дааааа", "ясно"
    ]
    case mode
    of amStrict:
        return ans in strictList

    of amLoose:
        for s in strictList:
            if ans.startsWith(s[0]):
                return true
        return false
    of amExtended:
        if ans in strictList or ans in extendedList:
            return true
        for s in strictList:
            if ans.startsWith(s[0]):
                return true
        return false
# Пока всё, Думаю - пока достаточно 