import cpp

/*
idk why, but this was the first hard one for me.
I looked in all the docs for Expressions, exists, etc.
I cloned the CodeQL standard lib and searched the code
for more examples of how "exists" works in the 
characteristic predicate, which helped a lot. It finally
clicked for me when I got an error message that I hasn't bound
'this' in the predicate.
*/
class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    exists(Macro m, MacroInvocation mi |
      m.getName().regexpMatch("ntoh.*")
      and mi.getMacro() = m
      and this = mi.getExpr()
    )
  }
}

from NetworkByteSwap n
select n, "Network byte swap"
