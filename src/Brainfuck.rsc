module Brainfuck

import Prelude;
import util::IDE;
import util::ValueUI;

import vis::Figure;
import vis::Render;

import Abstract;
import Syntax;
import Eval;
import Compile;


// /*1*/ define the language name and extension

private str Brainfuck_NAME = "Brainfuck";
private str Brainfuck_EXT = "bf";

// /*2*/ Define the connection with the brainfuck parser
Tree parser(str x, loc l) {
    return parse(#Program, x, l);
}

// /*4*/ Define the connection with the brainfuck evaluator

public void evalBrainfuckProgram(Program x, loc l) { //, loc selection) {
	m = implode(#PROGRAM, x, l); 
	text(evalProgram(m));
}

// Define connection to the brainfuck compiler 
public void compilebrainfuckProgram(Program x, loc l){
    p = implode(#PROGRAM, x);
    rascal = compileNoInput(p, "program1");
	text(rascal);
}

// /*7*/ Define all contributions to the brainfuck IDE

public set[Contribution] Brainfuck_CONTRIBS = {
	popup(
		menu("Brainfuck",[
		    action("Evaluate Brainfuck program", evalBrainfuckProgram),
    		action("Compile brainfuck to Rascal", compilebrainfuckProgram)
	    ])
  	)
};

// /*8*/ Register the Brainfuck tools

public void registerBrainfuck() {
  registerLanguage(Brainfuck_NAME, Brainfuck_EXT, parser);
  registerContributions(Brainfuck_NAME, Brainfuck_CONTRIBS);
}

