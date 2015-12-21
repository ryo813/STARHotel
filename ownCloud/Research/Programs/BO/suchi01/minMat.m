function [minval,row,col] = minMat(A)
% ------------------------------------------------------------
%  [minval,row,col] = minMat(A)
%
%  Description:
%    sarch minimum point at A matrix
%
%  Input:
%    A       (N * M) : input matrix
%
%  Output:
%    minval  (1 * 1) : value at minimum point of matrix A
%    row     (1 * 1) : row number at minimum point
%    col     (1 * 1) : column number at minimum point
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 07, 2015
% ------------------------------------------------------------

%%% judge whether A is vector or not %%%
[N, M] = size(A);
if N == 1
  row = 1;
  [minval, col] = min(A);
elseif M == 1
  col = 1;
  [minval, row] = min(A);

%%% search mimimum point %%%
else
  % search minimum value at each row
  [rowmin_vec, row_vec] = min(A);
  % search minimum value of all
  [~, col] = min(rowmin_vec);
  % derive row number at minimum point
  row      = row_vec(col);
  % derive minimum value
  minval   = A(row,col);
end



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