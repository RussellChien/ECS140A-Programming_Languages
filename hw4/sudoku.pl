% Russell Chien 919359868

% This runs all the simple tests.
test :-
    test0, nl,
    test0a, nl,
    test0b, nl,
    test0c.

% This is a completely solved solution.
test0 :-
    L = [
        [9,6,3,1,7,4,2,5,8],
        [1,7,8,3,2,5,6,4,9],
        [2,5,4,6,8,9,7,3,1],
        [8,2,1,4,3,7,5,9,6],
        [4,9,6,8,5,2,3,1,7],
        [7,3,5,9,6,1,8,2,4],
        [5,8,9,7,1,3,4,6,2],
        [3,1,7,2,4,6,9,8,5],
        [6,4,2,5,9,8,1,7,3]],
    sudoku(L),
    printsudoku(L).

% This has a solution (the one in test0) which should be found very quickly.
test0a :-
    L = [
        [9,_,3,1,7,4,2,5,8],
        [_,7,_,3,2,5,6,4,9],
        [2,5,4,6,8,9,7,3,1],
        [8,2,1,4,3,7,5,_,6],
        [4,9,6,8,5,2,3,1,7],
        [7,3,_,9,6,1,8,2,4],
        [5,8,9,7,1,3,4,6,2],
        [3,1,7,2,4,6,9,8,5],
        [6,4,2,5,9,8,1,7,3]],
    sudoku(L),
    printsudoku(L).

% This has a solution (the one in test0) and may take a few seconds to find.
test0b :-
    L = [
        [9,_,3,1,7,4,2,5,_],
        [_,7,_,3,2,5,6,4,9],
        [2,5,4,6,_,9,_,3,1],
        [_,2,1,4,3,_,5,_,6],
        [4,9,_,8,_,2,3,1,_],
        [_,3,_,9,6,_,8,2,_],
        [5,8,9,7,1,3,4,6,2],
        [_,1,7,2,_,6,_,8,5],
        [6,4,2,5,9,8,1,7,3]],
    sudoku(L),
    printsudoku(L).

% This one obviously has no solution (column 2 has two nines in it.)
% and it may take a few seconds to deduce this.
test0c :-
    L = [
        [_,9,3,1,7,4,2,5,8],
        [_,7,_,3,2,5,6,4,9],
        [2,5,4,6,8,9,7,3,1],
        [8,2,1,4,3,7,5,_,6],
        [4,9,6,8,5,2,3,1,7],
        [7,3,_,9,6,1,8,2,4],
        [5,8,9,7,1,3,4,6,2],
        [3,1,7,2,4,6,9,8,5],
        [6,4,2,5,9,8,1,7,3]],
    sudoku(L),
    printsudoku(L).

% print sudoku table
printsudoku([]).
printsudoku([H|T]) :-
    printrow(H),
    nl,
    printsudoku(T).

% Expects a list of lists 9 by 9 grid.
sudoku(Grid) :-
    valid_rows(Grid),           % validate rows 
    transpose(Grid, Columns),   % transpose so we can validate columns 
    valid_columns(Columns),     % validate columns
    valid_subgrids(Grid),       % validate subgrids
    flatten(Grid, FlatGrid),    % flatten grid to list for solving
    valid_nums(FlatGrid),       % validate all numbers are 1-9
    solve([], FlatGrid).        % solve sudoku

% Helper predicate to print a row
printrow([]).
printrow([H|T]) :-
    write(H),
    write(' '),
    printrow(T).

% Helper predicate to validate rows
valid_rows([]).
valid_rows([Row|Rest]) :-
    valid_nums(Row),
    all_diff(Row),
    valid_rows(Rest).

% Helper predicate to validate columns
valid_columns([]).
valid_columns([Col|Rest]) :-
    valid_nums(Col),
    all_diff(Col),
    valid_columns(Rest).

% Helper predicate to validate subgrids
valid_subgrids(Grid) :-
    valid_subgrids_rows(Grid, 1, 1).

% Helper predicate to validate subgrid rows
valid_subgrids_rows([], _, _).
valid_subgrids_rows([H|T], Row, Col) :-
    valid_subgrids_cols(H, Row, Col),       
    NextRow is Row + 3,
    valid_subgrids_rows(T, NextRow, Col).

% Helper predicate to validate subgrid columns
valid_subgrids_cols([], _, _).
valid_subgrids_cols([H1,H2,H3|T], Row, Col) :-
    Subgrid = [H1,H2,H3],
    valid_nums(Subgrid),
    all_diff(Subgrid),
    NextCol is Col + 3,
    valid_subgrids_cols(T, Row, NextCol).

% Helper predicate to ensure all elements are 1-9
valid_nums([]).
valid_nums([X|Xs]) :-
    between(1, 9, X),
    valid_nums(Xs).

% Helper predicate to ensure all elements are distinct
all_diff([]).
all_diff([X|Xs]) :- \+ memberchk(X, Xs), all_diff(Xs).

% Helper predicate to transpose a matrix 
transpose([], []).
transpose([[]|_], []).
transpose(Matrix, [Row|Rows]) :-
    extract_column(Matrix, Row, RestMatrix),
    transpose(RestMatrix, Rows).

% Helper predicate that extracts a column for transposing 
extract_column([], [], []).
extract_column([[X|Xs]|Rows], [X|Col], [Xs|RestRows]) :-
    extract_column(Rows, Col, RestRows).

% Helper predicate to solve the sudoku 
solve([], _).
solve([Var|Vars], Domain) :-
    member(Var, Domain),
    solve(Vars, Domain).
