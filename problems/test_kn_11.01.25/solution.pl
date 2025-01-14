% pid(Leq, I).

member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

append1([], X, X).
append1([Y|L], X, [Y|M]):- 
	append1(L, X, M).

is_list1([]).
is_list1([_|_]).


flatten1([],[]).
flatten1([X|L], [X|F]):- 
	flatten1(L, F), 
	not(is_list1(X)).

flatten1([X|L], F):- 
	flatten1(L, F1),
	is_list(X), 
	append1(X, F1, F).

ideal(I, P):- 
	not((
		flatten1(I, I1),
		flatten1(P, P1),
		member1(U, P1),
		member1(V, I1),
		not((
			not(
				member1([U,V],P)
			);
			member1(U, I1)
		))
      	)),
	not((
		flatten1(I, I1),
		member1(U, I1),
		member1(V, I1),
		not((
			member1(W, I1),
			member1([U,W], I),
			member1([V,W], I)
	        ))

	)).


pid(Leq, I):- 
	not((
		not(Leq is I),
		flatten1(Leq, Leq1),
		flatten1(I, I1),
		member1(U, Leq1),
		member1(V, I1),
		not((
			not((
				member1(W, I1),
				member1([W, U], Leq),
				member1([W, V], Leq)
			));
			member1(U, I1),
			member1(V, I1)
		))
	)).
