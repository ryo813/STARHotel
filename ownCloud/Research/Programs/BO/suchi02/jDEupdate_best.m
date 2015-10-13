function [X,Lag,F,CR] = jDEupdate_best(myfun,nonlcon,X,xl,xu,Lag,xg,gpos,F,CR,Fl,Fu,tau)
% -----------------------------------------------------------
%  [X,Lag,F,CR] = jDEupdate_best(myfun,nonlcon,X,Lag,xg,gpos,F,CR,Fl,Fu,tau);
%
%   Description:
%     Self-adaptive differential evolution (jDE) algorithm
%     The DE/1/bin/best stratege is used.
%     jDE algorithm controls automatically two parameters
%       + amplification parameter : F
%       + crossover coeficcient   : CR
%     This function focused on update processes:
%       + Mutation   ...  generate mutant vector
%       + Crossover  ...  generate trial vector
%       + Selection  ...  generate next-generation vector
%
%   Input:
%     myfun        : objective(f) & constraint(g) function
%                     ex) myfun   = @objectfun,  [f,g] = myfun(x)
%     nonlcon      : convert function (constraint -> unconstraint)
%                     ex) nonlcon = @penalty,    L = nonlcon(f,g)
%     X    (N * M) : population
%     xl   (M * 1) : lower limits of x
%     xu   (M * 1) : upper limits of x
%
%   Output:
%    xg    (M * 1) : solution (final global best)
%    gbest (1 * 1) : objective function of global best
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., June. 10, 2015
% -----------------------------------------------------------

%%% setting %%%
[N,M] = size(X);

%%% update parameters: F and CR based on jDE %%%
Findex      =  rand(N,1) < tau;
CRindex     =  rand(N,1) < tau;
F(Findex)   =  repmat(Fl,sum(Findex),1) + Fu*rand(sum(Findex),1);
CR(CRindex) =  rand(sum(CRindex),1);


%%% Mutation process %%%
%%% generate mutant vectors: Mut %%%
% initialize
r1     = randi(N,N,1);
r2     = randi(N,N,1);
index  = [ 1 : N ]';
flag   = 1;
while flag  % if (flag > 0) -> again
  % search not using condition
  index_r1 = r1==gpos | r1==index | r1==r2;
  index_r2 = r2==gpos | r2==index;
  % sum of each vector
  pr1 = sum(index_r1);
  pr2 = sum(index_r2);
  % re-allocate random number based on uniform random number
  r1(index_r1) = randi(N, pr1, 1);
  r2(index_r2) = randi(N, pr2, 1);
  % sum the number of re-allocating times
  flag  = pr1 + pr2;
end
% derive mutant vectors: Mut
Mut   = repmat(xg,N,1) + repmat(F,1,M) .* ( X(r1,:) - X(r2,:) );
% Bounce-back method to confine the mutant vectors within boundary space
for n = 1 : N
  x        = X(n,:);
  v        = Mut(n,:);
  xbase    = xg;
  Mut(n,:) = bounceback(x,v,xbase,xl,xu);
end


%%% Crossover process %%%
%%% generate trial vectors: Tri %%%
% initialize
Tri = X;
jr = randi(M,N,1);
% cross over procedure
for m = 1 : M
  % taking over conditions
  index1  =  rand(N,1) <= CR;
  index2  =  (jr == m);
  % take over from mutant vector to trial vector
  %  if any conditions are satisfied
  Tri(index1,m) = Mut(index1,m);
  Tri(index2,m) = Mut(index2,m);
end

%%% Selection process %%%
%%% generate next-generation vector: Xnext %%%
% evaluating traial vector -> tri
for n = 1 : N
%   [ tri.f(n), tri.g(n,:) ] = feval(myfun, Tri(n,:));
%   tri.Lag(n,1)             = feval(nonlcon, tri.f(n), tri.g(n,:));
tri.Lag(n,1) = feval(myfun, Tri(n,:));  % §–ñğŒ‚ª‚È‚¢‚½‚ßC‚±‚Ì•”•ª‚ğ•ÏX‚µ‚Ä‚¢‚Ü‚·
end
% selection procedure
% compare old-generation vectors with trial vectors
ex_index  =  tri.Lag < Lag;
% exchange old-generation vector for trial vector
%  if trial vector is sperior to old-generation vector
X(ex_index,:) = Tri(ex_index,:);
Lag(ex_index) = tri.Lag(ex_index);




% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Copyright (c) 2015. The Human Systems Laboratory,
% Department of Systems Science, Graduated School of Informatics,
% Kyoto University (HSL).
% All rights reserved.
% Republication or redistribution is prohibited without the prior
% written consent of HSL.
%
% IN NO EVENT SHALL HSL BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
% SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
% ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION.
%
% HSL SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING,
% BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
% FITNESS FOR A PARTICULAR PURPOSE.
% THE SOFTWARE AND ACCOMPANYING DOCUMENTATION,
% IF ANY, PROVIDED HEREUNDER IS PROVIDED "AS IS".
% HSL HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT,
% UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++