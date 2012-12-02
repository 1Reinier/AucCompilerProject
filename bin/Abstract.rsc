module Abstract

import Syntax;
import Abstract;
import ParseTree;
	  	  
public data PROGRAM =
  program(list[STATEMENT] stats); //, str input);
    
public data STATEMENT =
      whileStat(list[STATEMENT] body)
	 | incr()
	 | decr()
	 | goleft()
	 | goright()
	 | read()
	 | output()
     ;

// Load a Parse Tree:
// (makes Abstract Syntax Tree)

public PROGRAM  load(str txt) = implode(#PROGRAM, parse(#Program, txt));