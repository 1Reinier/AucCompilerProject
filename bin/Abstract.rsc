module Abstract
	  	  
public data PROGRAM =
  program(list[STATEMENT] stats);
    
public data STATEMENT =
      whileStat(list[STATEMENT] body)
	 | incr()
	 | decr()
	 | goleft()
	 | goright()
	 | read()
	 | output()
     ;
