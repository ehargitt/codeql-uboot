import cpp

// Just intellisensed and tried different classes until I got
// what I wanted.
from Macro m, MacroAccess ma
where m.getName().regexpMatch("ntoh.*")
    and ma.getMacro() = m
select ma, "Byte ordering macro invocation"