 % Olexandr Matveyev
 % CSCI 305 Prolog Lab 2

% -------------------------------------------------------------------------------------
 % [:-] --> if
 % [,] --> and 
 % [;] --> else/or
% -------------------------------------------------------------------------------------

%consult('royal.pl').

% will return M, where M is mother of C
mother(M,C) :- parent(M,C), female(M).

% will return M, where M is father of C
father(M,C) :- parent(M,C), male(M).

% IF C == male then married(C,M) else if C == female then married(M,C)
spouse(M,C) :- married(C,M), female(M); married(M,C), male(M).

% will return X, where X is son or daughter of Y
child(X, Y) :- son(X, Y); daughter(X, Y).

% will return X, where X is son of Y
son(X, Y) :- parent(Y, X), male(X).

% will return X, where X is daughter of Y
daughter(X, Y) :- parent(Y, X), female(X).

% will return X, where X is sibling of Y
% 1: find parent M by Y
% 2: find child of M
% 3: if X != Y return X
sibling(X, Y) :- parent(M, Y), parent(M, X), not(X = Y).

% will return X, where X is brother of Y
% 1: find parent C by Y
% 2: find child of C
% 3: if X != Y and X is male return X
brother(X, Y) :- parent(C, Y), parent(C, X), not(X = Y), male(X).

% will return X, where X is sister of Y
% 1: find parent C by Y
% 2: find child of C
% 3: if X != Y and X is female return X  
sister(X, Y) :- parent(C, Y), parent(C, X), not(X = Y), female(X).

% will return X, where X is cousin of Y
% the cousin function will utilize sibling and child functions
cousin(X, Y) :- parent(P, Y), sibling(C, P), child(X, C).

% by blood
% 1: find P by Y
% 2: utilize sibling function to find sibling of P
% 3: return X if X is male
uncle(X, Y) :- parent(P, Y), sibling(X, P), male(X).

% by marriage
% 1: find parent P by Y
% 2: find spouse of P
% 3: utilize sibling function to find sibling of M
% 4: return X if X is male
uncle(X, Y) :- parent(P, Y), spouse(M, P), sibling(X, M), male(X).

% by blood
% 1: find parent P by Y
% 2: utilize sibling function to find sibling of P
% 3: return X if X is female
aunt(X, Y) :- parent(P, Y), sibling(X, P), female(X).

% by marriage
% 1: find parent P by Y
% 2: find spouse of P
% 3: utilize sibling function to find sibling of M
% 4: return X if X is female
aunt(X, Y) :- parent(P, Y), spouse(M, P), sibling(X, M), female(X).

% 1: find grandparent X by utilize parent
grandparent(X, Y) :- parent(P, Y), parent(X, P).

% 1: find grandparent by utilize grandparent function
% 2: return X if X is male
grandfather(X, Y) :- grandparent(X, Y), male(X).

% 1: find grandparent by utilize grandparent function
% 2: return X if X is female
grandmother(X, Y) :- grandparent(X, Y), female(X).

% 1: find 1'st child by Y
% 2: find 2'nd child by C
% 3: return X
grandchild(X,Y) :- child(C, Y), child(X, C).

% 1: find parent X by Y
% 2: return parent X
ancestor(X, Y) :- parent(X, Y).

% 1: utilize parent to find parent Z of Y
% 2: utilize ancestor to find parent X of Z
% 3: return ancestor X
ancestor(X, Y) :- parent(Z, Y), ancestor(X, Z).

% 1: find child X by Y
% 2: return child X
descendant(X, Y) :- child(X, Y).

% 1: utilize child function to find child Z of Y
% 2: utilize descendant to find child X of Z
% 3: return descendant X
descendant(X, Y) :- child(Z, Y), descendant(X, Z).

% 1: find birth date of X where A is birth date/year
% 2: find birth date of Y where B is birth date/year
% 3: compere A to B
% if A > B then pirnt X and return true else will return false
older(X,Y) :- born(X, A), born(Y, B), (A > B), write(X).

% 1: find birth date of X where A is birth date/year
% 2: find birth date of Y where B is birth date/year
% 3: compere A to B
% if A < B then pirnt X and return true else will return false
younger(X,Y) :- born(X, A), born(Y, B), (A < B), write(X).

% 1: find birth date of Y where D is birth date/year
% 2: compare D to the "reigned start year" and "reigned end year" with all reigned records
% 3: if comparison rules matches with reigned dates return X
regentWhenBorn(X,Y) :- born(Y, D), reigned(_, A, B), (D >= A) , (D =< B), reigned(X,A,B).