
/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
      exists(Macro m, MacroInvocation mi |
        m.getName().regexpMatch("ntoh.*")
        and mi.getMacro() = m
        and this = mi.getExpr()
      )
    }
  }

/*
This exercise was pretty straight forward. I'm curious to know how
CodeQL qualifies the data as being the source for a sink. What if it
goes through some modification? I suppose you could check if the source
(or any of its non-const members) were used as left-hand operands in
an expression, or if a non-const member function was called. I would
still want to explore how to tell if a sink's data has been sanitized.
You could probably modify isSource and qualify the source further,
perhaps checking that the source expression passes through the sink of
a sanitizing function.
*/
class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall fc, Function f |
        f.getName() = "memcpy"
        and fc.getTarget() = f
        and sink.asExpr() = fc.getArgument(2)
    )
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"