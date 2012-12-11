module Compile

import Prelude;

alias Instr = str;
alias Instrs = list[Instr];

// Compile Program

public Instrs compile(PROGRAM P){
	
}

// Unique label generation

private int nLabel = 0;                            /*4*/

private str nextLabel() {
  nLabel += 1;
  return "L<nLabel>";
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






