module Syntax

import Prelude;

lexical Char  = "+" | "-" | "\<" | "\>" | "." | "," | "[" | "]";

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r];

lexical WhitespaceAndComment = [\ \t\n\r];

start syntax Program 
   = program: Statement+ body Input* input;
   
syntax Statement 
	= whileStat: "[" Statement+ body "]"
	| incr: "+"
	| decr: "-"
	| left: "\<"
	| right: "\>"
	| read: ","
	| output: "."
	;

syntax Input = [a-zA-Z0-9!@#$%ˆ&*()];

public start[Program] program(str s) {
  return parse(#start[Program], s);
}

public start[Program] program(str s, loc l) {
  return parse(#start[Program], s, l);
} 
