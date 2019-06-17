expr(V) -->      term(V0), rest_expr(V0, V). 
expr(V) --> [+], term(V0), rest_expr(V0, V). 
expr(V) --> [-], term(V0), {V1 is -V0}, rest_expr(V1, V). 

rest_expr(V0, V) --> [+], term(V1), {V2 is V0+V1}, rest_expr(V2, V). 
rest_expr(V0, V) --> [-], term(V1), {V2 is V0-V1}, rest_expr(V2, V). 
rest_expr(V,  V) --> []. 

term(V) --> primary(V0), rest_term(V0, V). 

rest_term(V0, V) --> [*], primary(V1), {V2 is V0*V1}, rest_term(V2, V). 
rest_term(V0, V) --> [/], primary(V1), {V2 is V0/V1}, rest_term(V2, V). 
rest_term(V,  V) --> []. 

primary(V) --> [number(V)]. 
primary(V) --> [lp], expr(V), [rp]. 
