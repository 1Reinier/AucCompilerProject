module Eval

import Prelude;
import Abstract;
import Load;

alias Tape = list[int];
alias Pointer = tuple[int location, bool loop, str char];
alias ENV = tuple[Pointer pointer, Tape array];

public Tape initArray() { 
	return for(n <- [1..30000])
				append 0;
}

public ENV env = <<0, false, "">, []>;

public void initEnv(){
	pointer = <0, false, "">;
	array = initArray();
	env = <pointer, array>;
}


// Evaluate expressions
