module Syntax

lexical Char  = "+" | "-" | "\<" | "\>" | "." | "," | "[" | "]";

layout Layout = WhitespaceAndComment* >> [+\-\<\>.,\[\]];

lexical WhitespaceAndComment = ![+\-\<\>.,\[\]];

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

// Parse Brainfuck code: 
// (makes Parse Tree)

public start[Program] program(str s) {
  return parse(#start[Program], s);
}
