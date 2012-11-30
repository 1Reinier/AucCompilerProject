module Eval

import Prelude;
import Abstract;
import Load;

//data PicoValue = natval(int n) | strval(str s) | errorval(loc l, str msg);
//
//alias VENV = map[PicoId, PicoValue];  

public tuple[int location, bool loop, str char] pointer = <0, false, "">;

public void initPointer(){
	pointer = <0, false, "">;
}

public list[int] array = [];



// Evaluate a statement

VENV evalStat(stat:asgStat(PicoId Id, EXP Exp), VENV env) {
  env[Id] = evalExp(Exp, env);
  return env;
}
	
VENV evalStat(stat:ifElseStat(EXP Exp, 
                              list[STATEMENT] Stats1,
                              list[STATEMENT] Stats2),
              VENV env) =
  evalStats(evalExp(Exp, env) != natval(0) ? Stats1 : Stats2, env);

VENV evalStat(stat:whileStat(EXP Exp, 
                             list[STATEMENT] Stats1),
              VENV env) {
    while(evalExp(Exp, env) != natval(0)){
       env = evalStats(Stats1, env);
    }
    return env;
}

VENV evalStat(stat:unlessStat(EXP Exp, 
                              list[STATEMENT] Stats1),
              VENV env) =
  evalStats(evalExp(Exp, env) == natval(0) ? Stats1 : env);

// Evaluate a list of statements
VENV evalStats(list[STATEMENT] Stats1, VENV env) {
  for(S <- Stats1){
      env = evalStat(S, env);
  }
  return env;
}
  
// Eval declarations

VENV evalDecls(list[DECL] Decls) =
    ( Id : (tp == natural() ? natval(0) : strval(""))  | decl(PicoId Id, TYPE tp) <- Decls);

// Evaluate a Pico program

public VENV evalProgram(PROGRAM P){
  if(program(list[DECL] Decls, list[STATEMENT] Series) := P){
     VENV env = evalDecls(Decls);
     return evalStats(Series, env);
  } else
    throw "Cannot happen";
}

public VENV evalProgram(str txt) = evalProgram(load(txt));

    
