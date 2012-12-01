module Load

import Syntax;
import Abstract;
import ParseTree;

public PROGRAM  load(str txt) = implode(#PROGRAM, parse(#Program, txt));

// Test: Hello World!:
// load("\>+++++++++[\<++++++++\>-]\<.\>+++++++[\<++++\>-]\<+.+++++ ++..+++.\>\>\>++++++++[\<++++\>-]\<.\>\>\>++++++++++[\<+++++ ++++\>-]\<---.\<\<\<\<.+++.------.--------.\>\>+.");