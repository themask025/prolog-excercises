
% 1. sum of elements in a list
sum([], 0).
sum([X|T], S):- sum(T, S1), S is S1 + X.


% 2. max element in a list - two solutions
member_my(X, [X|_]).
member_my(X, [_|L]):- member_my(X, L).

max1(L, X):- member_my(X, L), not((member_my(Y, L), X < Y)).


len_my([], 0).
len_my([_|L], N):- len_my(L, N1), N is N1 + 1.

max2([X], X).
max2([M|T], M):- len_my(T, N), N > 0, max2(T, M1), M >= M1.
max2([X|T], M):- len_my(T, N), N > 0, max2(T, M), X < M.


% 3. divides1 is true when X divides Y.
divides1(X, Y):- 0 is Y mod X.  