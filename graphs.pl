member_my(X, [X|_]).
member_my(X, [_|T]):- member_my(X, T).

append_my([], X, X).
append_my([Y|L], X, [Y|S]):- append_my(L, X, S).

% При подадено представяне (V, E) на граф 
% edge(V, E, X, Y) при преудовлетворяване
% генерира в X и Y всички краища на ребра
% в графа (V, E)
edge(V, E, X, Y):- member_my([X,Y], E),
                   member_my(X, V),
                   member_my(Y, V).

% ако графът е ориентиран:
edge(V, E, X, Y):- member_my([Y, X], E),
                   member_my(X, V),
                   member_my(Y, V).

is_path_pairs(V, E, P):- not((
                        append_my(_, [[X, Y], [Z,T]|_], P),
                        edge(V, E, X, Y),
                        edge(V, E, Z, T),
                        not(Y = Z)
                        )).

is_path(V, E, P):- not((
                        append_my(_, [X,Y|_], P),
                        not(edge(V, E, X, Y))
                        )),
                        member(_,P).
