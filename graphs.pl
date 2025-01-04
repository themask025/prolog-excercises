member_my(X, [X|_]).
member_my(X, [_|T]):- member_my(X, T).

append_my([], X, X).
append_my([Y|L], X, [Y|S]):- append_my(L, X, S).

kleene_star_relaxed(_, 0, []).
kleene_star_relaxed(L, N, [X|S]):- N > 0,
                                   N1 is N - 1,
                                   kleene_star_relaxed(L, N1, S),
                                   member_my(X, L).

unique_elements([_]).
unique_elements([X|L]):- not(member_my(X, L)), unique_elements(L). 

% При подадено представяне (V, E) на граф 
% edge(V, E, X, Y) при преудовлетворяване
% генерира в X и Y всички краища на ребра
% в графа (V, E)
edge(V, E, X, Y):- member_my([X,Y], E),
                   member_my(X, V),
                   member_my(Y, V).

% ако графът е ориентиран:
% edge(V, E, X, Y):- member_my([Y, X], E),
%                    member_my(X, V),
%                    member_my(Y, V).

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

% При подадено представяне (V, E) на граф и естествено число
% N all_paths_with_length(V, E, N, P) при преудовлетворяване
% генерира в P всички пътища с дължина N в графа (V, E)

all_paths_with_length(V, E, N, P):- kleene_star_relaxed(V, N, P), is_path(V, E, P).

% При подадено представяне (V, E) на граф 
% is_simple_path(V, E, P) дава истина
% т.с.т.к. P е прост път в графа (V, E)
is_simple_path(V, E, P):- is_path(V, E, P), unique_elements(P).

is_simple_path1(V, E, P):- is_path(V, E, P),
                           not((append_my(_, [X|P1], P), member_my(X, P1))).


% При подадено представяне (V, E) на граф 
% is_hamiltonian_path(V, E, P) дава истина
% т.с.т.к. P е Хамилтонов път в графа (V, E)
is_hamiltonian_path(V, E, P):- is_simple_path(V, E, P),
                                not((member_my(X, V), not(member(X, P)))).

