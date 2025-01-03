% helper functins
append_my([], X, X).
append_my([H|T], X, [H|L]):- append_my(T, X, L).

member_my(X, [X|_]).
member_my(X, [_|T]):- member_my(X, T).

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
