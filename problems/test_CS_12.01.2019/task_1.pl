% Нека G = 〈V, E〉 е краен неориентиран граф без примки.

% I.1 k-клика в G, където k > 2, наричаме такова k -елементно подмножес-
% тво W на V, че винаги, когато v1 и v2 са различни върхове на W, има ребро
% в G, което е с краища v1 и v2.

% I.2 k-антиклика в G, където k > 2, наричаме такова k -елементно под-
% множество W на V, че винаги, когато v1 и v2 са различни върхове на W,
% няма ребро в G, което е с краища v1 и v2.

% За един списък X от двуелементни списъци казваме, че представлява G,
% ако са изпълнени следните условия:
% • ако v1 6 = v2 и G има ребро с краища v1 и v2 , то поне един от списъците
%   [v1, v2] , [v2, v1] е от X ;
% • ако [v1, v2] е от X и v1 6 = v2 , то в G има ребро с краища v1 и v2;
% • [v, v ] е от X точно тогава, когато v е връх в G, който не е край на
% ребро от G.

% I.1 Да се дефинира на пролог двуместен предикат cl(K, X), който по да-
% дени естествено число K и списък X, представящ граф G, разпознава дали
% G има K-клика.

% I.2 Да се дефинира на пролог двуместен предикат acl(K, X), който по
% дадени естествено число K и списък X, представящ граф G, разпознава
% дали G има K-антиклика.

cl(K, X):-
    K > 2,
    get_vertices(X, V),
    subset_K(K, V, W),
    not((
        member1(V1, W), member1(V2, W), V1 \= V2,
        not((member1([V1, V2], X); member1([V2, V1], X)))
    )).

acl(K, X):-
    K > 2,
    get_vertices(X, V),
    subset_K(K, V, W),
    not((
        member1(V1, W), member1(V2, W), V1 \= V2,
        (member1([V1, V2], X); member1([V2, V1], X))
    )).


subset_K(K, V, W):- subset1(V, W), len1(W, K).

subset1([], []).
subset1([X|L],[X|S]):- subset1(L, S).
subset1([_|L],S):- subset1(L, S).

len1([], 0).
len1([_|L], N):- len1(L, N1), N is N1 + 1.


get_vertices(X, V):- flatten1(X, FX), to_set1(FX, V).

to_set1([],[]).
to_set1([X|L], [X|S]):- to_set1(L, S), not(member1(X,S)).
to_set1([X|L], S):- to_set1(L, S), member1(X, S).

flatten1([], []).
flatten1([X|L], F):- flatten1(L, F1), is_list1(X), flatten1(X, XF), append1(XF, F1, F).
flatten1([X|L], F):- flatten1(L, F1), not(is_list1(X)), append1([X], F1, F). 

is_list1([]).
is_list1([_|_]).


member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

append1([], X, X).
append1([Y|L], X, [Y|M]):- append1(L, X, M).


% алтернативно решение:

get_vertices1([], []).
get_vertices1([[X, Y]|T], V):-
    get_vertices1(T, TV),
    add_vertice(X, TV, TX),
    add_vertice(Y, TX, V).

add_vertice(V, VL, VR):-
    not(member1(V, VL)),
    append1([V], VL, VR).
add_vertice(V, VL, VL):-
    member1(V, VL).