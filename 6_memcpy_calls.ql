import cpp

// I used this for inspiration
// https://codeql.github.com/docs/codeql-language-guides/functions-in-cpp/#excluding-functions-that-are-referenced-with-a-function-pointer
from FunctionCall fc, Function f
where f.getName() = "memcpy"
    and fc.getTarget() = f
select fc, "Memcpy function call"