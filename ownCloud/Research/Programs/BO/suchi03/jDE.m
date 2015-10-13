function [xg,gbest_obj] = jDE(myfun,nonlcon,upfun,x0,xl,xu,Gene)
% function [xg,gbest_obj,gbest_subj,ghist] = jDE(myfun,nonlcon,upfun,x0,xl,xu,Gene)
% 制約条件がないため，この部分を変更しています
% -----------------------------------------------------------
%  [xg,gbest_obj,gbest_subj,ghist] = jDE(myfun,nonlcon,upfun,x0,xl,xu,Gene)
%
%   Description:
%     Self-adaptive differential evolution (jDE) algorithm
%     jDE algorithm controls automatically two parameters
%       + amplification parameter : F
%       + crossover coeficcient   : CR
%
%   Input:
%     myfun        : objective(f) & constraint(g) function
%                     ex) myfun   = @objectfun,  [f,g] = myfun(x)
%     nonlcon      : convert function (constraint -> unconstraint)
%                     ex) nonlcon = @penalty,    L = nonlcon(f,g)
%     upfun        : jDE updating algorithm
%                     ex) upfun = @jDEupdate_rand : DE/rand/1/bin
%                         upfun = @jDEupdate_best : DE/rand/1/best
%     x0   (N * M) : initial population
%     xl   (M * 1) : lower limits of x
%     xu   (M * 1) : upper limits of x
%     Gene (1 * 1) : number of jDE process iterations
%
%   Output:
%    xg         (M * 1)    : solution (final global best)
%    gbest_obj  (1 * 1)    : objective function of global best
%    gbest_subj (1 * C)    : objective function of global best
%    ghist      (Gene * 1) : global best history
%
%   Nomenclature:
%    N    : number of samples
%    M    : number of variables
%    C    : number of elements of a subject function
%    Gene : number of generations
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 07, 2015
%                                  Updated, May  01, 2015
% -----------------------------------------------------------

%%% Declear variables %%%
% get matrix size
[N,~] = size(x0);
ghist = zeros(Gene,1);
f     = zeros(N,1);
% parameters of jDE
Lag   = inf(N,1);
F     = repmat(0.7,N,1);
CR    = repmat(0.9,N,1);
Fl    = 0.1;
Fu    = 0.9;
tau   = 0.10;
% choose constraint function type (initial setting: penalty method)
if isempty(nonlcon)
  nonlcon = @penalty;
end

%%% Evaluate initaial populations %%%
x = x0;
for n = 1 : N
%   [ f(n), g(n,:) ] = feval(myfun,x(n,:));
%   Lag(n)           = feval(nonlcon, f(n), g(n,:));
Lag(n) = feval(myfun,x(n,:));  % 制約条件がないため，この部分を変更しています
end
% search global best: gbest
[gbest, gpos] = min(Lag);
xg            = x(gpos,:);
ghist(1)      = gbest;

%%% Update individuals %%%
for gene = 2 : Gene
  % update population including evaluating process
  [x,Lag,F,CR] = ...
     feval(upfun,myfun,nonlcon,x,xl,xu,Lag,xg,gpos,F,CR,Fl,Fu,tau);
  % search global best: gbest
  [gbest,gpos] = min(Lag);
  xg           = x(gpos,:);
  ghist(gene)  = gbest;
end

% evaluating final global best
% [ gbest_obj, gbest_subj ] = feval(myfun,xg);  % 制約条件がないため，この部分を変更しています
gbest_obj = feval(myfun,xg);




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