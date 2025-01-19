% Да се дефинира на пролог предикат q(N, [Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]),
% който по дадено естествено число N генерира координатите на върховете на
% всички правоъгълници ABCD в равнината (AB‖DC‖−→ Ox и AD‖BC‖−→ Oy),
% чиито координати са естествени числa и:
% I.1 периметъра им е N .
% I.2 лицето им е N .


% разпознаватели
is_rectangle([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]):-
    Ax is Dx, Ay is By, Bx is Cx, Dy is Cy.

q1_r(N, [Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]):-
    nat1(Ax), nat1(Ay), nat1(Bx), nat1(By), nat1(Cx), nat1(Cy), nat1(Dx), nat1(Dy),
    is_rectangle([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]),
    Width is Bx - Ax, Height is Dy - Ay, N is (2 * Width) + (2 * Height).

q2_r(N, [Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]):- 
    nat(Ax), nat(Ay), nat(Bx), nat(By), nat(Cx), nat(Cy), nat(Dx), nat(Dy),
    is_rectangle([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]),
    Width is Bx - Ax, Height is Dy - Ay, N is (Width * Height).



q1(N, [Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]):-
    gen_rectangle([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]),
    Width is Bx - Ax, Height is Dy - Ay, N is (2 * Width) + (2 * Height).

q2(N, [Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]):-
    gen_rectangle([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]),
    Width is Bx - Ax, Height is Dy - Ay, N is (Width * Height).


gen_rectangle([Ax, Ay], [Bx, By], [Cx, Cy], [Dx, Dy]):-
    gen_pair([Cx, Cy]),
    between1(Ax, 0, Cx), between1(Ay, 0, Cy),
    Bx is Cx, By is Ay,
    Dx is Ax, Dy is Cy,
    Bx - Ax > 0, Cx - Dx > 0, Dy - Ay > 0, Cy - By > 0.
    
gen_pair([A, B]):- nat1(N), between1(B, 0, N), A is N - B.

nat1(0).
nat1(N):- nat1(N1), N is N1 + 1.

between1(A, A, B):- A =< B.
between1(X, A, B):- A < B, A1 is A + 1, between1(X, A1, B).

