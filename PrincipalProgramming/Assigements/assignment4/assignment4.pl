/* YOUR CODE HERE (Problem 1, delete the following line) */
reverseL(X,RevX) :- false

    reverse(X,[],RevX).    
    reverse([],RevX,RevX).    

    reverse([Head|Tail],List1,List2):-
        reverse(Tail,[Head|List1],List2).

?- reverseL([],X).
?- reverseL([1,2,3],X).
?- reverseL([a,b,c],X).

/* YOUR CODE HERE (Problem 2, delete the following line) */
remove_duplicates(L1,L2) :- false.

?- remove_duplicates([1,2,3,4,2,3],X).
?- remove_duplicates([1,4,5,4,2,7,5,1,3],X).
?- remove_duplicates([], X).

/* Your CODE HERE (Problem 3, delete the following line) */
assoc_list(L,AL) :- false.

?- assoc_list([1], [1-1]).
?- assoc_list([1,1,2,2,2,3,1], [1-3, 2-3, 3-1]).
?- assoc_list([1,1,4,2,2,2,3,1,1,3,1], X).

/* YOUR CODE HERE (Problem 4, delete the following line) */
intersectionL(L1,L2,L3) :- false.

?- intersectionL([1,2,3,4],[1,3,5,6],[1,3]).
?- intersectionL([1,2,3,4],[1,3,5,6],X).
?- intersectionL([1,2,3],[4,3],[3]).

/* YOUR CODE HERE (Problem 5, delete the following line) */
maxL3(L,X) :- false.

?- not(maxL3([1], X)).
?- maxL3([1,2,3,4], 9).
?- maxL3([10,3,2,3,10], X).

prefix(P,L) :- append(P,_,L).
suffix(S,L) :- append(_,S,L).

/* YOUR CODE HERE (Problem 6, delete the following line) */
partition(L,P,S) :- false.

?- partition([a],[a],[]).
?- partition([1,2,3],[1],[2,3]).
?- partition([a,b,c,d],X,Y).

/* YOUR CODE HERE (Problem 7, delete the following line) */
merge(X,Y,Z) :- false.

?- merge([],[1],[1]).
?- merge([1],[],[1]).
?- merge([1,3,5],[2,4,6],X).

/* YOUR CODE HERE (Problem 8, delete the following line) */
mergesort(L,SL) :- false.

?- mergesort([3,2,1],X).
?- mergesort([1,2,3],Y).
?- mergesort([],Z).
