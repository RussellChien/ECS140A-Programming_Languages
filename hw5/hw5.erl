-module(hw5).

-export([
    myremoveduplicates/1, 
    myintersection/2,
    mylast/1,
    myreverse/1,
    myreplaceall/3
]).

% base case
myremoveduplicates([]) ->
    [];
% remove duplicates from the tail of the list
myremoveduplicates([Head | Tail]) ->
    % if Head is present in Tail, skip, otherwise keep 
    case lists:member(Head, Tail) of
        true ->
            myremoveduplicates(Tail);
        false ->
            [Head | myremoveduplicates(Tail)]
    end.

myintersection(List1, List2) when is_list(List1), is_list(List2) ->
    myintersection(List1, List2, []).
% base case
myintersection([], _List2, Acc) ->
    lists:reverse(Acc);
myintersection([H | T], List2, Acc) ->
    % if the head is a member of List2, add H to acc, otherwise skip
    case lists:member(H, List2) of
        true -> myintersection(T, List2, [H | Acc]);
        false -> myintersection(T, List2, Acc)
    end.

% base cases
mylast("") ->
    "";
mylast([]) ->
    [];
% last element in list
mylast([Last]) ->
    [Last];
% keep moving down the list
mylast([_ | Tail]) ->
    mylast(Tail).

myreverse(List) when is_list(List) ->
    myreverse(List, []).
% base case
myreverse([], Acc) ->
    Acc;
% recursively call myreverse with the tail of the list and the current head added to acc
myreverse([Head | Tail], Acc) ->
    myreverse(Tail, [Head | Acc]).

% base case
myreplaceall(_, _, []) ->
    [];  
% replace Old with New 
myreplaceall(New, Old, [Old|Tail]) ->
    [New | myreplaceall(New, Old, Tail)];  
% keep the current element in the list 
myreplaceall(New, Old, [Head|Tail]) ->
    [Head | myreplaceall(New, Old, Tail)].  