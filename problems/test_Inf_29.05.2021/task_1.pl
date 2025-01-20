% Една функция f : A → R, където A ⊆ R, се нарича липшицова с
% константа C, ако за произволни x и y от A е в сила неравенството
% |f (x) − f (y)| ≤ C|x − y|.
% Да се дефинира на пролог двуместен предикат isLipschitz(L, C),
% който по дадени списък L от двуелементни списъци от естествени числа
% и естествено число C проверява дали L представя графика на липшицова
% функция с константа C.

member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

abs1(X, X):- X >= 0.
abs1(X, Y):- X < 0, Y is 0 - X.

isLipschitz(L, C):- not((
                    member1([X, FX], L), member1([Y, FY], L),
                    Lhs1 is FX - FY, RhsPart1 is X - Y,
                    abs(Lhs1, Lhs), abs(RhsPart1, RhsPart), Rhs is C * RhsPart,
                    not(Lhs =< Rhs)
                    )).