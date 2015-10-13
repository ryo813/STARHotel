function out = RandRange(Min, Max, N, M)
% --------------------------------------------------------------
%  out = RandRange(Min, Max, N, M)
%
%  Description:
%    Generate a uniform random matrix between Min and Max
%
%  Input:
%     Min   (1 * 1)  :  Minimum Value
%     Max   (1 * 1)  :  Maximum Value
%     N     (1 * 1)  :  row number
%     M     (1 * 1)  :  column number
%
%  Output:
%     out   (N * M)  :  Random Matrix in desired range
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 07, 2015
% --------------------------------------------------------------

%%% setting %%%
if nargin < 3
	N = 1;
	M = 1;
end

%%% generate uniform random matrix
Temp = randi(10000, N, M);
Temp = Temp * (Max-Min)/10000;
out  = Temp + Min;



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