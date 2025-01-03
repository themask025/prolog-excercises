%append(X, L, R) - конкатенацията на X и L е R
append_my([], X, X).
append_my([H|T], X, [H|R]):- append_my(T, X, R).


% При подаден терм X и списък L
% insert(X, L, M) ще генерира в
% M всички възможни масиви, които
% се получават чрез вмъкване на X
% в списъка L.

% insert(X, L, M).
insert1(X, M, [X|M]).
insert1(X, [M|L], [M|R]):- insert1(X, L, R). 

insert2(X, L, R):- append_my(H1, H2, L), append_my(H1, [X|H2], R).

% При подаден списък L perm(L, P)
% генерира в P всички възможни
% пермутации на списъка L.

% perm(L, P).
perm([], []).
perm([X|T], R):- perm(T, T1), insert1(X, T1, R).


% sorted(L) проверява дали
% подаденият списък L е
% сортиран във възходящ ред.

sorted([]).
sorted([_]).
sorted([X,Y|T]):- X =< Y, sorted([Y|T]).

% Алтернативна имплементация, която
% използва append:
% "Няма два съседни елемента, които
%  образуват инверсия."

sorted2(L):- not((append(_, [X, Y|_], L), X > Y)).


% При подаден списък L bogosort(L, M)
% ще генерира в M всички пермутации
% на списъка L, които са сортирани.

bogosort(L, R):- perm(L, R), sorted(R).



sum_my(N, 0, N).
sum_my(N, s(M), s(K)):- sum_my(N, M, K).
% sum_my(N, M, K):- M1 is M-1, K1 is K-1, sum_my(N, M1, K1).

prod_my(_, 0, 0).

%prod
prod_my(N, s(M), K):- prod_my(N, M, L), sum_my(L, N, K).

natural(0).
natural(s(N)):- natural(N).

nat(0).
nat(N):- nat(N1), N is N1 + 1.

% pair_bad(A, B):- nat(A), nat(B).

% При подадени цели числа A и B
% between(X, A, B) генерира в X
% всички числа между A и B.
between_my(A, A, B):- A =< B.
between_my(X, A, B):- A < B, A1 is A + 1, between_my(X, A1, B).

% Друга изброима структура, която
% можем да генерираме е декартовия
% квадрат на множеството от
% естествени числа.
pair_my(A, B):- nat(N), between_my(A, 0, N), B is N - A.

% Обобщаваме идеята за двойки
% и получаваме тройки:
triple_my(A, B, C):- nat(N), between_my(A, 0, N), M is N - A, between_my(B, 0, M), C is M - B.

% Тази идея може да се обобщи още,
% за да генерираме всички крайни
% редици от естествени числа:
% - всяка крайна редица от естествени
%   числа има дължина и сума;
% - за две естествени числа n и k има
%   крайно много редици от естествени
%   числа с дължина n и сума k.

gen_my(L):- pair_my(N, K), gen_nk(L, N, K).


% При подадени естествени числа N и K
% gen_nk(L, N, K) генерира в L всички
% списъци от естествени числа, които
% имат дължина N и сума K.
gen_nk([], 0, 0).
gen_nk([X|L1], N, K):- N > 0, between_my(X, 0, K), K1 is K - X, N1 is N - 1, gen_nk(L1, N1, K1).


% При подадена функция Func и списък L
% map(Func, L, M) генерира М списъкът,
% който се получава чрез прилагането
% на Func върху елементите на L.
map(_, [], []).
map(Func, [H|T], [X|T1]):- map(Func,T,T1),
                          call(Func, H, X).

add_one(X, Y):- Y is X+1.


% Използвайки тази идея, можем да
% генерираме всички списъци от цели
% числа по следния начин:
% 1. Генерираме всички списъци от
%    естествени числа.
% 2. Преобразуваме всеки елемент
%    на списъка спрямо някаквa 
%    фиксиране биекция между
%    естествените и целите числа.
genZLists(L):- gen_my(L1), map(mappingNtoZ, L1, L).

% mapNtoZList(L, M):- 
mappingNtoZ(N, Z):- Z is ((-1) ** N) * (N + 1) div 2.

% Можем да си направим и по-проста
% версия, която не използва call:
mapNtoZLists([],[]).
mapNtoZLists([X|L], [Y|M]):- mapNtoZLists(L, M),
                             mappingNtoZ(X, Y).

% method for generating all integers:
int(Z):- nat(N), mappingNtoZ(N, Z).


% length of a list
len_my([], 0).
len_my([_|T], N):- len_my(T, N1), N is N1+1.

% Given a list L, nth_element(L, N, X) generates
% in X and N every element of L and its index
nth_element([X|_], 0, X).
nth_element([_|T], N, X):- nth_element(T, N1, X), N is N1+1.


% Given a list L, reverse(L, R) generates
% in R a list made by reversing L

% recursive implementation
reverse_rec([], []).
reverse_rec([H|T], R):- reverse_rec(T, T1), append_my(T1, H, R).

% implementation with a stack
reverse_stack(L, R):- reverse_helper(L, R, []).
reverse_helper([], R, R).
reverse_helper([X|L], R, M):- reverse_helper(L, R, [X|M]).