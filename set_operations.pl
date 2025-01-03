% helper functins
append_my([], X, X).
append_my([H|T], X, [H|L]):- append_my(T, X, L).

member_my(X, [X|_]).
member_my(X, [_|T]):- member_my(X, T).

between_my(A, A, B):- A =< B.
between_my(X, A, B):- A < B,
                      A1 is A + 1,
                      between_my(X, A1, B).

% given a list L, upon satisfaction
% subset(L, S) generates in S all subsets of L
subset([], []).
subset([X|L], [X|S]):- subset(L, S).
subset([_|L], S):- subset(L, S).

% Given lists A and B,
% cartesian_product(A, B, AxB)
% generates in AxB their
% cartesian product
cartesian_product([], _, []).
cartesian_product([X|A], B, C):-cartesian_product(A, B, AxB),
                                cartesian_helper(X, B, XxB),
                                append_my(XxB, AxB, C).

% helper predicate for 
% generating cartesian product
% with a singleton
cartesian_helper(_, [], []).
cartesian_helper(X, [Y|B], [(X,Y)|R]):- cartesian_helper(X, B, R).


% opair(P) is true if and only if
% P is an ordered pair
opair(P):- P = (_, _).


% rel(R) is true if and only if
% R represents a relation

% rel0(R):- member_my(X, R), opair(X).
% rel1(R):- member_my(X, R), not(opair(X)).
rel(R):- not((member_my(X, R), not(opair(X)))).


% func(F) is true if and only if
% F represents a function
func(F):- rel(F),
          not((member_my((X,A), F), 
               member_my((X,B), F),
               not(A = B))).


% functions_from_A_to_B(A, B, F)
% given lists A and B
% upon satisfaction generates
% in F all partial functions
% from A to B
functions_from_A_to_B(A, B, F):- cartesian_product(A, B, AxB),
                                 subset(AxB, F),
                                 func(F).


% is_unique(L) is true if and only if
% L has no duplicate elements
is_unique([_]).
is_unique([X|T]):- not(member(X, T)), is_unique(T).


% to_set(L, S)
% given a list L generates in S
% the list L with removed
% duplicate elements

% inefficient but easy implementation
% if we have the right predicates implemented
to_set_my(L, S):- subset(L, S), is_unique(S), not((member_my(X, L), not(member_my(X, S)))).

% more efficient implementation
% with recursion implemented on our own
to_set1([], []).
to_set1([X|L],[X|S]):- to_set1(L, S), not(member(X, S)).
to_set1([X|L], S):- to_set1(L, S), member(X, S). 


% Given Sigma kleene_star(Sigma, L)
% upon satisfaction generates in L all
% finite lists with elements from Sigma
kleene_star(_, []).
kleene_star(Sigma, [X|L]):- kleene_star(Sigma, L),
                            member_my(X, Sigma).


% Relaxed version of kleene_star which accepts
% the length of the sequence
kleene_star_relaxed(_, 0, []).
kleene_star_relaxed(Sigma, N, [X|L]):- N > 0, N1 is N - 1,
                                       kleene_star_relaxed(Sigma, N1, L),
                                       member(X, Sigma).

nat(0).
nat(N):- nat(N1), N is N1+1.

kleene_star2(Sigma, L):- nat(N), kleene_star_relaxed(Sigma, N, L).


% Given natural numbers N and S
% gen_tree_relaxed(T, N, S) upon satisfaction
% generates in T all trees with N nodes,
% which have natural numbers for labels,
% which sum up to S
gen_tree_relaxed([], 0, 0).
gen_tree_relaxed([X, T1, T2], N, S):- N > 0, 
                                      between_my(X, 0, S),
                                      S1PlusS2 is S - X,
                                      between_my(S1, 0, S1PlusS2),
                                      S2 is S1PlusS2 - S1,
                                      N1PlusN2 is N - 1,
                                      between_my(N1, 0, N1PlusN2),
                                      N2 is N1PlusN2 - N1,
                                      gen_tree_relaxed(T1, N1, S1),
                                      gen_tree_relaxed(T2, N2, S2).


nat_pair(A, B):- nat(N),
                 between(A, 0, N),
                 B is N - A.


gen_tree(T):- nat_pair(N, S), gen_tree_relaxed(T, N, S).


% aperiodic(X) upon satisfaction generates
% in X sequentially all elements from the aperiodic
% sequence 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, ...
aperiodic(X):- nat(N), X is N mod 2, between_my(_, 1, N).