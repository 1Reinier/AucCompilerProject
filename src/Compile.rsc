module Compile

import Prelude;

alias Instr = str;
alias Instrs = list[Instr];

// Compile Program

alias Tape = list[int];
alias ENV = tuple[int pointercounter, int counter, str code];

public void compileToFile(PROGRAM P, str name){

	ENV env = <0,0,"">;
	
	env.code += "
	module <name>
	
	import Prelude;
	
	public str <name>(){
	";
	
	for(instr <- P){
		env = compile(instr,env);
	}
	
	env.code += "
	}";
	
	print(env.code);
}

public ENV compile(PROGRAM P, ENV env){
	switch(P){
		case incr(): return incrementcounter(env);
		case decr(): return incrementcounter(env);
		case goright(): return incrementpointercounter(env);
		case goleft(): return decrementpointercounter(env);
		case whileStat(list[STATEMENT] body): return whileloop(body,env);
	}
}

public ENV whileloop (body,env){
	if(env.pointercounter != 0){
		env.code += "pointer += " + env.pointercounter + ";";
	}
	if(env.counter != 0){
		env.code += "cells[" + env.pointercounter + "] += " + env.counter + ";";
	}
	//Not sure if it works with that > sign
	env.code += "while(cells[" + env.pointercounter + "] \> 0) {";
	for(instr <- body){
		env = compile(instr,env);
	}
	return env;
}

public ENV incrementpointercounter(ENV env){
	if(env.counter == 0){
		env.pointercounter += 1;
	}
	else {
		env.code += "cells[" + env.pointercounter + "] += " + env.counter + ";";
	}
	
	return env;
}

public ENV decrementpointercounter(ENV env){
	if(env.counter == 0){
		env.pointercounter += -1;
	}
	else {
		env.code += "cells[" + env.pointercounter + "] += " + env.counter + ";";
	}
	
	return env;
}

public ENV incrementcounter(ENV env){
	if(env.pointercounter == 0){
		env.counter += 1;
	}
	else {
		//we have to add a line to the end program
		env.code += "pointer += " + env.pointercounter + ";";
	}
	
	return env;
}

public ENV decrementcounter(ENV env){
	if(env.pointercounter == 0){
		env.counter += -1;
	}
	else {
		//we have to add a line to the end program
		env.code += "pointer += " + env.pointercounter + ";";
	}
	
	return env;
}
public void save(str name, str text){
	writeFile(|file:///Users/joost/Documents| + name, text);
}

public str  compilenoinput(str P, str name) {
	return "
	module <name>
	
	public str <name>(){
		return <evalProgram(load(P))>;
	}
	";
}






