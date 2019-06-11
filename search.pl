%% Depth First Search
dfs(Goal) :-
    dfs(1, Goal, [], Sol),
    writeln("Solution:"),
    writeln(Sol), !;
    writeln("Solution not found."), !.
%% dfs(Node, Goal, Path, Solution)
% Node - нод який зараз розглядається 
% Goal - нод який ми шукаємо
% Path - шлях з нодів які ми вже пройшли
% Solution - шлях до фільного нода
dfs(Node, Node, Path, Solution) :-
    % Якщо ми знайшли необхідний нам нод, тоді в Solution 
    % записуємо обернене значення пройденого шляху
    reverse([Node | Path], Solution).
dfs(Node, Goal, Path, Solution) :-
    % Записуємо у Node1 наступне значення з графу яке поєднується з Node
    edge(Node, Node1),
    % Перевіряємо чи належить Node1 до пройденого шляху.
    not(member(Node1, Path)),
    % Додаємо Node1 до пройденого шляху і продовжуємо пошук цілі викликавши dfs рекурсивно
    dfs(Node1, Goal, [Node | Path], Solution).


%% Breadth First Search
bfs(Goal) :-
    Start is 1,
    bfs(Goal, [[Start]], Path, [Start]),
    writeln("Solution:"),
    writeln(Path), 
    !; 
    writeln('Solution not found.').
% додаткова функція для об'єзнання елементів в масив
consed(A,B,[B|A]).
%% bfs(Goal, VisitedList, Path, FullPath)
% Goal - нод який ми шукаємо
% VisitedList - матриця пройдених "широт"
% Path - аргумент для збереження фінального пройденого шляху
% FullPath - весь пройдений шлях пошуку
bfs(Goal, [Visited|Rest], Path, FullPath) :- 
    % достаємо початковий елемент з поточної широти
    Visited = [Start|_], 
    % перевіряємо чи відповідає ноду який ми шукаємо
    Start \== Goal,
    % знаходимо такі Values, що Start з цими значеннями (Х) пов'язаний в графі
    % і вони не належать списку пройдених нодів
    findall(
        X,
        (edge(Start, X), not(member(X,Visited))),
        Values
    ),
    % поєднуємо значення вже пройдених нодів (Visited)
    % і значення наступних нодів (Values) в матрицю VisitedExtended
    maplist(consed(Visited), Values, VisitedExtended),
    % додаємо матрицю відвіданих нодів в повну матрицю
    append(Rest, VisitedExtended, VisitedList),
    % додаємо знайдені ноди в пройдений шлях
    append(FullPath, Values, NewFullPath),
    % продовжуємо пошук
    bfs(Goal, VisitedList, Path, NewFullPath).
bfs(Goal, [Visited|_], Path, _) :- 
    % take(FullPath, Goal, Path).
    % беремо останній знайдений елемент
    Visited = [Start|_],
    % перевіряємо на співпадіння з цілю
    Goal == Start,
    % записуємо обернений масив Visited в Path
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
