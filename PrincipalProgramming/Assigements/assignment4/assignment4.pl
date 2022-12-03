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
% remove_duplicates(L1,L2) :- 

delMember(_, [], []) :- !.
delMember(X, [X|X1], Y) :- !, delMember(X, X1, Y).
delMember(X, [T|X1], Y) :- !, delMember(X, X1, Y2), append([T], Y2, Y).

% %predicate to delete duplicates from the list
remove_duplicates([], []).
remove_duplicates([X|Y], Z):- delMember(X, Y, Y1), remove_duplicates(Y1, Z1), append([X], Z1, Z).

remove_duplicates([], []).
remove_duplicates([X|Y], Z):- delMember(X, Y, Y1), remove_duplicates(Y1, Z1), append([X], Z1, Z).


?- remove_duplicates([1,2,3,4,2,3],X).
?- remove_duplicates([1,4,5,4,2,7,5,1,3],X).
?- remove_duplicates([], X).

/* Your CODE HERE (Problem 3, delete the following line) */
% assoc_list(L,AL) :- false.



count(X, [], (X-1)).
count(X, [H|T], (X-Times)) :- X=H, count(X,T,(X-V)), Times is V+1.
count(X, [_|T], (X-Times)) :- count(X,T,(X-Times)).

assoc_list(List, X) :- assoc_list(List, [], [], As), reverseL(As, X).
assoc_list([],Acc,_, Acc).
assoc_list([H|T],Acc, Acc2, As):- not(member(H, Acc2))->  count(H,T,X), assoc_list(T, [X|Acc], [H|Acc2], As); assoc_list(T, Acc, Acc2, As).

?- assoc_list([1], [1-1]).
?- assoc_list([1,1,2,2,2,3,1], [1-3, 2-3, 3-1]).
?- assoc_list([1,1,4,2,2,2,3,1,1,3,1], X).

/* YOUR CODE HERE (Problem 4, delete the following line) */

% intersectionL(L1,L2,L3) :- false.
intersection([], _, []):- !. %if first list is empty
intersection(_, [], []):- !. %if second list is empty
%if X is an element in first list and second list, we add it to third list
intersection([X|T1], L2, [X|T3]):- member(X, L2), intersection(T1, L2, T3), !.
%else, we recurse with X removed from first list
intersection([_|T1], L2, L3):- intersection(T1, L2, L3).

?- intersectionL([1,2,3,4],[1,3,5,6],[1,3]).
?- intersectionL([1,2,3,4],[1,3,5,6],X).
?- intersectionL([1,2,3],[4,3],[3]).

/* YOUR CODE HERE (Problem 5, delete the following line) */
% maxL3(L,X) :- false.

maxlist([], R, R). %end
maxlist([X|Xs], WK, R):- X >  WK, maxlist(Xs, X, R). %WK is Carry about
maxlist([X|Xs], WK, R):- X =< WK, maxlist(Xs, WK, R).
maxlist([X|Xs], R):- maxlist(Xs, X, R). %start

len([],0).
len([H | T], N) :- len(T,M), N is M+1.

filter([H|T],H,T).
filter([H|T],R,[H|S]) :- filter(T,R,S).



maxL3(L, X) :- len(L, N), N >= 3, maxlist(L, Max1), filter(L, Max1, L2), maxlist(L2, Max2), filter(L2, Max2, L3), maxlist(L3, Max3), X is Max1 + Max2 + Max3.  


?- not(maxL3([1], X)).
?- maxL3([1,2,3,4], 9).
?- maxL3([10,3,2,3,10], X).

prefix(P,L) :- append(P,_,L).
suffix(S,L) :- append(_,S,L).

/* YOUR CODE HERE (Problem 6, delete the following line) */
% partition(L,P,S) :- false.

prefix(P,L) :- append(P,X,L).                                                       
suffix(S,L) :- append(X,S,L). 

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
merge([], [], []):- !. %if both lists are empty
merge(L1, [], L1):- !. %if second list is empty
merge([], L2, L2):- !. %if first list is empty
%if first element of first list is less than first element of second list
merge([X|L1], [Y|L2], Z):- X<Y, merge(L1, [Y|L2], Z1), append([X], Z1, Z), !.
%else if first element of second list is less than first element of first list
merge(L1, [Y|L2], Z):- merge(L1, L2, Z1), append([Y], Z1, Z).


?- merge([],[1],[1]).
?- merge([1],[],[1]).
?- merge([1,3,5],[2,4,6],X).

/* YOUR CODE HERE (Problem 8, delete the following line) */
% mergesort(L,SL) :- false.


mergesort([],[]).
mergesort([A],[A]).
mergesort([A,B|R],S) :- split([A,B|R],L1,L2), mergesort(L1,S1), mergesort(L2,S2), merge(S1,S2,S).

split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|Ra],[B|Rb]) :- split(R,Ra,Rb).

merge(A,[],A).
merge([],B,B).
merge([A|Ra],[B|Rb],[A|M]) :- A @=< B, merge(Ra,[B|Rb],M).
merge([A|Ra],[B|Rb],[B|M]) :- A @> B, merge([A|Ra],Rb,M).

?- mergesort([3,2,1],X).
?- mergesort([1,2,3],Y).
?- mergesort([],Z).
