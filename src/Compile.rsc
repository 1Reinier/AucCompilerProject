module Compile

import Prelude;

alias Instr = str;
alias Instrs = list[Instr];

// Compile Program

alias Tape = list[int];
alias ENV = tuple[int pointercounter, int counter, str code];

public void compileToFile(PROGRAM P){

	ENV env = <0,0,"">;
	for(instr <- P){
		env = compile(P,env);
	}
}

public ENV compile(PROGRAM P, ENV env){
	switch(P){
		case incr(): return incrementcounter(env);
		case decr(): return incrementcounter(env);
		case goright(): return incrementpointercounter(env);
		case goleft(): env.pointercounter -= 1;
		// case whileStat(): env
	}
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






