# pause - ждём enter
# start - вывод названия программы(берёться название исполняемого файла)
# print - обычный вывод, как print() -> python
# write - ввод без \n
# logError - если ошибка случаеться, красный текст
# findAnyFiles - поиск любой функций.
import os

proc createCustomError*(msg: string) =
    raise newException(Exception, msg)


proc write*(args: string) =
    stdout.write(args)
    stdout.flushFile()

proc start*(symbol: string, name: string): string = 
    if symbol >= 2:
        createCustomError("Only one symbol!")

    var full_text: string = "";
    let height: int = name.len
    for _ in height:
        write(symbol)
        
    return full_text