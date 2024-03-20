% shuffle (L1, L2, L3)
% returns true if list L3 is the result combining lists L1 and L2 such that the first
% element of L3 is the first element of L1, the second element of L3 is the first element of
% L2, the third element of L3 is the second element of L1, and so on
shuffle([], [], []).
shuffle([H1|T1], [H2|T2], [H1,H2|T3]) :-
    shuffle(T1, T2, T3).

% double (L1, L2)
% returns true if every element in list L1 appears twice in L2
double([], []).
double([H|T1], [H,H|T2]) :-
    double(T1, T2).

% no_duplicates (L1, L2)
% returns true if list L2 is the result of removing all duplicate elements from list L1
no_duplicates([], []).
% add duplicate 
no_duplicates([H | T1], [H | T2]) :-
    \+ member(H, T1),
    no_duplicates(T1, T2).
% skip duplicate
no_duplicates([H | T1], T2) :-
    member(H, T1),
    no_duplicates(T1, T2).

% same_elements (L1, L2)
% returns true if lists L1 and L2 contain exactly the same elements, although
% possibly in different order
same_elements([], []).
same_elements([H | T1], T2) :-
    member(H, T2),
    remove_first_occurrence(H, T2, Rest),
    same_elements(T1, Rest).
% helper function to remove first occurence of an element from the list 
remove_first_occurrence(_, [], []).
remove_first_occurrence(E, [E | T], T).
remove_first_occurrence(E, [H | T1], [H | T2]) :-
    E \= H,
    remove_first_occurrence(E, T1, T2).


