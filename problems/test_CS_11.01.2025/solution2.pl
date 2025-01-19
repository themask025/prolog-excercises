% pid(Leq, I)


to_set([], []).
to_set([X|L], [X|S]):- to_set(L, S), not(member1(X, L)).
to_set([X|L], S):- to_set(L, S), member1(X, L).

% subset([], []).
% subset([X|L], [X|S]):- subset(L, S).
% subset([X|L], S).



member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

append1([], X, X).
append1([Y|L], X, [Y|M]):- append1(L, X, M).

is_list1([]).
is_list1([_|_]).

flatten1([], []).
flatten1([X|L], F):- flatten1(L, F1), is_list1(X), flatten1(X, X1), append1(X1, F1, F).
flatten1([X|L], [X|F]):- flatten1(L, F), not(is_list1(X)).

is_subset1(S, L):- member1(X, S), member1(X, L).

equal_sets(L, M):- is_subset1(L, M), is_subset1(M, L).

is_empty([]).


is_ideal(PRel, I):- not(not((
                        not(is_empty(I)),
                        flatten1(PRel, P),
                        is_subset1(I, P), 
                        (
                            member1(U, P),
                            member1(V, I),
                            (
                                not(member1([U, V], PRel));
                                member(U, I)
                            )
                        ),
                        (
                            member1(U1, I),
                            member1(V1, I),
                            not((
                                member1(W, I),
                                not((
                                    member1([U1, W], PRel),
                                    member1([V1, W], PRel)
                                ))
                            ))
                        )

                    ))).

pid(Leq, I):- 
                is_ideal(I, Leq),
                flatten1(Leq, P),
                not(is_subset1(P, I)),
                member1(U, P),
                member1(V, P),
                (
                    not((
                        member1(W, I),
                        not((
                            member1([W, U], Leq),
                            member1([W, V], Leq)
                        ))
                    ));
                    (
                        member1(U, I);
                        member1(V, I)
                    )
                ).




req2(PRel, I):- not(not((
                member1(U1, I),
                member1(V1, I),
                not((
                    member1(W, I),
                    not((
                        member1([U1, W], PRel),
                        member1([V1, W], PRel)
                    ))
                ))
))).             
