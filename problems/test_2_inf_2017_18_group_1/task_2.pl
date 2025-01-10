nat(0).
nat(N):- nat(M), N is M+1.

member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

append1([], X, X).
append1([Y|L], X, [Y|M]):- append1(L, X, M).


gen_one_boolean_list(0, []).
gen_one_boolean_list(N, [X|L]):- N > 0, N1 is N-1,
                                 gen_one_boolean_list(N1, L),
                                 (X is 0; X is 1).

gen_all_boolean_lists(0, _, []).
gen_all_boolean_lists(N, K, X):- N > 0, N1 is N-1,
                                 gen_all_boolean_lists(N1, K, Y),
                                 gen_one_boolean_list(K, L),
                                 append1(Y, [L], X).

d([], [], 0).
d([X|L], [Y|R], N):- 
                     X \= Y,
                     d(L, R, N1),
                     N is N1+1.
d([X|L], [Y|R], N):-
                     X is Y,
                     d(L, R, N).

sum_diffs([], _, 0).
sum_diffs([X|L], Y, D):- sum_diffs(L, Y, D1),
                         d(X, Y, D2),
                         D is D1 + D2.

center(Y, X):- member1(Y, X),
               not((member1(Z, X),
                    sum_diffs(X, Z, D1),
                    sum_diffs(X, Y, D2),
                    D1 < D2)).

main_logic(X, N):- center(L, X),
                    sum_diffs(X, L, S1),
                    not((gen_one_boolean_list(N, M), sum_diffs(X, M, S2), S2 < S1, not(member1(M, X)))).

p(N, X):- nat(M), gen_all_boolean_lists(M, N, X), 
          main_logic(X, N).