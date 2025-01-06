member1(X, [X|_]).
member1(X, [_|T]):- member1(X, T).

append1([], X, X).
append1([Y|L], X, [Y|M]):- append1(L, X, M).

balance(L, B):- max_elements(L, Maxes),
                min1(Maxes, M1),
                min_elements(L, Mins),
                max1(Mins, M2),
                B is M1 - M2.

min1(L, X):- member1(X, L), not((member1(Y, L), X > Y)).
max1(L, X):- member1(X, L), not((member1(Y, L), X < Y)).


min_elements([], []).
min_elements([H|T], M):- min_elements(T, M1),
                         min1(H, M2),
                         append1(M1, [M2], M).
                        %   append1(M1, M2, M).

max_elements([], []).
max_elements([H|T], M):- max_elements(T, M1),
                         max1(H, M2),
                         append1(M1, [M2], M).

p(L):- balance(L, B), 
       not((member1(M, L),
            not(member1(B, M))
            )).

