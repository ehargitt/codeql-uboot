import cpp

from Macro m
// TODO(ehargitt) I originally wanted to find a way to
// store the regex literal in a variable. Is that possible?
where m.getName().regexpMatch("ntoh.*")
select m, "Found byte ordering macro"

