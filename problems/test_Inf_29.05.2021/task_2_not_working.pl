% Една библиотека има три рафта с едни и същи размери, за които ще
% предполагаме, че са достатъчно големи. За една подредба на книгите в
% библиотеката ще казваме, че е приемлива, ако книгите с един и същ автор
% са само на един от рафтовете. Дисбаланс на една подредба на книгите
% е средно аритметичното на модулите на разликите на броя на книгите,
% които са на различни рафтове.
% Да се дефинира на пролог четириместен предикат order(Books, Shelf1,
% Shelf2, Shelf3), който по даден списък Books от двуелементни списъци
% [заглавие на книга, автор на книгата] при преудовлетворяване генерира
% в Shelf1, Shelf2, Shelf3 всички приемливи подредби с най-малък дисба-
% ланс на представените със списъка Books книги.

order(Books, Shelf1, Shelf2, Shelf3):- 
                                    get_authors(Books, Authors),
                                    pack_books_by_author(Books, Authors, Packs),
                                    findall(Ord, gen_order(Packs, Ord), Orders),
                                    get_min_disbalance(Orders, D),
                                    member1([Shelf1, Shelf2, Shelf3], Orders),
                                    get_disbalance([Shelf1, Shelf2, Shelf3], D).


get_authors([], []).
get_authors([[_, Author]|Books], [Author|Authors]):- get_authors(Books, Authors), not(member1(Author, Authors)).
get_authors([[_, Author]|Books], Authors):- get_authors(Books, Authors), member1(Author, Authors).

get_books_by_author(_, [], []).
get_books_by_author([[Title, Author]|Books], Author, [[Title, Author]|Filtered]):- get_books_by_author(Books, Author, Filtered).
get_books_by_author([[Title, Other]|Books], Author, Filtered):- get_books_by_author(Books, Author, Filtered), not(Other is Author).

pack_books_by_author(_, [], []).
pack_books_by_author(Books, [A|Authors], [P|Packs]):- get_books_by_author(Books, A, P).



gen_order(Packs, [S1, S2, S3]):- 
                                    len1(Packs, PL),
                                    between1(N1, 0, PL),
                                    gen_subset_with_len(N1, Packs, S1), diff(Packs, S1, S2US3),
                                    N2PlusN3 is PL - N1, between1(N2, 0, N2PlusN3),
                                    gen_subset_with_len(N2, S2US3, S2),
                                    diff(S2US3, S2, S3).

len1([], 0).
len1([_|L], N):- len1(L, N1), N is N1 + 1.

between1(A, A, B):- A =< B.
between1(X, A, B):- A < B, A1 is A + 1, between1(X, A1, B).

gen_subset_with_len(N, L, S):- perm1(L, P), take_N(N, P, S).

perm1([], []).
perm1([X|L], P):- perm1(L, P1), insert1(X, P1, P).

insert1(X, L, R):- append1(L1, L2, L), append1(L1, [X|L2], R).

append1([], X, X).
append1([Y|L], X, [Y|M]):- append1(L, X, M).

take_N(0, _, []).
take_N(N, [X|L], [X|T]):- N > 0, N1 is N - 1, take_N(N1, L, T).  

diff([], _, []).
diff([X|A], B, [X|AMinusB]):- diff(A, B, AMinusB), not(member1(X, B)).
diff([X|A], B, AMinusB):- diff(A, B, AMinusB), member1(X, B).

member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

% средноаритметично на модулите на разликите
get_disbalance([Shelf1, Shelf2, Shelf3], D):- 
                                    len1(Shelf1, S1),
                                    len1(Shelf2, S2),
                                    len1(Shelf3, S3),
                                    D1 is S1 - S2, D2 is S1 - S3, D3 is S2 - S3,
                                    abs1(D1, D11), abs1(D2, D22), abs1(D3,D33),
                                    D is (D11+D22+D33) / 3.

get_min_disbalance([Ord], D):- get_disbalance(Ord, D).
get_min_disbalance([Ord|Orders], D):- get_min_disbalance(Orders, D1), get_disbalance(Ord, D), D < D1.
get_min_disbalance([Ord|Orders], D1):- get_min_disbalance(Orders, D1), get_disbalance(Ord, D), D >= D1.


% generate all packs
% sort them by length
% append consecutively books to shelves
% this way you get minimal disbalance

