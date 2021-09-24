
import cpp

// Just intellisensed and tried different classes until I got
// what I wanted.
from Macro m, MacroInvocation mi
where m.getName().regexpMatch("ntoh.*")
    and mi.getMacro() = m
select mi.getExpr(), "Byte ordering macro invocation expression"
// Most of the results for this query are "... ? ... : ...".
// Is that something like empty, or null?
// Seems like the only ones that returned something are the
// code disabled by macro conditions.