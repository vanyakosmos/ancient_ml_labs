cls :- write('\e[H\e[2J').
is_quit(V) :- member(V, [q, stop, quit, exit]).
take(List, T, Prefix) :-
    append(Prefix2, [T|_], List),
    append(Prefix2, [T], Prefix).
