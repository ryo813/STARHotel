function F = penalty(f,g)
% -----------------------------------------------------------------
%  F = penalty(f,g)
%
%  Desctiption:
%    constrained function converts into un-constriand function
%      by using exact penalty function method
%
%  Input:
%     f   (1 * 1)  :  objective function
%     g   (1 * L)  :  inequality function
%
%  Output:
%    F (1 * 1)  : unconstrained function
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 09, 2015
% -----------------------------------------------------------------

%%% setting %%%
R = 1e10;  % penalty parameter 1
q = 1;     % penalty parameter 2
L = length(g);

%%% calculate sub-objective function using penalty method %%%
F    = f + R * sum( max([ g; zeros(1,L) ]) ) ^ q;



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