% по-символьно зчитуємо квадратичну формулу
% ax^2 + bx + c = 0
% в L записується рузультат
solve_quad(A*_^2+B*_+C=0, L) :-
    % підраховуємо дискрімінант
    D is B^2-4*A*C,
    % якщо менше 0 то коренів немає
    (   D<0
    ->  L=[]
    % якщо = 0, то корінь лише 1
    ;   D=:=0
    ->  X is -B/(2*A),
        L=[X]
    % інакше знаходимо 2 корені рівняння
    ;   S is sqrt(D),
        X1 is (-B-S)/(2*A),
        X2 is (-B+S)/(2*A),
        L=[X1, X2]
    ).

solve_quad2(A, B, C, L) :-
    % підраховуємо дискрімінант
    D is B^2-4*A*C,
    % якщо менше 0 то коренів немає
    (   D<0
    ->  L=[]
    % якщо = 0, то корінь лише 1
    ;   D=:=0
    ->  X is -B/(2*A),
        L=[X]
    % інакше знаходимо 2 корені рівняння
    ;   S is sqrt(D),
        X1 is (-B-S)/(2*A),
        X2 is (-B+S)/(2*A),
        L=[X1, X2]
    ).

% якщо якесь зі значень є 0 то повертаємо інше значення
gcd(0, X, X) :- X > 0, !.
gcd(X, 0, X) :- X > 0, !.
% якщо x>y, то вкорочуємо x на y і знову хукаємо gcd
gcd(X, Y, Z) :- X >= Y, X1 is X-Y, gcd(X1,Y,Z).
% якщо x<y, то навпаки
gcd(X, Y, Z) :- X < Y, X1 is Y-X, gcd(X1,X,Z).

% перемножуємо числа та ділимо на найбільний спільний дільник
lcm(X, Y, Z) :- Z is abs(X * Y) / gcd(X,Y).
