module Eval

import Prelude;
import Abstract;
import Load;


public tuple[int location, bool loop, str char] pointer = <0, false, "">;

public void initPointer(){
	pointer = <0, false, "">;
}

public list[int] array = [];

public void initArray() { 
	array = for(n <- [1..30000])
				append 0;
}
	