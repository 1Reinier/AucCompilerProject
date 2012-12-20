module Compile

import Prelude;
extend Abstract;

alias Instr = str;
alias Instrs = list[Instr];

// Compile Program

alias Tape = list[int];
alias ENV = tuple[int pointer, int counter, str code, STATEMENT nextStat];

public void compileToFile(PROGRAM P, str name){

	ENV env = <0, 0, "", incr()>;
	
	//The length is lowered for practical reasons
	cells = for(L <- [1..250])
				append 0;
	
	env.code += "module <name>
	'import Prelude;
	
	'public void <name>(str input){
	'	list[int] cells = <cells>;
	'";
	
	if(program(list[STATEMENT] stats) := P){
		for(n <- index(stats)){
			try
				env.nextStat = stats[n+1];
			catch:
				env.nextStat = read();
			env = compile(stats[n],env);
		}
  	} 
	
	env.code += "
	'}";
	
	save("<name>.rsc", env.code);
}

public ENV compile(S, ENV env){
	switch(S){
		case incr(): return incrementcounter(env);
		case decr(): return decrementcounter(env);
		case goright(): return incrementpointer(env);
		case goleft(): return decrementpointer(env);
		case whileStat(list[STATEMENT] body): return whileloop(body,env);
		case read(): return readfunction(env);
		case output(): return outputfunction(env);
	}
}

public ENV whileloop (body, ENV env){
	//Not sure if it works with that > sign
	env.code += "	while(cells[<env.pointer>] \> 0) {
	'";
	for(n <- index(body)){
			try
				env.nextStat = body[n+1];
			catch:
				env.nextStat = read();
			env = compile(body[n],env);
		}
	env.code += "	}
	'";
	return env;
}

public ENV incrementpointer(ENV env){
	env.pointer += 1;
	return env;
}

public ENV decrementpointer(ENV env){
	env.pointer += -1;
	return env;
}

public ENV incrementcounter(ENV env){
	if(env.nextStat == incr()){
		env.counter += 1;
	}
	else {
		env.counter += 1;
		env.code += "	cells[<env.pointer>] += <env.counter>;
	'";
		env.counter = 0;
	}
	return env;
}

public ENV decrementcounter(ENV env){
	if(env.nextStat == decr()){
		env.counter += 1;
	}
	else {
		env.counter += 1;
		env.code += "	cells[<env.pointer>] -= <env.counter>;
	'";
		env.counter = 0;
	}
	return env;
}


public void save(str name, str text){
	writeFile(|file:///Users/joost/Documents/AP-Final/src| + name, text);
}

public ENV readfunction(ENV env){
	env.code += "	cells[<env.pointer>] = chars(input)[0];
				'	input = substring(input, 1);
	'";
	
	return env;
}

public ENV outputfunction(ENV env){
	env.code += "	print(stringChar(cells[<env.pointer>]));
	'";
	return env;
}

//NB: edit the file location in the function save!
//To test below programs:
//compileToFile(readwrite,"rw");
//import rw; (this requires the save path to be in the same project folder!)
//rw("abc"); will give output "abc"

test bool tryCompile(){
	try
		compileToFile(helloWorld, "HW");
	catch: return false;
	return true;
}


//NB: this does not support input/output, use other function for that
public void  compileNoInput(str P, str name) {
	program = "module <name>
	
	'public void <name>(){
	'	print(<evalProgram(load(P))>);
	'}";
	save("<name>.rsc", program);
}

public PROGRAM helloWorld = load("\>+++++++++[\<++++++++\>-]\<.\>+++++++[\<++++\>-]\<+.+++++ ++..+++.\>\>\>++++++++
							[\<++++\>-]\<.\>\>\>++++++++++[\<+++++ ++++\>-]\<---.\<\<\<\<.+++.------.--------.
							\>\>+.");
							
public PROGRAM readwrite = load(",.,.,.");






