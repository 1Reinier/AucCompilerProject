module Syntax

import Prelude;

lexical Char  = "+" | "-" | "\<" | "\>" | "." | "," | "[" | "]";

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r%];

lexical WhitespaceAndComment = [\ \t\n\r];

start syntax Program 
   = program: Statement+ body;
   
syntax Statement 
	= whileStat: "[" Statement+ body "]"
	| incr: "+"
	| decr: "-"
	| goleft: "\<"
	| goright: "\>"
	| read: ","
	| output: "."
	;

//syntax Input 
//	= input: [a-zA-Z0-9!@#$ˆ&*()];

public start[Program] program(str s) {
  return parse(#start[Program], s);
}

public start[Program] program(str s, loc l) {
  return parse(#start[Program], s, l);
} 
