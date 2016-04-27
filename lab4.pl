% CSCI 305, Lab 4
% First_name Last_name
% Partner: First_name Last_name

% The following is a Weighted graph with 9 nodes
% Each edge is given as (i,j,Weight), with Weight > 0.

edge(1,2,1.6).
edge(1,3,1.5).
edge(1,4,2.2).
edge(1,6,5.2).
edge(2,3,1.4).
edge(2,5,2.1).
edge(2,9,5.1).
edge(3,4,1.4).
edge(3,5,1.3).
edge(4,5,1.3).
edge(4,7,1.2).
edge(4,8,3.0).
edge(5,6,1.6).
edge(5,7,1.7).
edge(6,7,1.8).
edge(6,8,2.2).
edge(6,9,1.7).
edge(7,8,1.6).
edge(8,9,1.8).

%you code will start from here

% Modified example 8 code.
% Added weight
connected(X,Y,Weight) :- edge(X,Y,Weight) ; edge(Y,X,Weight).

% Determine a path between A and B
path(A,B,Path,Length) :-
       travel(A,B,[A],Q,Length), 
       reverse(Q,Path).


travel(A,B,P,[B|P],Length) :- 
       connected(A,B,Length).

% Go through paths and determine total legnth by adding weight of edge to subpath's length
travel(A,B,Visited,Path,Length) :-
       connected(A,C,Weight),           
       C \== B,
       \+member(C,Visited),
       travel(C,B,[C|Visited],Path,SubLength),
       Length is Weight+SubLength.  

% Find shortest path
% Find all paths using path
% use setof/3 to remove duplicates
% False on an empty set
% Otherwise, use bestpath to determine which path of the set is the shortest.
shortest(A,B,Path,Length) :-
   setof([Path,Length],path(A,B,Path,Length),Set),
   Set = [_|_],
   bestpath(Set,[Path,Length]).

% Determine best path of the set
bestpath([Head|Tail],CurrentPath) :- best(Tail,Head,CurrentPath).

% Compare lengths of paths

best([],CurrentPath,CurrentPath).
best([[Path,Length]|RemainPaths],[_,CurrentPath],Min) :- Length < CurrentPath, !, best(RemainPaths,[Path,Length],Min). 
best([_|RemainPaths],CurrentPath,Min) :- best(RemainPaths,CurrentPath,Min).