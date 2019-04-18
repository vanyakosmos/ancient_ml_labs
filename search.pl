%% Depth First Search
dfs(Goal) :-
    dfs(1, Goal, [], Sol),
    writeln("Solution:"),
    writeln(Sol), !;
    writeln("Solution not found."), !.
%% dfs(Node, Goal, Path, Solution)
dfs(Node, Node, Path, Solution) :-
    reverse([Node | Path], Solution).
dfs(Node, Goal, Path, Solution) :-
   edge(Node, Node1),
   not(member(Node1, Path)),
   dfs(Node1, Goal, [Node | Path], Solution).


%% Breadth First Search
bfs(Goal) :-
    Start is 1,
    bfs(Goal, [[Start]], Path, [Start]),
    writeln("Solution:"),
    writeln(Path), 
    !; 
    writeln('Solution not found.').
consed(A,B,[B|A]).
%% bfs(Goal, VisitedList, Path, FullPath)
bfs(Goal, [Visited|Rest], Path, FullPath) :- 
    Visited = [Start|_],            
    Start \== Goal,
    findall(
        X,
        (edge(Start, X), not(member(X,Visited))),
        Values
    ),
    maplist(consed(Visited), Values, VisitedExtended),
    append(Rest, VisitedExtended, VisitedList),
    append(FullPath, Values, NewFullPath),
    bfs(Goal, VisitedList, Path, NewFullPath).
bfs(Goal, [Visited|_], Path, _) :- 
    % take(FullPath, Goal, Path).
    Visited = [Start|_],
    Goal == Start,
    reverse(Visited, Path).


search(Goal) :-
    format('Depth First Search for ~a~n', [Goal]),
    dfs(Goal),
    nl,
    format('Breadth First Search for ~a~n', [Goal]),
    bfs(Goal).

main :-
    [graph, utils],
    cls,
    writeln('Pick a goal (eg: "5.") or type "stop.":'),

    repeat,
    read(Term),
    % Term is 6,
    (is_quit(Term); cls),
    (  
        is_quit(Term),
        writeln('Bye'),
        !;  
        search(Term),
        format('~n- - - -~n~n'),
        fail
    ).
