/* YOUR CODE HERE (Problem 1, delete the following line) */
% reverseL(X,RevX) :- 

reverseL([],[]).
reverseL([H|T],L):-
    reverseL(T,R),
    append(R,[H],L).

?- reverseL([],X).
?- reverseL([1,2,3],X).
?- reverseL([a,b,c],X).

/* YOUR CODE HERE (Problem 2, delete the following line) */
% remove_duplicates(List1,List2) :- 

del(_, [], []) :- !.
del(X, [X|X1], Y) :- !, del(X, X1, Y).
del(X, [T|X1], Y) :- !, del(X, X1, Y2), append([T], Y2, Y).


remove_duplicates([], []).
remove_duplicates([X|Y], Z):- del(X, Y, Y1), remove_duplicates(Y1, Z1), append([X], Z1, Z).

remove_duplicates([], []).
remove_duplicates([X|Y], Z):- del(X, Y, Y1), remove_duplicates(Y1, Z1), append([X], Z1, Z).


?- remove_duplicates([1,2,3,4,2,3],X).
?- remove_duplicates([1,4,5,4,2,7,5,1,3],X).
?- remove_duplicates([], X).

/* Your CODE HERE (Problem 3, delete the following line) */
% assoc_list(L,AL) :- false.

count_var(X, [], (X-1)).
count_var(X, [H|T], (X-Times)) :- X=H, count_var(X,T,(X-V)), Times is V+1.
count_var(X, [_|T], (X-Times)) :- count_var(X,T,(X-Times)).

assoc_list(List, X) :- assoc_list(List, [], [], As), reverseL(As, X).
assoc_list([],Acc,_, Acc).
assoc_list([H|T],Acc, Acc2, As):- not(member(H, Acc2))->  count_var(H,T,X), assoc_list(T, [X|Acc], [H|Acc2], As); assoc_list(T, Acc, Acc2, As).

?- assoc_list([1], [1-1]).
?- assoc_list([1,1,2,2,2,3,1], [1-3, 2-3, 3-1]).
?- assoc_list([1,1,4,2,2,2,3,1,1,3,1], X).

/* YOUR CODE HERE (Problem 4, delete the following line) */

% intersectionL(List1,List2,L3) :- false.

intersection([], _, []):- !. 

intersection(_, [], []):- !. 

intersection([X|T1], List2, [X|T3]):- member(X, List2), intersection(T1, List2, T3), !.

intersection([_|T1], List2, List3):- intersection(T1, List2, List3).

?- intersectionL([1,2,3,4],[1,3,5,6],[1,3]).
?- intersectionL([1,2,3,4],[1,3,5,6],X).
?- intersectionL([1,2,3],[4,3],[3]).

/* YOUR CODE HERE (Problem 5, delete the following line) */
% maxL3(L,X) :- false.

maxlist([], R, R). %end
maxlist([X|Xs], WK, R):- X >  WK, maxlist(Xs, X, R). 
maxlist([X|Xs], WK, R):- X =< WK, maxlist(Xs, WK, R).
maxlist([X|Xs], R):- maxlist(Xs, X, R).

len([],0).
len([H | T], N) :- len(T,Mer), N is Mer+1.

filter([H|T],H,T).
filter([H|T],R,[H|S]) :- filter(T,R,S).


maxL3(L, X) :- len(L, N), N >= 3, maxlist(L, Max1), filter(L, Max1, List2), maxlist(List2, Max2), filter(List2, Max2, L3), maxlist(L3, Max3), X is Max1 + Max2 + Max3.  


?- not(maxL3([1], X)).
?- maxL3([1,2,3,4], 9).
?- maxL3([10,3,2,3,10], X).

% prefix(P,L) :- append(P,_,L).
% suffix(S,L) :- append(_,S,L).

/* YOUR CODE HERE (Problem 6, delete the following line) */
% partition(L,P,S) :- false.

prefix(P,L) :- append(P,X,L).                                                       
suffix(S,L) :- append(X,S,L). 

X=[a,b]
Y=[c,d]

partition([],[],[]).
partition([H],[H],[]).
partition(L, P, S) :-
    length(L, N),
    Plen is div(N,2),
    Slen is N-div(N,2),
    length(Pre, Plen),
    length(Suff, Slen),
    prefix(Pre, L),
    suffix(Suff, L),
    P is Pre,
    S is Suff.

?- partition([a],[a],[]).
?- partition([1,2,3],[1],[2,3]).
?- partition([a,b,c,d],X,Y).

/* YOUR CODE HERE (Problem 7, delete the following line) */
% merge(X,Y,Z) :- false.
% base case
merge([], [], []):- !. 
merge(List1, [], List1):- !. 
merge([], List2, List2):- !. 

merge([X|List1], [Y|List2], Z):- X<Y, merge(List1, [Y|List2], Z1), append([X], Z1, Z), !.
merge(List1, [Y|List2], Z):- merge(List1, List2, Z1), append([Y], Z1, Z).


?- merge([],[1],[1]).
?- merge([1],[],[1]).
?- merge([1,3,5],[2,4,6],X).

/* YOUR CODE HERE (Problem 8, delete the following line) */
% mergesort(L,SL) :- false.


mergesort([],[]).
mergesort([A],[A]).
mergesort([A,B|R],S) :- splitting_at_aks([A,B|R],List1,List2), mergesort(List1,S1), mergesort(List2,S2), merge(S1,S2,S).

splitting_at_aks([],[],[]).
splitting_at_aks([A],[A],[]).
splitting_at_aks([A,B|R],[A|Resta],[B|Restb]) :- splitting_at_aks(R,Resta,Restb).

merging_accusi(A,[],A).
merging_accusi([],B,B).
merging_accusi([A|Resta],[B|Restb],[A|Mer]) :- A @=< B, merging_accusi(Resta,[B|Restb],Mer).
merging_accusi([A|Resta],[B|Restb],[B|Mer]) :- A @> B, merging_accusi([A|Resta],Restb,Mer).

?- mergesort([3,2,1],X).
?- mergesort([1,2,3],Y).
?- mergesort([],Z).




