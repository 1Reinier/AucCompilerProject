module Abstract
	  	  
public data PROGRAM =
  program(list[STATEMENT] stats);
    
public data STATEMENT =
      whileStat(list[STATEMENT] body)
	 | incr()
	 | decr()
	 | left()
	 | right()
	 | read()
	 | output()
     ;

anno loc PROGRAM@location;
anno loc STATEMENT@location;

public alias Occurrence = tuple[loc location, STATEMENT stat];
