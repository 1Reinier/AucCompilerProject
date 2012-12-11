module Compile

import Prelude;

alias Instr = str;
alias Instrs = list[Instr];

public Instrs compile(PROGRAM P){

}




//public str main(str input){
//	pointer = 0;
//	array = [0,0];
//	array[pointer] += 10;
//		return output;
//}



public str  compilenoinput(str P, str name) {
	return "
	module <name>
	
	public str <name>(){
		return <evalProgram(load(P))>;
	}
	";
}






