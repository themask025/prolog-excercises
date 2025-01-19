% # Да се на пролог дефинира предикат p(X, Y), който по даден списък от
% # естествени числа X намира списък от списъци Y , който съдържа всички
% # пермутации на X и всеки елемент на Y се среща в Y точно толкова пъти,
% # колкото е II.1 неговият последен елемент. II.2 сумата от елементите
% # му.

p1(X, Y):- findall(P, perm_my(X, P), Perms), helper(Perms, Y).

helper([], []).
helper([P|Perms], Y) :- helper(Perms, Y1), last1(P, N), copy_N(P, N, C), append1(C, Y1, Y).

gen_Y(_, []).
gen_Y(X, Y):- gen_Y(X, Y1), perm_my(X, P), not(member1(P, Y1)), last1(P, N), copy_N(P, N, C), append1(C, Y1, Y).


perm_my([], []).
perm_my([X|L], P):- perm_my(L, P1), insert_my(X, P1, P).

% insert_my(X, [], [X]).
insert_my(X, L, R):- append1(Y, Z, L), append1(Y, [X|Z], R).

append1([], X, X).
append1([Y|L], X, [Y|M]):- append1(L, X, M).

member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

last1([X], X).
last1([_|L], X):- last1(L, X).

copy_N(_, 0, []).
copy_N(L, N, [L|C]):- N > 0, N1 is N - 1, copy_N(L, N1, C). 
