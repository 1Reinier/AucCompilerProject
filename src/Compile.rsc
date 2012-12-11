module Compile
    
public str  noInputCompiler(str P, str name) {
	return "
	module <name>
	
	public str <name>(){
		return <evalProgram(load(P))>;
	}
	";
}






