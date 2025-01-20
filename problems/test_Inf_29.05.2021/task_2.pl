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
    gather_authors(Books, Authors),
    generate_shelves(Books, Shelf1, Shelf2, Shelf3),
    is_acceptable(Books, Authors, Shelf1, Shelf2, Shelf3),
    disbalance(Shelf1, Shelf2, Shelf3, D),
    not((
        generate_shelves(Books, S1, S2, S3),
        (S1 \= Shelf1; S2 \= Shelf2; S3 \= Shelf3),
        is_acceptable(Books, Authors, S1, S2, S3),
        disbalance(S1, S2, S3, D1),
        D1 < D
    )).

generate_shelves(Books, Shelf1, Shelf2, Shelf3):-
    split_books(Books, Shelf1, Shelf2, Shelf3),
    not(have_common_elements(Shelf1, Shelf2)),
    not(have_common_elements(Shelf1, Shelf3)),
    not(have_common_elements(Shelf2, Shelf3)).


split_books([], [], [], []).
split_books([Book|Books], [Book|Shelf1], Shelf2, Shelf3):- split_books(Books, Shelf1, Shelf2, Shelf3).
split_books([Book|Books], Shelf1, [Book|Shelf2], Shelf3):- split_books(Books, Shelf1, Shelf2, Shelf3).
split_books([Book|Books], Shelf1, Shelf2, [Book|Shelf3]):- split_books(Books, Shelf1, Shelf2, Shelf3).

is_acceptable(Books, Authors, Shelf1, Shelf2, Shelf3):-
    not((
        member1(A, Authors),
        not(is_acceptable_one_author(Books, A, [Shelf1, Shelf2, Shelf3]))
        )).

gather_authors([], []).
gather_authors([[_, Author]|Rest], [Author|Res]):- 
    gather_authors(Rest, Res),
    not(member1(Author, Res)).
gather_authors([[_, Author]|Rest], Res):-
    gather_authors(Rest, Res),
    member1(Author, Res).

is_acceptable_one_author(Books, Author, Shelves):-
    member1(Shelf, Shelves),
    not((
        member1([Title, Author], Books),
        not(member1([Title, Author], Shelf))
    )).

have_common_elements(L1, L2):- member1(X, L1), member1(X, L2).

disbalance(Shelf1, Shelf2, Shelf3, D):-
    len1(Shelf1, N1),
    len1(Shelf2, N2),
    len1(Shelf3, N3),
    D is (abs(N1-N2)+abs(N2-N3)+abs(N3-N1))/3.


member1(X, [X|_]).
member1(X, [_|L]):- member1(X, L).

len1([], 0).
len1([_|L], N):- len1(L, N1), N is N1 + 1.